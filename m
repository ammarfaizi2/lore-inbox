Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWBAJGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWBAJGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWBAJD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:03:58 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:22347 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932408AbWBAJDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:36 -0500
Message-Id: <20060201090335.666881000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:03:06 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 42/44] ia64: make partial_page.bitmap an unsigned long
Content-Disposition: inline; filename=ia64-warn.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The *_bit() routines are defined to work on a pointer to unsigned long.
But partial_page.bitmap is unsigned int and it is passed to find_*_bit()
in arch/ia64/ia32/sys_ia32.c. So the compiler will print warnings.

This patch changes to unsigned long instead.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/ia64/ia32/ia32priv.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: 2.6-git/arch/ia64/ia32/ia32priv.h
===================================================================
--- 2.6-git.orig/arch/ia64/ia32/ia32priv.h
+++ 2.6-git/arch/ia64/ia32/ia32priv.h
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
