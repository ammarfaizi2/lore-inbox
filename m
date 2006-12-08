Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424642AbWLHFgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424642AbWLHFgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 00:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424638AbWLHFgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 00:36:37 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45235 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424633AbWLHFgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 00:36:36 -0500
Date: Fri, 8 Dec 2006 00:35:00 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 35/35] Unionfs: Extended Attributes support
Message-ID: <20061208053500.GE14363@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <1165235473964-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612071202360.2863@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612071202360.2863@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 12:04:43PM +0100, Jan Engelhardt wrote:
> 
> On Dec 4 2006 07:31, Josef 'Jeff' Sipek wrote:
> 
> If the makefile contains
> 
> >--- a/fs/unionfs/Makefile
> >+++ b/fs/unionfs/Makefile
> >@@ -3,3 +3,5 @@ obj-$(CONFIG_UNION_FS) += unionfs.o
> > unionfs-y := subr.o dentry.o file.o inode.o main.o super.o \
> > 	stale_inode.o branchman.o rdstate.o copyup.o dirhelper.o \
> > 	rename.o unlink.o lookup.o commonfops.o dirfops.o sioq.o
> >+
> >+unionfs-$(CONFIG_UNION_FS_XATTR) += xattr.o
> 
> then you don't need
> 
> >--- a/fs/unionfs/copyup.c
> >+++ b/fs/unionfs/copyup.c
> >@@ -18,6 +18,75 @@
> > 
> > #include "union.h"
> > 
> >+#ifdef CONFIG_UNION_FS_XATTR
> 
> ^^ this, do you?.
 
Beware, copyup.c gets compiled all the time even when you don't have xattrs
enabled.
 
> >+#include "union.h"
> >+
> >+/* This is lifted from fs/xattr.c */
> >+void *xattr_alloc(size_t size, size_t limit)
> 
> Same as for init_inode_cache, possibly prefix with unionfs.

Right.

Josef "Jeff" Sipek.

-- 
A computer without Microsoft is like chocolate cake without mustard.
