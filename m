Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTHVXBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTHVXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 19:00:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:31107 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263418AbTHVXAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 19:00:43 -0400
Date: Fri, 22 Aug 2003 15:31:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] prevent minix_fs printk type warnings
Message-Id: <20030822153135.4b03f031.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Building on 64-bit (ia64) produces printk data type warnings
because ino_t is unsigned int there and unsigned long on x86.

--
~Randy


patch_name:	minix_printk.patch
patch_version:	2003-08-22.15:25:32
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	prevent printk() type warnings in minix fs
product:	Linux
product_versions: 260-test3
diffstat:	=
 fs/minix/bitmap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naur ./fs/minix/bitmap.c~mnxtypes ./fs/minix/bitmap.c
--- ./fs/minix/bitmap.c~mnxtypes	Fri Aug  8 21:39:25 2003
+++ ./fs/minix/bitmap.c	Fri Aug 22 15:21:46 2003
@@ -116,7 +116,7 @@
 
 	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %ld is out of range\n",
-		       sb->s_id, ino);
+		       sb->s_id, (unsigned long)ino);
 		return NULL;
 	}
 	ino--;
@@ -141,7 +141,7 @@
 	*bh = NULL;
 	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %ld is out of range\n",
-		       sb->s_id, ino);
+		       sb->s_id, (unsigned long)ino);
 		return NULL;
 	}
 	ino--;

