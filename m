Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVCLMll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVCLMll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 07:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVCLMll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 07:41:41 -0500
Received: from tornado.reub.net ([60.234.136.108]:65248 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261454AbVCLMli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 07:41:38 -0500
Message-Id: <6.2.1.2.2.20050313011529.01c77168@tornado.reub.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Sun, 13 Mar 2005 01:41:37 +1300
To: Andrew Morton <akpm@osdl.org>
From: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: 2.6.11-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
References: <20050312034222.12a264c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:42 a.m. 13/03/2005, Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/
>
>
>- A new version of the "acpi poweroff fix".  People who were having trouble
>   with ACPI poweroff, please test and report.
>
>- A very large update to the CFQ I/O scheduler.  Treat with caution, run
>   benchmarks.  Remember that the I/O scheduler can be selected on a per-disk
>   basis with
>
>         echo as > /sys/block/sda/queue/scheduler
>         echo deadline > /sys/block/sda/queue/scheduler
>         echo cfq > /sys/block/sda/queue/scheduler
>
>- video-for-linux update


Ugh, NTFS is br0ken:

   CC [M]  fs/ntfs/attrib.o
fs/ntfs/attrib.c: In function 'ntfs_attr_make_non_resident':
fs/ntfs/attrib.c:1295: warning: implicit declaration of function 
'ntfs_cluster_alloc'
fs/ntfs/attrib.c:1296: error: 'DATA_ZONE' undeclared (first use in this 
function)
fs/ntfs/attrib.c:1296: error: (Each undeclared identifier is reported only once
fs/ntfs/attrib.c:1296: error: for each function it appears in.)
fs/ntfs/attrib.c:1296: warning: assignment makes pointer from integer 
without a cast
fs/ntfs/attrib.c:1435: warning: implicit declaration of function 
'flush_dcache_mft_record_page'
fs/ntfs/attrib.c:1436: warning: implicit declaration of function 
'mark_mft_record_dirty'
fs/ntfs/attrib.c:1443: warning: implicit declaration of function 
'mark_page_accessed'
fs/ntfs/attrib.c:1521: warning: implicit declaration of function 
'ntfs_cluster_free_from_rl'
make[2]: *** [fs/ntfs/attrib.o] Error 1
make[1]: *** [fs/ntfs] Error 2
make: *** [fs] Error 2

Compile goes through to completion fine if I back out bk-ntfs.patch.

Using gcc-4, but this problem did not exist in -mm2.

reuben

