Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276208AbRI1R6Y>; Fri, 28 Sep 2001 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276210AbRI1R6O>; Fri, 28 Sep 2001 13:58:14 -0400
Received: from rj.sgi.com ([204.94.215.100]:11978 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276208AbRI1R6B>;
	Fri, 28 Sep 2001 13:58:01 -0400
Message-Id: <200109281758.f8SHwCW21849@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Gerold Jury <gjury@hal.grips.com>
cc: Andrey Nekrasov <andy@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: [BENCH] Problems with IO throughput and fairness with 2.4.10 and 2.4.9-ac15 
In-Reply-To: Message from Gerold Jury <gjury@hal.grips.com> 
   of "Fri, 28 Sep 2001 14:48:36 +0200." <200109281248.f8SCmaT29893@hal.grips.com> 
Date: Fri, 28 Sep 2001 12:58:12 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, nice to hear.
> 
> So it needs to be something stupid on my side or xfs with the new VM.
> 
> By the way. It is an Atlon 1.1 (kernel compiled with Atlon optimisation)
> IDE controller ATA66, disk IBM 15 GB ATA33
> The machine is solid with and without VIA pci bit 7 byte 55 zero/one
> swapspace 256MB
> 
> preempable patch does not help with my D state problem
> i have not tried 2.4.10.aa1
> but i will try with ext2 instead of xfs next time
> 
> Gerold
> 

Hi,

Can you try XFS with this change, just to confirm you are seeing the same
problem I am seeing. I am not proposing this as a permanent fix yet,
just confirming what the deadlock is.

Thanks

   Steve



===========================================================================
Index: linux/fs/inode.c
===========================================================================

--- /usr/tmp/TmpDir.21835-0/linux/fs/inode.c_1.53	Fri Sep 28 12:57:27 2001
+++ linux/fs/inode.c	Fri Sep 28 10:17:49 2001
@@ -76,7 +76,7 @@
 static kmem_cache_t * inode_cachep;
 
 #define alloc_inode() \
-	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
+	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_NOFS))
 static void destroy_inode(struct inode *inode) 
 {
 	if (inode_has_buffers(inode))


