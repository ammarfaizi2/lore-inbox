Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVAVUP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVAVUP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVAVUP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:15:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:54681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262725AbVAVUOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:14:48 -0500
Date: Sat, 22 Jan 2005 12:14:44 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: <dev@osdl.org>, <linux-kernel@vger.kernel.org>,
       <stp-devel@lists.sourceforge.net>
Subject: Kernel 2.6.11-rc1/2 goes Postal on LTP
In-Reply-To: <20050121210537.L24171@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0501221125140.30167-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Chris Wright wrote:
> * Bryce Harrington (bryce@osdl.org) wrote:
> > Well, I'm not having much luck.  strace isn't installed on the system
> > (and is giving errors when trying to compile it).  Also, the ssh session
> > (and sshd) quits whenever I try running the following growfiles command
> > manually, so I'm having trouble replicating the kernel panic manually.
>
> Sounds very much like oom killer gone nuts.
>
> > # growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2
> >
> > Anyway, if anyone wants to investigate this further, I can provide
> > access to the machine (email me).  Otherwise, I'm probably just going to
> > wait for -rc2 and see if the problem's still there.
>
> Wait no longer, it's here ;-)

Hmm, still the kernel is going nutso.  LTP and everything else on the
system is getting killed, including the test manager process.

Below's a bit more info scraped from the console.  This is from a run on
RH 9.0.  It looks like LTP got through 722 of its 2270 tests before the
kernel goes postal on it.  This time it got through all the growfile
commands before it died (see bottom of this post), however it looks like
the same growfile cmd I reported earlier is the one causing the problem.

When I run:

mkfifo gffifo18;
strace growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18 &> /tmp/growfiles_strace_log.txt

The following happens:

* I get this strace log:  http://developer.osdl.org/bryce/growfiles_strace_log.txt
* The ssh session dies and returns to login prompt
* A bunch of stuff similar to below is spewed to console

Bryce


Console
=======
...snip...
Memory: 905212k/917504k available (2211k kernel code, 11840k reserved,
871k data, 192k init, 0k highmem)
...snip...

HighMem per-cpu: empty

Free pages:        3828kB (0kB HighMem)
Active:341 inactive:297 dirty:0 writeback:1 unstable:0 free:957
slab:1591 mapped:614 pagetables:172
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3760kB min:3756kB low:4692kB high:5632kB active:1364kB
inactive:1188kB present:901120kB pages_scanned:1571 all_unreclaimable?
no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 6*4kB 5*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB
1*1024kB 1*2048kB 0*4096kB = 3760kB
HighMem: empty
Swap cache: add 4541, delete 4457, find 33/60, race 0+0
Out of Memory: Killed process 2103 (jserver).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        3764kB (0kB HighMem)
Active:360 inactive:267 dirty:0 writeback:0 unstable:0 free:941
slab:1520 mapped:614 pagetables:167
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3696kB min:3756kB low:4692kB high:5632kB active:1440kB
inactive:1068kB present:901120kB pages_scanned:3461 all_unreclaimable?
yes
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB
1*1024kB 1*2048kB 0*4096kB = 3696kB
HighMem: empty
Swap cache: add 4994, delete 4918, find 106/200, race 0+0
Out of Memory: Killed process 2052 (ntpd).
oom-killer: gfp_mask=0xd2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        3764kB (0kB HighMem)
Active:0 inactive:13 dirty:0 writeback:0 unstable:0 free:941 slab:1482
mapped:0 pagetables:162
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3696kB min:3756kB low:4692kB high:5632kB active:0kB
inactive:52kB present:901120kB pages_scanned:134 all_unreclaimable? yes
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB
1*1024kB 1*2048kB 0*4096kB = 3696kB
HighMem: empty
Swap cache: add 6764, delete 6764, find 255/593, race 0+0
Out of Memory: Killed process 2081 (cannaserver).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty


... Snip about 500 lines of similar ...


cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        4412kB (0kB HighMem)
Active:17 inactive:90 dirty:0 writeback:22 unstable:0 free:1103
slab:1359 mapped:6 pagetables:100
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:4344kB min:3756kB low:4692kB high:5632kB active:68kB
inactive:348kB present:901120kB pages_scanned:29 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 148*4kB 7*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB
1*1024kB 1*2048kB 0*4096kB = 4344kB
HighMem: empty
Swap cache: add 57990, delete 57962, find 12748/24896, race 1+39
Out of Memory: Killed process 2036 (xinetd).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        4164kB (0kB HighMem)
Active:24 inactive:103 dirty:0 writeback:3 unstable:0 free:977 slab:1377
mapped:6 pagetables:95
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:4544kB min:3756kB low:4692kB high:5632kB active:64kB
inactive:12kB present:901120kB pages_scanned:32 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 188*4kB 18*8kB 8*16kB 6*32kB 2*64kB 1*128kB 2*256kB 1*512kB
0*1024kB 1*2048kB 0*4096kB = 4544kB
HighMem: empty
Swap cache: add 60743, delete 60729, find 13635/26468, race 1+55
Out of Memory: Killed process 1856 (dhclient).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        4228kB (0kB HighMem)
Active:1 inactive:59 dirty:0 writeback:1 unstable:0 free:1057 slab:1382
mapped:1 pagetables:114
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:4160kB min:3756kB low:4692kB high:5632kB active:4kB
inactive:236kB present:901120kB pages_scanned:7 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 110*4kB 5*8kB 6*16kB 4*32kB 2*64kB 0*128kB 1*256kB 0*512kB
1*1024kB 1*2048kB 0*4096kB = 4160kB
HighMem: empty
Swap cache: add 63971, delete 63944, find 14642/28222, race 1+61
Out of Memory: Killed process 15039 (sh).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        4292kB (0kB HighMem)
Active:19 inactive:67 dirty:0 writeback:0 unstable:0 free:1073 slab:1376
mapped:3 pagetables:105
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:4352kB min:3756kB low:4692kB high:5632kB active:88kB
inactive:20kB present:901120kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 112*4kB 12*8kB 6*16kB 4*32kB 2*64kB 0*128kB 1*256kB 0*512kB
1*1024kB 1*2048kB 0*4096kB = 4224kB
HighMem: empty
Swap cache: add 69893, delete 69890, find 15657/30569, race 1+71
Out of Memory: Killed process 15040 (sh).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        4292kB (0kB HighMem)
Active:0 inactive:106 dirty:0 writeback:37 unstable:0 free:1073
slab:1366 mapped:38 pagetables:95
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:4224kB min:3756kB low:4692kB high:5632kB active:0kB
inactive:424kB present:901120kB pages_scanned:44 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 124*4kB 14*8kB 6*16kB 4*32kB 2*64kB 0*128kB 1*256kB 0*512kB
1*1024kB 1*2048kB 0*4096kB = 4288kB
HighMem: empty
Swap cache: add 74897, delete 74859, find 16621/32853, race 2+72
Out of Memory: Killed process 15043 (sh).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        3780kB (0kB HighMem)
Active:30 inactive:250 dirty:0 writeback:0 unstable:0 free:945 slab:1361
mapped:52 pagetables:65
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3712kB min:3756kB low:4692kB high:5632kB active:120kB
inactive:1000kB present:901120kB pages_scanned:115 all_unreclaimable?
yes
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 2*8kB 7*16kB 4*32kB 2*64kB 0*128kB 1*256kB 0*512kB
1*1024kB 1*2048kB 0*4096kB = 3712kB
HighMem: empty
Swap cache: add 76870, delete 76848, find 17358/34233, race 3+72
Out of Memory: Killed process 10665 (pan).

Red Hat Linux release 9 (Shrike)
Kernel 2.6.11-rc2 on an i686

stp2-001 login:

LTP Test command execution sequence
===================================
# grep cmdline results.txt

... snip ...

cmdline="wait02"
cmdline="wait401"
cmdline="wait402"
cmdline="waitpid01"
cmdline="waitpid02"
cmdline="waitpid03"
cmdline="waitpid04"
cmdline="waitpid05"
cmdline="waitpid06"
cmdline="waitpid07"
cmdline="waitpid08"
cmdline="waitpid09"
cmdline="waitpid10 5"
cmdline="waitpid11"
cmdline="waitpid12"
cmdline="waitpid13"
cmdline="write01"
cmdline="write02"
cmdline="write03"
cmdline="write04"
cmdline="write05"
cmdline="writev01"
cmdline="writev02"
cmdline="writev03"
cmdline="writev04"
cmdline="writev05"
cmdline="growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2"
cmdline="growfiles -W gf02 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_"
cmdline="growfiles -W gf03 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_"
cmdline="growfiles -W gf04 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_"
cmdline="growfiles -W gf05 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_"
cmdline="growfiles -W gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 g_rand10 g_rand10.2"
cmdline="growfiles -W gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 -I p g_rand13 g_rand13.2"
cmdline="growfiles -W gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 30 -C 1 g_rand11 g_rand11.2"
cmdline="growfiles -W gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 30 -C 1 -I p g_rand12 g_rand12.2"
cmdline="growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2"
cmdline="growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2"
cmdline="mkfifo gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 gffifo17"
cmdline="mkfifo gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18"
cmdline="growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2"
cmdline="growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1"
cmdline="growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_"
cmdline="growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_"
cmdline="growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_"
cmdline="growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_"
cmdline="growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$"
cmdline="growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$"
cmdline="growfiles -W gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$"
cmdline="growfiles -W gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$"
cmdline="growfiles -W gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$"
cmdline="growfiles -W gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$"
cmdline="growfiles -W gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$"
cmdline="growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$"
cmdline="growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$"
cmdline="growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$"
cmdline="growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$"
cmdline="export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$"
cmdline="export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$"
cmdline="export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$"
cmdline="export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$"
cmdline="export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/rwtest01%s"
cmdline="export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$"
cmdline="fs_inod $TMP 10 10 1"
cmdline="linktest.pl"
cmdline="openfile -f10 -t10"
cmdline="inode01"
cmdline="inode02"
cmdline="stream01"
cmdline="stream02"
cmdline="stream03"

