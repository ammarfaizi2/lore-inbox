Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbTLLM5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 07:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTLLM5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 07:57:52 -0500
Received: from mail.convergence.de ([212.84.236.4]:29322 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264558AbTLLM5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 07:57:49 -0500
Message-ID: <3FD9BB4B.6040900@convergence.de>
Date: Fri, 12 Dec 2003 13:57:47 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4] change two annoying messages from framebuffer drivers
Content-Type: multipart/mixed;
 boundary="------------030709060407020702020901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030709060407020702020901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the Linux-on-a-CD system Knoppix has nearly all framebuffer drivers for 
2.4.23 compiled in. Additionally, it surpreesses most kernel messages by 
lowering the kernel log level.

Two framebuffer drivers (clgenfb.c and hgafb.c), however, use KERN_ERR 
to say that their particular card has *not* been found which is very 
annoying.

Especially the clgenfb.c driver simply says on bootup:
 >  Couldn't find PCI device
which can really confuse newbie users.

The appended patch replaces two KERN_ERR with KERN_INFO and additionally 
makes the clgen.c message more descriptive.

Please apply, thanks!

I'll create a separate patch 2.6 later, apparently clgenfb.c has gone there.

CU
Michael.

--------------030709060407020702020901
Content-Type: text/plain;
 name="video-fb-shutup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="video-fb-shutup.diff"

diff -ur xx-linux-2.4.22/drivers/video/clgenfb.c xx-linux-2.4.22.p/drivers/video/clgenfb.c
--- xx-linux-2.4.22/drivers/video/clgenfb.c	2003-06-13 16:51:37.000000000 +0200
+++ xx-linux-2.4.22.p/drivers/video/clgenfb.c	2003-12-12 13:48:34.000000000 +0100
@@ -2547,7 +2547,7 @@
 
 	pdev = clgen_pci_dev_get (btype);
 	if (!pdev) {
-		printk (KERN_ERR " Couldn't find PCI device\n");
+		printk (KERN_INFO "clgen: couldn't find Cirrus Logic PCI device\n");
 		DPRINTK ("EXIT, returning 1\n");
 		return 1;
 	}
diff -ur xx-linux-2.4.22/drivers/video/hgafb.c xx-linux-2.4.22.p/drivers/video/hgafb.c
--- xx-linux-2.4.22/drivers/video/hgafb.c	2001-11-12 18:46:25.000000000 +0100
+++ xx-linux-2.4.22.p/drivers/video/hgafb.c	2003-12-12 13:47:01.000000000 +0100
@@ -704,7 +704,7 @@
 int __init hgafb_init(void)
 {
 	if (! hga_card_detect()) {
-		printk(KERN_ERR "hgafb: HGA card not detected.\n");
+		printk(KERN_INFO "hgafb: HGA card not detected.\n");
 		return -EINVAL;
 	}
 

--------------030709060407020702020901--

