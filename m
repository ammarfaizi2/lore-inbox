Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTFCWtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFCWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:49:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261790AbTFCWtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:49:10 -0400
Date: Tue, 3 Jun 2003 16:02:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, akpm@digeo.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fat-fs printk arg. fix
Message-Id: <20030603160200.04991141.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A recent fatfs patch for large partitions upset printk.
Here's a patch for it.

--
~Randy


patch_name:	fat-printk.patch
patch_version:	2003-06-03.15:37:48
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	printk() args are unhappy with recent change for large
		partition support;
product:	Linux
product_versions: 2.5.70
maintainer:	OGAWA Hirofumi
diffstat:	=
 fs/fat/misc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naur ./fs/fat/misc.c%PRTK ./fs/fat/misc.c
--- ./fs/fat/misc.c%PRTK	2003-06-02 14:35:15.000000000 -0700
+++ ./fs/fat/misc.c	2003-06-03 14:40:49.000000000 -0700
@@ -311,7 +311,7 @@
 	*bh = sb_bread(sb, phys);
 	if (*bh == NULL) {
 		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
-		       phys);
+		       (u64)phys);
 		/* skip this block */
 		*pos = (iblock + 1) << sb->s_blocksize_bits;
 		goto next;
