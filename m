Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVCLPvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVCLPvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVCLPvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:51:40 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:58240 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261763AbVCLPvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:51:36 -0500
Date: Sat, 12 Mar 2005 15:51:29 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Reuben Farrelly <reuben-lkml@reub.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3
In-Reply-To: <6.2.1.2.2.20050313011529.01c77168@tornado.reub.net>
Message-ID: <Pine.LNX.4.60.0503121549460.26553@hermes-1.csi.cam.ac.uk>
References: <20050312034222.12a264c4.akpm@osdl.org>
 <6.2.1.2.2.20050313011529.01c77168@tornado.reub.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005, Reuben Farrelly wrote:
> At 12:42 a.m. 13/03/2005, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/
> > - A new version of the "acpi poweroff fix".  People who were having trouble
> >   with ACPI poweroff, please test and report.
> > 
> > - A very large update to the CFQ I/O scheduler.  Treat with caution, run
> >   benchmarks.  Remember that the I/O scheduler can be selected on a per-disk
> >   basis with
> > 
> >         echo as > /sys/block/sda/queue/scheduler
> >         echo deadline > /sys/block/sda/queue/scheduler
> >         echo cfq > /sys/block/sda/queue/scheduler
> > 
> > - video-for-linux update
> 
> 
> Ugh, NTFS is br0ken:

Thanks for the report.  All the below were already fixed in my tree except 
for the mark_page_accessed() one which is now fixed (needs include 
linux/swap.h).

Best regards,

	Anton

>   CC [M]  fs/ntfs/attrib.o
> fs/ntfs/attrib.c: In function 'ntfs_attr_make_non_resident':
> fs/ntfs/attrib.c:1295: warning: implicit declaration of function
> 'ntfs_cluster_alloc'
> fs/ntfs/attrib.c:1296: error: 'DATA_ZONE' undeclared (first use in this
> function)
> fs/ntfs/attrib.c:1296: error: (Each undeclared identifier is reported only
> once
> fs/ntfs/attrib.c:1296: error: for each function it appears in.)
> fs/ntfs/attrib.c:1296: warning: assignment makes pointer from integer without
> a cast
> fs/ntfs/attrib.c:1435: warning: implicit declaration of function
> 'flush_dcache_mft_record_page'
> fs/ntfs/attrib.c:1436: warning: implicit declaration of function
> 'mark_mft_record_dirty'
> fs/ntfs/attrib.c:1443: warning: implicit declaration of function
> 'mark_page_accessed'
> fs/ntfs/attrib.c:1521: warning: implicit declaration of function
> 'ntfs_cluster_free_from_rl'
> make[2]: *** [fs/ntfs/attrib.o] Error 1
> make[1]: *** [fs/ntfs] Error 2
> make: *** [fs] Error 2
> 
> Compile goes through to completion fine if I back out bk-ntfs.patch.
> 
> Using gcc-4, but this problem did not exist in -mm2.

No, the relevant code didn't exist then either.  I only wrote it last 
week...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
