Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSFIPHe>; Sun, 9 Jun 2002 11:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSFIPHd>; Sun, 9 Jun 2002 11:07:33 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:3079 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317619AbSFIPHc>; Sun, 9 Jun 2002 11:07:32 -0400
Date: Sun, 9 Jun 2002 16:07:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5.21] compilation fix
Message-ID: <20020609160725.A8761@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.05.10206091653110.16366-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 04:55:08PM +0200, Thomas 'Dent' Mirlacher wrote:
> seems the include file cleanup was a little bit over-optimized :)

The patch I'm using is as follows.  Since namespace.h needs the contents
of dcache, task struct and semaphores, it seems sensible to include
these two files into namespace.h.

For the future: If the task_struct in sched.h is split into its own
include file, namespace.h could include this file, but namespace.h
will also need asm/semaphore.h

--- orig/kernel/fork.c	Sun Jun  9 16:02:04 2002
+++ linux/kernel/fork.c	Sun Jun  9 15:19:30 2002
@@ -24,6 +24,7 @@
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
--- orig/mm/vmalloc.c	Sun Jun  9 16:02:04 2002
+++ linux/mm/vmalloc.c	Sun Jun  9 15:26:25 2002
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/spinlock.h>
+#include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/smp_lock.h>
 
--- orig/include/linux/namespace.h	Tue Feb 19 00:47:25 2002
+++ linux/include/linux/namespace.h	Sun Jun  9 16:04:05 2002
@@ -2,6 +2,9 @@
 #define _NAMESPACE_H_
 #ifdef __KERNEL__
 
+#include <linux/dcache.h>
+#include <linux/sched.h>
+
 struct namespace {
 	atomic_t		count;
 	struct vfsmount *	root;


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

