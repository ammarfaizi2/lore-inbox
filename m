Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRKJBol>; Fri, 9 Nov 2001 20:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280416AbRKJBoc>; Fri, 9 Nov 2001 20:44:32 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:61097 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S280410AbRKJBoM>; Fri, 9 Nov 2001 20:44:12 -0500
Date: Fri, 9 Nov 2001 20:46:22 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM tests on 2.4.14 2.4.15-pre[12] and Athlon opt
Message-ID: <20011109204622.B5791@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:	Athlon optimized kernel uses higher percentage of
		CPU (36% vs ~ 25%) and takes a little longer on memory 
		fill test.  Athlon kernel a little faster on mmap test.

Test:	Fill and write 80% of virtual memory with "mtest01 -w -p80"
	mmap, touch, msync, and munmap 500000 pages "mmap001 -m 500000"
	Listen to mp3 sampled at 128k. (usual test).
	Test with/without Athlon processor configuration.

There were no mp3blaster skips on the mmap001 tests.

config differences for athlon:

diff p5 k7
< CONFIG_M586=y
> CONFIG_MK7=y

< CONFIG_X86_L1_CACHE_SHIFT=5
< CONFIG_X86_USE_STRING_486=y
< CONFIG_X86_ALIGNMENT_16=y

> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_USE_3DNOW=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y


2.4.14

mp3 played 248 of 301 seconds (82%)

Averages for 10 mtest01 runs
bytes allocated:                    1236900249
User time (seconds):                2.014
System time (seconds):              7.045
Elapsed (wall clock) time:          30.853
Percent of CPU this job got:        28.90
Major (requiring I/O) page faults:  106.5
Minor (reclaiming a frame) faults:  302773.1

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.518
System time (seconds):              18.276
Elapsed (wall clock seconds) time:  186.31
Percent of CPU this job got:        19.80
Major (requiring I/O) page faults:  500163.4
Minor (reclaiming a frame) faults:  42.6


2.4.15-pre1

mp3 played 257 of 303 seconds (84%)

Averages for 10 mtest01 runs
bytes allocated:                    1233649664
User time (seconds):                2.060
System time (seconds):              5.280
Elapsed (wall clock) time:          30.314
Percent of CPU this job got:        23.70
Major (requiring I/O) page faults:  106.3
Minor (reclaiming a frame) faults:  301976.7

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.360
System time (seconds):              17.950
Elapsed (wall clock seconds) time:  188.15
Percent of CPU this job got:        19.40
Major (requiring I/O) page faults:  500165.2
Minor (reclaiming a frame) faults:  41.0


A note from Alan Cox on lkml said 2.4.14 should handle buggy VIA 
chipsets.  My KT133A now runs without oops compiled as Athlon.  
(kernels <= 2.4.9 didn't on my IWill KK266 mobo).

The next two tests are athlon optimized.  To me, the biggest
revelation is the higher "Percent of CPU this job got" on the 
mtest01 runs.


2.4.15-pre1 - athlon optimized

mp3 played 275 of 317 seconds (86%)

Averages for 10 mtest01 runs
bytes allocated:                    1238577971
User time (seconds):                5.475
System time (seconds):              6.032
Elapsed (wall clock) time:          31.683
Percent of CPU this job got:        36.00
Major (requiring I/O) page faults:  106.4
Minor (reclaiming a frame) faults:  303181.0

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.218
System time (seconds):              18.214
Elapsed (wall clock seconds) time:  182.07
Percent of CPU this job got:        20.00
Major (requiring I/O) page faults:  500163.4
Minor (reclaiming a frame) faults:  42.6


2.4.15-pre2 - athlon optimized

mp3 played 268 of 314 seconds (85%)

Averages for 10 mtest01 runs
bytes allocated:                    1235851673
User time (seconds):                5.447
System time (seconds):              6.099
Elapsed (wall clock) time:          31.400
Percent of CPU this job got:        36.40
Major (requiring I/O) page faults:  106.8
Minor (reclaiming a frame) faults:  302515.9

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.566
System time (seconds):              18.472
Elapsed (wall clock seconds) time:  183.45
Percent of CPU this job got:        20.20
Major (requiring I/O) page faults:  500164.4
Minor (reclaiming a frame) faults:  41.8

-- 
Randy Hron

