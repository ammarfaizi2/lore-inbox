Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVCGTbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVCGTbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVCGTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:24:56 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:13830 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261275AbVCGTLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:11:30 -0500
Message-Id: <200503072037.j27KbJbc003952@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       tzachar@cs.bgu.ac.il
Subject: [PATCH 3/16] UML - slirp driver tells the network it's not ethernet
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:37:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nir Tzachar <tzachar@cs.bgu.ac.il>
Tell the netdevice code that a slirp device is not ethernet.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/slirp_kern.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/slirp_kern.c	2005-03-05 12:08:16.000000000 -0500
@@ -33,8 +33,11 @@
 
 	dev->init = NULL;
 	dev->hard_header_len = 0;
-	dev->addr_len = 4;
-	dev->type = ARPHRD_ETHER;
+	dev->header_cache_update = NULL;
+	dev->hard_header_cache = NULL;
+	dev->hard_header = NULL;
+	dev->addr_len = 0;
+	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 256;
 	dev->flags = IFF_NOARP;
 	printk("SLIRP backend - command line:");

