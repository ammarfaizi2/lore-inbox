Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWBNFLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWBNFLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWBNFL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:11:28 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:40911 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030391AbWBNFFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:09 -0500
Message-Id: <20060214050449.842801000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:34 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 43/47] ia64: make partial_page.bitmap an unsigned long
Content-Disposition: inline; filename=ia64-warn.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The find_*_bit() routines are defined to work on a pointer to unsigned long.
But partial_page.bitmap is unsigned int and it is passed to find_*_bit() in
arch/ia64/ia32/sys_ia32.c. So the compiler will print warnings.

This patch changes to unsigned long instead.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/ia64/ia32/ia32priv.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: 2.6-rc/arch/ia64/ia32/ia32priv.h
===================================================================
--- 2.6-rc.orig/arch/ia64/ia32/ia32priv.h
+++ 2.6-rc/arch/ia64/ia32/ia32priv.h
@@ -29,9 +29,9 @@
 struct partial_page {
 	struct partial_page	*next; /* linked list, sorted by address */
 	struct rb_node		pp_rb;
-	/* 64K is the largest "normal" page supported by ia64 ABI. So 4K*32
+	/* 64K is the largest "normal" page supported by ia64 ABI. So 4K*64
 	 * should suffice.*/
-	unsigned int		bitmap;
+	unsigned long		bitmap;
 	unsigned int		base;
 };
 

--
