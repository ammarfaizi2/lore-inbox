Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbUL0PR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUL0PR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUL0PR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:17:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39067 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261898AbUL0PRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:17:44 -0500
Subject: PATCH: (Discussion) Stop IDE legacy ISA probes on PCI systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104156823.20898.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:13:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't generally want to poke around legacy ISA ide2..ide5 on a system
with PCI , it tends to cause long delays. 

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/include/asm-i386/ide.h linux-2.6.10/include/asm-i386/ide.h
--- linux.vanilla-2.6.10/include/asm-i386/ide.h	2004-12-25 21:13:51.000000000 +0000
+++ linux-2.6.10/include/asm-i386/ide.h	2004-12-26 17:08:27.541915144 +0000
@@ -44,10 +44,14 @@
 	switch (index) {
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
+		
+		if(pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+			case 2: return 0x1e8;
+			case 3: return 0x168;
+			case 4: return 0x1e0;
+			case 5: return 0x160;
+		}
+
 		default:
 			return 0;
 	}

