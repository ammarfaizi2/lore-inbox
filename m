Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSLWLzn>; Mon, 23 Dec 2002 06:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSLWLzn>; Mon, 23 Dec 2002 06:55:43 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:11681 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264665AbSLWLzl>; Mon, 23 Dec 2002 06:55:41 -0500
Date: Mon, 23 Dec 2002 13:03:49 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Message-ID: <20021223120349.GJ12643@louise.pinerecords.com>
References: <200212221439.28075.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212221439.28075.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.18
> 2147483648 bytes transferred in 119.140681 seconds (18024772 bytes/sec)
>
> 2.4.19
> 2147483648 bytes transferred in 140.305836 seconds (15305733 bytes/sec)

Well I'm getting the numbers the other way round. <g>

Machine:

$ egrep 'model name|MHz' /proc/cpuinfo
model name      : AMD Athlon(tm) processor
cpu MHz         : 996.037
$ grep MemTotal /proc/meminfo
MemTotal:       516588 kB
$ egrep 'Bridge|DMA rate' /proc/ide/via
South Bridge:                       VIA vt82c686b
Highest DMA rate:                   UDMA100
$ cat /proc/ide/ide0/hda/model
ST380021A
$ su -c 'hdparm -Iv /dev/hda| grep -i dma'
 using_dma    =  1 (on)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
$ grep [[:blank:]]/[[:blank:]] /etc/fstab
/dev/hda3	/	reiserfs	defaults	1	1

Tests:

$ uname -r
2.4.18
$ time sh -c 'sync; sync; sync; dd if=/dev/zero of=hoax bs=16k count=131072; sync; sync; sync'
131072+0 records in
131072+0 records out
real    1m44.708s
user    0m0.140s
sys     0m20.340s
=> 19.56MB/s

$ uname -r
2.4.20
$ time sh -c 'sync; sync; sync; dd if=/dev/zero of=hoax bs=16k count=131072; sync; sync; sync'
131072+0 records in
131072+0 records out
real    1m27.980s
user    0m0.120s
sys     0m20.290s
=> 23.28MB/s

I also tried machines with disks connected to various SCSI controllers
and in all cases more recent kernels gave better results than older
ones (sym53c8xx: two-disk raid1 - 2.4.18: ~35MB/s, 2.4.20: ~40MB/s).
I'm using reiserfs 3.6 everywhere.

-- 
Tomas Szepe <szepe@pinerecords.com>
