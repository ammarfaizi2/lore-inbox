Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSJ3QPq>; Wed, 30 Oct 2002 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264726AbSJ3QPq>; Wed, 30 Oct 2002 11:15:46 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:51205 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264725AbSJ3QPo>; Wed, 30 Oct 2002 11:15:44 -0500
Date: Wed, 30 Oct 2002 17:22:00 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [ANNOUNCE]: reiser4
Message-ID: <20021030162200.GD1995@louise.pinerecords.com>
References: <15806.51536.985203.709475@laputa.namesys.com> <3DBED1C8.5080404@pobox.com> <15806.54736.737949.328809@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15806.54736.737949.328809@laputa.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Nikita Danilov wrote:
>  > 
>  > >Hello,
>  > >
>  > >Snapshot of reiser4 source code can be found at 
>  > >http://www.namesys.com/snapshots/2002.10.29/.
>  > >
>  > >It is set of patches against current Linus BK tree (2.5.44).
>  > >  
>  > >
>  > 
>  > The current Linus BK tree is quite a bit different from 2.5.44 ;-)
>  > 
>  > Take a look at 2.5.44-bk1 at 
>  > ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/
>  > 
>  > A -bk2 snapshot should appear within the hour, too, with heaps of 
>  > additional changes.
>  > 
> 
> Sorry, my fault.
> 
> Patches in reiser4 snapshot are against Linus BK repository at
> http://linux.bkbits.net/linux-2.5. Numbers 2, 5, and 44, are, of course,
> just VERSION, PATCHLEVEL, and SUBLEVEL in the Makefile of the said
> repository.

The following is needed to compile reiser4 in 2.5.44-bk3:

diff -urN linux-2.5.44-bk3-reiser4/mm/Makefile linux-2.5.44-bk3-reiser4.1/mm/Makefile
--- linux-2.5.44-bk3-reiser4/mm/Makefile	2002-10-12 13:35:03.000000000 +0200
+++ linux-2.5.44-bk3-reiser4.1/mm/Makefile	2002-10-30 17:15:10.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for the linux memory manager.
 #
 
-export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o
+export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o swap.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
diff -urN linux-2.5.44-bk3-reiser4/mm/swap.c linux-2.5.44-bk3-reiser4.1/mm/swap.c
--- linux-2.5.44-bk3-reiser4/mm/swap.c	2002-10-16 10:53:13.000000000 +0200
+++ linux-2.5.44-bk3-reiser4.1/mm/swap.c	2002-10-30 17:14:23.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>
 #include <linux/prefetch.h>
+#include <linux/module.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -192,6 +193,7 @@
 		spin_unlock_irq(&zone->lru_lock);
 	__pagevec_release(pvec);
 }
+EXPORT_SYMBOL(pagevec_deactivate_inactive);
 
 /*
  * Add the passed pages to the LRU, then drop the caller's refcount

