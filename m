Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSFUWGe>; Fri, 21 Jun 2002 18:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316355AbSFUWGd>; Fri, 21 Jun 2002 18:06:33 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:2944 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S316339AbSFUWGd>; Fri, 21 Jun 2002 18:06:33 -0400
Message-ID: <3D13A2B4.236E55DD@us.ibm.com>
Date: Fri, 21 Jun 2002 17:03:32 -0500
From: Duc Vianney <dvianney@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, mgross <mgross@unix-os.sc.intel.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles 
 gets large
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>If you have time, please test ext2 and/or reiserfs and/or ext3
>in writeback mode.
I ran IOzone on ext2fs, ext3fs, JFS, and Reiserfs on an SMP 4-way
500MHz, 2.5GB RAM, two 9.1GB SCSI drives. The test partition is 1GB,
test file size is 128MB, test block size is 4KB, and IO threads varies
from 1 to 6. When comparing with other file system for this test
environment, the results on a 2.5.19 SMP kernel show ext3fs is having
performance problem with Writes and in particularly, with Random Write.
I think the BKL contention patch would help ext3fs, but I need to verify
it first.

The following data are throughput in MB/sec obtained from IOzone
benchmark running on all file systems installed with default options.


Kernels           2519smp4   2519smp4   2519smp4   2519smp4
No of threads=1   ext2-1t    jfs-1t     ext3-1t    reiserfs-1t

Initial write     138010     111023      29808      48170
Rewrite           205736     204538     119543     142765
Read              236500     237235     231860     236959
Re-read           242927     243577     240284     242776
Random read       204292     206010     201664     207219
Random write      180144     180461       1090     121676

No of threads=2  ext2-2t     jfs-2t     ext3-2t    reiserfs-2t

Initial write     196477     143395      62248      55260
Rewrite           261641     261441     126604     205076
Read              292566     292796     313562     291434
Re-read           302239     306423     341416     303424
Random read       296152     295430     316966     288584
Random write      253026     251013        958     203358

No of threads=4  ext2-4t     jfs-4t    ext3-4t     reiserfs-4t

Initial write      79513     172302      42051      48782
Rewrite           256568     269840     124912     231395
Read              290599     303669     327066     283793
Re-read           289578     303644     327362     287531
Random read       354011     353455     353806     351671
Random write      279704     279922       2482     250498

No of threads=6  ext2-6t     jfs-6t    ext3-6t     reiserfs-6t

Initial write      98559      69825      59728      15576
Rewrite           274993     286987     126048     232193
Read              330522     326143     332147     326163
Re-read           339672     328890     333094     326725
Random read       348059     346154     347901     344927
Random write      281613     280213       3659     227579

Cheers,
Duc J Vianney, dvianney@us.ibm.com
home page: http://www-124.ibm.com/developerworks/opensource/linuxperf/
project page: http://www-124.ibm.com/developerworks/projects/linuxperf


