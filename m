Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTAZBJG>; Sat, 25 Jan 2003 20:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbTAZBJG>; Sat, 25 Jan 2003 20:09:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:640 "EHLO bilbo.tmr.com")
	by vger.kernel.org with ESMTP id <S266527AbTAZBJB>;
	Sat, 25 Jan 2003 20:09:01 -0500
Date: Sat, 25 Jan 2003 20:26:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.59 IPC effects of nmi_watchdog and noapic
Message-ID: <Pine.LNX.4.44.0301252014090.1277-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a great deal of disabling things which didn't work I got 2.5.59 up
on another test box, a BP6-based dual Celeron 500. I ran ctxbench to test
IPC speed, and it was much faster than previous kernels. In checking why I
noted that I had added nmi_watchdog=2 to the boot, because I have been
having hangs on some other machines (not 2.5 kernels).

After testing and retesting, I find that I get consistently different 
results when I choose nmi_watchdog or noapic options. Results follow, the 
benchmark is at http://www.unyuug.org/benchmarks/

This is an smp kernel without preempt, same kernel other than options 
every time. "wd" is watchdog, "noapic" means what it says. the watchdog 
value was 1 for noapic, 2 for normal. As always there is a lot of noise in 
the results, since it is much lower for uni kernels I conclude it's real. 
Feel free to disagree.

Someone might care to run pipe throughput or other benchmarks using these
options, I'm going to run some nosmp and then build a uni kernel.

Results follow:


================================================================
    Run information
================================================================

Run: 2.5.59noapic-bl	smp noapic
  CPU_MHz              497.941
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.59
  Ncpu                 2
Run: 2.5.59noapic_wd-bl	smp noapic nmi_watchdog=1
  CPU_MHz              497.934
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.59
  Ncpu                 2
Run: 2.5.59smp-bl	smp
  CPU_MHz              497.929
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.59
  Ncpu                 2
Run: 2.5.59smp2-bl	smp (rerun)
  CPU_MHz              497.929
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.59
  Ncpu                 2
Run: 2.5.59smp3-bl	smp (rerun)
  CPU_MHz              497.929
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.59
  Ncpu                 2
Run: 2.5.59smp_wd-bl	smp nmi_watchdog=2
  CPU_MHz              497.922
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.59
  Ncpu                 2


================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average    avg/MHz
  2.5.59noapic-bl         27068      48728      38082     76.480
  2.5.59noapic_wd-bl      33028      41411      36015     72.330
  2.5.59smp-bl            21736      42077      32709     65.691
  2.5.59smp2-bl           16262      40249      27620     55.471
  2.5.59smp3-bl           26504      42152      32308     64.885
  2.5.59smp_wd-bl         49025      50449      49922    100.261

                                   loops/sec
message queue               low       high    average    avg/MHz
  2.5.59noapic-bl         46252      93817      64054    128.639
  2.5.59noapic_wd-bl      40314      93365      70843    142.275
  2.5.59smp-bl            63793      91828      80033    160.732
  2.5.59smp2-bl           61275      80361      69334    139.245
  2.5.59smp3-bl           41539      96881      60969    122.445
  2.5.59smp_wd-bl         44631      97161      64125    128.785

                                   loops/sec
pipes                       low       high    average    avg/MHz
  2.5.59noapic-bl         34579      56118      43075     86.507
  2.5.59noapic_wd-bl      37042      53474      47074     94.540
  2.5.59smp-bl            38306      53524      44154     88.675
  2.5.59smp2-bl           54433      64747      59003    118.498
  2.5.59smp3-bl           45031      74383      56208    112.884
  2.5.59smp_wd-bl         42909      73304      62129    124.777

                                   loops/sec
semiphore                   low       high    average    avg/MHz
  2.5.59noapic-bl         45534      73110      57987    116.455
  2.5.59noapic_wd-bl      51628      76640      66925    134.405
  2.5.59smp-bl            54480      77204      63339    127.206
  2.5.59smp2-bl           75281      97321      86829    174.382
  2.5.59smp3-bl           49455     101385      76107    152.849
  2.5.59smp_wd-bl         93467     102784      99541    199.914

                                   loops/sec
spin+yield                  low       high    average    avg/MHz
  2.5.59noapic-bl        349412     568559     513582   1031.413
  2.5.59noapic_wd-bl     390338     576712     500901   1005.960
  2.5.59smp-bl           391388     555107     458790    921.397
  2.5.59smp2-bl          401141     554715     460878    925.591
  2.5.59smp3-bl          225217     533848     395736    794.764
  2.5.59smp_wd-bl        314654     502494     417260    838.003

                                   loops/sec
spinlock                    low       high    average    avg/MHz
  2.5.59noapic-bl       1194120    1194518    1194297   2398.472
  2.5.59noapic_wd-bl    1194547    1194689    1194613   2399.139
  2.5.59smp-bl          1196577    1196784    1196698   2403.351
  2.5.59smp2-bl         1195373    1195661    1195560   2401.065
  2.5.59smp3-bl         1193938    1195470    1194803   2399.546
  2.5.59smp_wd-bl       1150615    1192710    1178607   2367.053

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


