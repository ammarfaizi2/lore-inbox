Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032043AbWLGLLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032043AbWLGLLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032042AbWLGLLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:11:49 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43081 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032039AbWLGLLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:11:47 -0500
Date: Thu, 7 Dec 2006 12:04:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 35/35] Unionfs: Extended Attributes support
In-Reply-To: <1165235473964-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612071202360.2863@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235473964-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:31, Josef 'Jeff' Sipek wrote:

If the makefile contains

>--- a/fs/unionfs/Makefile
>+++ b/fs/unionfs/Makefile
>@@ -3,3 +3,5 @@ obj-$(CONFIG_UNION_FS) += unionfs.o
> unionfs-y := subr.o dentry.o file.o inode.o main.o super.o \
> 	stale_inode.o branchman.o rdstate.o copyup.o dirhelper.o \
> 	rename.o unlink.o lookup.o commonfops.o dirfops.o sioq.o
>+
>+unionfs-$(CONFIG_UNION_FS_XATTR) += xattr.o

then you don't need

>--- a/fs/unionfs/copyup.c
>+++ b/fs/unionfs/copyup.c
>@@ -18,6 +18,75 @@
> 
> #include "union.h"
> 
>+#ifdef CONFIG_UNION_FS_XATTR

^^ this, do you?.


>+#include "union.h"
>+
>+/* This is lifted from fs/xattr.c */
>+void *xattr_alloc(size_t size, size_t limit)

Same as for init_inode_cache, possibly prefix with unionfs.


	-`J'
-- 
