Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUBOHGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUBOHGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:06:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:31133 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264238AbUBOHGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:06:48 -0500
Subject: [PATCH] Fix Oops & warning on PPC in rivafb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076828751.6957.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:05:51 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Independently from the other fbdev updates I'm cooking (some of them will
be in your mailbox rsn), this patch fixes an error in parameter passing
to a function in rivafb (only used on ppc) that could cause an oops and
definitely causes a warning at compile time.

Please apply asap.

Ben.

===== drivers/video/riva/fbdev.c 1.52 vs edited =====
--- 1.52/drivers/video/riva/fbdev.c	Fri Feb 13 03:39:59 2004
+++ edited/drivers/video/riva/fbdev.c	Sun Feb 15 17:12:03 2004
@@ -1615,8 +1615,9 @@
 }
 
 #ifdef CONFIG_PPC_OF
-static int riva_get_EDID_OF(struct riva_par *par, struct pci_dev *pd)
+static int riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 {
+	struct riva_par *par = (struct riva_par *) info->par;
 	struct device_node *dp;
 	unsigned char *pedid = NULL;
 


