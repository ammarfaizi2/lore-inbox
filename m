Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSKOTFq>; Fri, 15 Nov 2002 14:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbSKOTFq>; Fri, 15 Nov 2002 14:05:46 -0500
Received: from holomorphy.com ([66.224.33.161]:57552 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266676AbSKOTFp>;
	Fri, 15 Nov 2002 14:05:45 -0500
Date: Fri, 15 Nov 2002 11:07:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: privatize various functions in sched.h
Message-ID: <20021115190710.GA23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021115105403.GS22031@holomorphy.com> <20021115112836.GU23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115112836.GU23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 02:54:03AM -0800, William Lee Irwin III wrote:
>> This removes a bunch of inlines used only in isolated places from sched.h

On Fri, Nov 15, 2002 at 03:28:36AM -0800, William Lee Irwin III wrote:
> Hmm, while I'm at it, this applies atop the previous patch:
> This removes d_path() from sched.h and uninlines it. No idea why it was
> in sched.h in the first place (or why something this large is inlined).

Atop the d_path() removal patch:


__d_path() may be privatized since umsdos is broken anyway.

 fs/dcache.c            |    6 +++---
 include/linux/dcache.h |    2 --
 kernel/ksyms.c         |    1 -
 3 files changed, 3 insertions(+), 6 deletions(-)


diff -urpN cleanup-2.5.47-5/fs/dcache.c cleanup-2.5.47-6/fs/dcache.c
--- cleanup-2.5.47-5/fs/dcache.c	2002-11-15 02:45:02.000000000 -0800
+++ cleanup-2.5.47-6/fs/dcache.c	2002-11-15 10:19:33.000000000 -0800
@@ -1136,9 +1136,9 @@ void d_move(struct dentry * dentry, stru
  *
  * "buflen" should be %PAGE_SIZE or more. Caller holds the dcache_lock.
  */
-char * __d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
-		struct dentry *root, struct vfsmount *rootmnt,
-		char *buffer, int buflen)
+static char * __d_path( struct dentry *dentry, struct vfsmount *vfsmnt,
+			struct dentry *root, struct vfsmount *rootmnt,
+			char *buffer, int buflen)
 {
 	char * end = buffer+buflen;
 	char * retval;
diff -urpN cleanup-2.5.47-5/include/linux/dcache.h cleanup-2.5.47-6/include/linux/dcache.h
--- cleanup-2.5.47-5/include/linux/dcache.h	2002-11-15 02:41:37.000000000 -0800
+++ cleanup-2.5.47-6/include/linux/dcache.h	2002-11-15 10:19:01.000000000 -0800
@@ -238,8 +238,6 @@ extern struct dentry * __d_lookup(struct
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);
 
-extern char * __d_path(struct dentry *, struct vfsmount *, struct dentry *,
-	struct vfsmount *, char *, int);
 extern char * d_path(struct dentry *, struct vfsmount *, char *, int);
   
 /* Allocation counts.. */
diff -urpN cleanup-2.5.47-5/kernel/ksyms.c cleanup-2.5.47-6/kernel/ksyms.c
--- cleanup-2.5.47-5/kernel/ksyms.c	2002-11-15 02:43:58.000000000 -0800
+++ cleanup-2.5.47-6/kernel/ksyms.c	2002-11-15 10:19:50.000000000 -0800
@@ -167,7 +167,6 @@ EXPORT_SYMBOL(d_alloc_anon);
 EXPORT_SYMBOL(d_splice_alias);
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(d_path);
-EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
 EXPORT_SYMBOL(end_buffer_io_sync);
 EXPORT_SYMBOL(__mark_inode_dirty);
