Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVJUMqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVJUMqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVJUMqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:46:16 -0400
Received: from [81.2.110.250] ([81.2.110.250]:48311 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964926AbVJUMqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:46:15 -0400
Subject: PATCH: Explain the PCI bus test we do in IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 14:14:58 +0100
Message-Id: <1129900498.26367.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox asked that this got a comment explaining why it is done
so here it is.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/ide.h linux-2.6.14-rc4-mm1/include/asm-i386/ide.h
--- linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/ide.h	2005-10-20 16:10:12.000000000 +0100
+++ linux-2.6.14-rc4-mm1/include/asm-i386/ide.h	2005-10-20 16:37:20.000000000 +0100
@@ -41,6 +41,12 @@
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
+	/*
+	 *	If PCI is present then it is not safe to poke around
+	 *	the other legacy IDE ports. Only 0x1f0 and 0x170 are
+	 *	defined compatibility mode ports for PCI. A user can 
+	 *	override this using ide= but we must default safe.
+	 */
 	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
 		switch(index) {
 			case 2: return 0x1e8;

