Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTLVUql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 15:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTLVUql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 15:46:41 -0500
Received: from mail.convergence.de ([212.84.236.4]:27840 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264476AbTLVUqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 15:46:37 -0500
Message-ID: <3FE75824.3040402@convergence.de>
Date: Mon, 22 Dec 2003 21:46:28 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Subject: [PATCH][2.6] change two annoying messages from framebuffer drivers
Content-Type: multipart/mixed;
 boundary="------------080008050207070700020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008050207070700020008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the Linux-on-a-CD system Knoppix has nearly all framebuffer drivers for
2.4.23 compiled in. Additionally, it surpresses most kernel messages by
lowering the kernel log level.

Two framebuffer drivers (clgenfb.c and hgafb.c), however, use KERN_ERR
to say that their particular card has *not* been found which is very
annoying.

Especially the clgenfb.c driver simply says on bootup:
  >  Couldn't find PCI device
which can really confuse newbie users.

I've already send a patch that fixes this for 2.4 -- Marcelo and Geert 
Uytterhoeven have already ack'ed it.

The same change should be done for 2.6, too IMHO.

The appended patch replaces two KERN_ERR with KERN_INFO and additionally
makes the cirrusfb.c message more descriptive.

Please apply, thanks!

CU
Michael.


--------------080008050207070700020008
Content-Type: text/plain;
 name="video-fb-shutup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="video-fb-shutup.diff"

diff -ur xx-linux-2.6/drivers/video/clgenfb.c xx-linux-2.6.p/drivers/video/clgenfb.c
--- xx-linux-2.6/drivers/video/cirrusfb.c	2003-06-13 16:51:37.000000000 +0200
+++ xx-linux-2.6.p/drivers/video/cirrusfb.c	2003-12-12 13:48:34.000000000 +0100
@@ -2528,7 +2528,7 @@
 
 	pdev = clgen_pci_dev_get (btype);
 	if (!pdev) {
-		printk (KERN_ERR " Couldn't find PCI device\n");
+		printk (KERN_INFO "cirrusfb: couldn't find Cirrus Logic PCI device\n");
 		DPRINTK ("EXIT, returning 1\n");
 		return 1;
 	}
diff -ur xx-linux-2.6/drivers/video/hgafb.c xx-linux-2.6.p/drivers/video/hgafb.c
--- xx-linux-2.6/drivers/video/hgafb.c	2001-11-12 18:46:25.000000000 +0100
+++ xx-linux-2.6.p/drivers/video/hgafb.c	2003-12-12 13:47:01.000000000 +0100
@@ -539,7 +539,7 @@
 int __init hgafb_init(void)
 {
 	if (! hga_card_detect()) {
-		printk(KERN_ERR "hgafb: HGA card not detected.\n");
+		printk(KERN_INFO "hgafb: HGA card not detected.\n");
 		return -EINVAL;
 	}
 

--------------080008050207070700020008--
