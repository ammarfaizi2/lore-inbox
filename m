Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWJPPB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWJPPB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWJPPB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:01:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26313 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750766AbWJPPBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:01:55 -0400
Subject: [PATCH] rio: fix array checking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:28:44 +0100
Message-Id: <1161012524.24237.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found by an analysis tool and reported to the list. Fix is simple enough

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/char/rio/rioctrl.c linux-2.6.19-rc1-mm1/drivers/char/rio/rioctrl.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/char/rio/rioctrl.c	2006-10-13 15:06:33.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/char/rio/rioctrl.c	2006-10-14 18:55:37.000000000 +0100
@@ -662,7 +662,7 @@
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
-		if (portStats.port >= RIO_PORTS) {
+		if (portStats.port < 0 || portStats.port >= RIO_PORTS) {
 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
 			return -ENXIO;
 		}
@@ -702,7 +702,7 @@
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
-		if (portStats.port >= RIO_PORTS) {
+		if (portStats.port < 0 || portStats.port >= RIO_PORTS) {
 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
 			return -ENXIO;
 		}

