Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262798AbREOPoC>; Tue, 15 May 2001 11:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262797AbREOPnw>; Tue, 15 May 2001 11:43:52 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:44813
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262796AbREOPnh>; Tue, 15 May 2001 11:43:37 -0400
Date: Tue, 15 May 2001 11:42:16 -0400
From: Chris Mason <mason@suse.com>
To: Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs, Mongo and CPU question
Message-ID: <1076120000.989941336@tiny>
In-Reply-To: <NDBBKGPFCLNOBENJJLDDIEBCCHAA.gallir@uib.es>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, May 15, 2001 01:41:01 PM +0200 Ricardo Galli <gallir@uib.es>
wrote:

> Hans and reiserfs developers,
> 	the same student of my university
> (http://www.cs.helsinki.fi/linux/linux-kernel/2001-18/0654.html) was
> carrying up the mongo benchmarks against reiser, xfs, jfs and ext2 for
> different base sizes.
> 
> 
> For example, for the base size of 10.000 (the average of a clean
> distribution is about 16.000 bytes) ReiserFS is even slower than ext2.
> I've realised the bottleneck may be the CPU, a Cyrix MII 233MHz.
> 

Would not surprise me, there's lots of room for improvement in reiserfs CPU
usage.  The 10k size is one of the worst cases for tail performance, those
numbers should increase if you mount with -o notail.

Here's a simple patch that should help on balance instensive apps (like
creates/deletes).  Please let me know if you see any difference with it.

-chris

diff -ur diff/linux/fs/reiserfs/fix_node.c linux/fs/reiserfs/fix_node.c
--- diff/linux/fs/reiserfs/fix_node.c	Mon Jan 15 18:31:19 2001
+++ linux/fs/reiserfs/fix_node.c	Fri Feb  2 15:40:54 2001
@@ -936,6 +936,7 @@
     if (p_s_tb->FEB[p_s_tb->cur_blknum])
       BUG();
 
+    mark_buffer_journal_new(p_s_new_bh) ;
     p_s_tb->FEB[p_s_tb->cur_blknum++] = p_s_new_bh;
   }
 



