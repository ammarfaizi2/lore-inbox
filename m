Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbUL2Aiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUL2Aiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUL2Aiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:38:51 -0500
Received: from mail.dif.dk ([193.138.115.101]:55486 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261191AbUL2Ait (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:38:49 -0500
Date: Wed, 29 Dec 2004 01:49:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Stephen Tweedie <sct@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] add missing printk loglevel in mm/swapfile.c
Message-ID: <Pine.LNX.4.61.0412290142500.3528@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in mm/swapfile.c a printk() is missing a loglevel. I believe the proper 
loglevel for this situation is KERN_ERR, so that's what the patch below 
sets -if you agree, please apply.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-orig/mm/swapfile.c linux-2.6.10/mm/swapfile.c
--- linux-2.6.10-orig/mm/swapfile.c	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10/mm/swapfile.c	2004-12-29 01:42:01.000000000 +0100
@@ -1461,7 +1461,7 @@ asmlinkage long sys_swapon(const char __
 	else if (!memcmp("SWAPSPACE2",swap_header->magic.magic,10))
 		swap_header_version = 2;
 	else {
-		printk("Unable to find swap-space signature\n");
+		printk(KERN_ERR "Unable to find swap-space signature\n");
 		error = -EINVAL;
 		goto bad_swap;
 	}



