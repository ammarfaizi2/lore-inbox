Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTBNSFs>; Fri, 14 Feb 2003 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTBNSFs>; Fri, 14 Feb 2003 13:05:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:42400 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263544AbTBNSFo>; Fri, 14 Feb 2003 13:05:44 -0500
Date: Fri, 14 Feb 2003 10:15:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 356] New: htree appears to leak memory
Message-ID: <69150000.1045246530@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=356

           Summary: htree appears to leak memory
    Kernel Version: 2.5.60-bk4
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: single x86 CPU, Intel Corp. 82371AB/EB/MB PIIX4 IDE
(rev  01), Maxtor 91728D8, ATA DISK drive, 256mb RAM
Software Environment:
Problem Description:
In playing with ext3+htree, something is leaking memory on deletes (I
think).

razor:/giant# cat /proc/meminfo
MemTotal:       255884 kB
MemFree:         28416 kB
Buffers:          3812 kB
Cached:           6544 kB
SwapCached:          0 kB
Active:          21228 kB
Inactive:         6520 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255884 kB
LowFree:         28416 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:          19668 kB
Slab:           197068 kB
Committed_AS:    95668 kB
PageTables:        484 kB
ReverseMaps:      6098

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 30, high 90, batch 15
cpu 0 cold: low 0, high 30, batch 15
HighMem per-cpu: empty

Free pages:        2040kB (0kB HighMem)
Active:13749 inactive:0 dirty:0 writeback:0 free:510
DMA free:1148kB min:128kB low:256kB high:384kB active:11336kB inactive:0kB
Normal free:892kB min:1020kB low:2040kB high:3060kB active:43660kB
inactive:0kB HighMem free:0kB min:0kB low:0kB high:0kB active:0kB
inactive:0kB DMA: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB
1*1024kB 0*2048kB 0*4096kB = 1148kB
Normal: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB
0*2048 kB 0*4096kB = 892kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
65536 pages of RAM
0 pages of HIGHMEM
1581 reserved pages
518 pages shared
0 pages swap cached

And the memory won't free if I try to use it...

bwindle@razor:~/C$ ./alloc 50
Allocating 50 megs...

      malloc(52428800): Cannot allocate memory


Steps to reproduce:
I unmountd an existing ext3 partition, ran tune2fs -O dir_index on it, did
an  e2fsck -fD, then mounted it. Created a bunch of directories and files,
and did  a 'rm -rf *' on them.


