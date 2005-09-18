Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVIRLBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVIRLBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 07:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVIRLBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 07:01:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:64718 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751149AbVIRLBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 07:01:11 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: Eradic disk access during reads
Date: Sun, 18 Sep 2005 14:00:26 +0300
User-Agent: KMail/1.8.2
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509171344.16564.vda@ilport.com.ua> <200509171918.17658.a1426z@gawab.com>
In-Reply-To: <200509171918.17658.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181400.27004.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 September 2005 19:38, Al Boldi wrote:
> > > > > Monitoring disk access using gkrellm, I noticed that a command like
> > > > >
> > > > > cat /dev/hda > /dev/null
> > > > >
> > > > > shows eradic disk reads ranging from 0 to 80MB/s on an otherwise
> > > > > idle system.
> > > > >
> > > > > 1. Is this a hardware or software problem?
> > > >
> > > > Difficult to tell without more info. Can be a broken IDE disk or
> > > > defective ribbon.
> > >
> > > Tried the same with 2.4.31 which shows steady behaviour with occasional
> > > dips and pops in the msec range.
> > >
> > > > > 2. Is there a lightweight perf-mon tool (cmd-line) that would log
> > > > > this behaviour graphically?
> >
> > Try attached one.
> 
> Nice!
> 
> > # dd if=/dev/hda of=/dev/null bs=16M
> 
> This is what I got; what do you get?
> 
> Thanks!
> 
> 2.4.31 # nmeter t6 c x i b d100
> 18:56:36.009981 cpu [SSSSSSSS..] ctx  145 int   86 bio 4.7M    0
> 18:56:36.110327 cpu [SSSSSSSS..] ctx  145 int   87 bio 4.8M    0
> 18:56:36.210735 cpu [SSSSSSSS..] ctx  139 int   88 bio 4.7M    0
> 18:56:36.310315 cpu [SSSSSSSS..] ctx  142 int   85 bio 4.7M    0
> 
> 2.6.13 # nmeter t6 c x i b d100
> 18:09:22.117959 cpu [SSSSSSSSSD] ctx   80 int   47 bio 4.7M    0
> 18:09:22.217932 cpu [SSSSSSDDDD] ctx   83 int   48 bio 4.8M    0
> 18:09:22.319200 cpu [SSSSDDDDDI] ctx   81 int   56 bio 4.7M  28k
> 18:09:22.407979 cpu [SSSSSSSSSD] ctx   60 int   38 bio 3.8M    0
> 18:09:22.517960 cpu [SSSSSSSSDI] ctx   95 int   61 bio 5.2M  52k

Well, I do not see any bursts you mention...
Anyway, my data:

# uname -a
Linux firebird 2.6.12-r4 #1 SMP Sun Jul 17 13:51:47 EEST 2005 i686 unknown unknown GNU/Linux

hda:

13:52:05.401922 cpu [..........] ctx    4 int   64 bio    0    0
13:52:05.500900 cpu [..........] ctx    6 int  100 bio    0    0
13:52:05.600879 cpu [..........] ctx    2 int  102 bio    0    0
13:52:05.700857 cpu [..........] ctx    5 int  101 bio    0    0
13:52:05.800836 cpu [..........] ctx    6 int  103 bio    0    0
13:52:05.900815 cpu [..........] ctx    2 int  100 bio    0    0
13:52:06.000795 cpu [..........] ctx    2 int  102 bio    0    0
13:52:06.100776 cpu [..........] ctx    3 int  100 bio    0    0
13:52:06.200752 cpu [..........] ctx    2 int  100 bio    0    0
13:52:06.300731 cpu [..........] ctx    2 int  100 bio    0    0
13:52:06.401724 cpu [SSDDDD....] ctx   36 int  133 bio 857k    0
13:52:06.501749 cpu [SSSSSSDDDI] ctx   44 int  134 bio 3.2M    0
13:52:06.601721 cpu [SSSSSSDDII] ctx   38 int  161 bio 4.0M    0
13:52:06.701674 cpu [SSSSSSDDDI] ctx   43 int  141 bio 3.7M    0
13:52:06.802877 cpu [SSSSSSDDDI] ctx   33 int  148 bio 3.6M    0
13:52:06.901690 cpu [SSSSSSSDDI] ctx   40 int  140 bio 3.5M    0
13:52:07.001663 cpu [SSSSSSDDDI] ctx   37 int  139 bio 4.1M    0
13:52:07.102638 cpu [SSSSSSUDDI] ctx   38 int  150 bio 4.1M    0
13:52:07.201653 cpu [SSSSSSSDDI] ctx   45 int  148 bio 4.1M    0
13:52:07.301605 cpu [SSSSSSSDII] ctx   38 int  142 bio 4.0M    0
13:52:07.401556 cpu [SSSSSSDDDI] ctx   42 int  143 bio 4.0M    0
13:52:07.501513 cpu [SSSSSSSDDI] ctx   35 int  145 bio 4.1M    0
13:52:07.601485 cpu [SSSSSSSDDI] ctx   29 int  142 bio 3.6M    0
13:52:07.701839 cpu [SSSSSSSSDI] ctx   30 int  141 bio 4.0M    0
13:52:07.801519 cpu [SSSSSSDDII] ctx   34 int  147 bio 4.0M    0
13:52:07.901527 cpu [SSSSSSSDDI] ctx   32 int  141 bio 4.1M    0
13:52:08.001448 cpu [SSSSSSSDDI] ctx   53 int  150 bio 3.7M    0
13:52:08.101378 cpu [SSSSSSDDDI] ctx   47 int  138 bio 3.7M    0
13:52:08.201395 cpu [SSSSSSSSDI] ctx   44 int  138 bio 3.8M    0
13:52:08.301555 cpu [SSSSSDDDII] ctx   33 int  136 bio 3.3M    0
13:52:08.402275 cpu [SSSSSSSDDD] ctx   43 int  150 bio 3.7M  16k
13:52:08.501617 cpu [SSSSSSSSDI] ctx   35 int  142 bio 4.0M    0
13:52:08.601614 cpu [SSSSSSSDDI] ctx   46 int  148 bio 4.0M    0
13:52:08.701250 cpu [SSSSSDDDDI] ctx   36 int  129 bio 2.7M    0
13:52:08.801316 cpu [SSSSSSSDDI] ctx   41 int  154 bio 3.8M    0
13:52:08.902231 cpu [SSSSSSSDDI] ctx   42 int  140 bio 3.8M    0
13:52:09.001419 cpu [SSSSSSSDDI] ctx   36 int  142 bio 4.1M    0
13:52:09.102196 cpu [SSSSSSSSDI] ctx   43 int  140 bio 3.8M    0
13:52:09.201450 cpu [SSSSSSDDII] ctx   34 int  142 bio 4.1M    0
13:52:09.301176 cpu [SSSSSSSDDI] ctx   39 int  138 bio 3.8M    0
13:52:09.401806 cpu [SSSSSSSSDI] ctx   55 int  157 bio 4.3M    0
13:52:09.501077 cpu [SSSSDDDDDI] ctx   32 int  121 bio 2.2M    0
13:52:09.601067 cpu [SSSDDDDDDD] ctx   24 int  127 bio 1.7M    0
13:52:09.701108 cpu [SSSSSSSDDI] ctx   50 int  153 bio 4.1M    0
13:52:09.802156 cpu [SSSSDDDDII] ctx   34 int  139 bio 2.7M    0
13:52:09.902026 cpu [SSSSSSSSDD] ctx   44 int  152 bio 4.0M    0
13:52:10.002041 cpu [SSSSDDDDDI] ctx   39 int  126 bio 2.2M    0
13:52:10.100997 cpu [SSSSDDDDDI] ctx   46 int  129 bio 2.7M    0
13:52:10.201964 cpu [SSSSSSSDDI] ctx   57 int  139 bio 3.6M    0
13:52:10.303468 cpu [SSSSDDDDDI] ctx   34 int  133 bio 2.2M    0
13:52:10.401523 cpu [SSSSSSSDDI] ctx   50 int  145 bio 3.6M 4096
13:52:10.500934 cpu [SSSSSSSSII] ctx   66 int  139 bio 4.1M    0
13:52:10.601854 cpu [SSSSSSSSDI] ctx   59 int  147 bio 4.0M    0
13:52:10.701938 cpu [SSSSSSSDDI] ctx   46 int  151 bio 3.7M    0
13:52:10.801827 cpu [SSSSSSSDDI] ctx   47 int  153 bio 4.0M    0
13:52:10.900829 cpu [SSSSSSSDII] ctx   58 int  142 bio 4.1M 100k
13:52:11.000810 cpu [SSSSSSSDII] ctx   62 int  153 bio 4.0M    0
13:52:11.100836 cpu [SSSSSSSSDI] ctx   57 int  143 bio 4.1M    0
13:52:11.201740 cpu [SSSSSSSDII] ctx   54 int  154 bio 4.1M    0
13:52:11.300827 cpu [SSSSSSSSDI] ctx   66 int  138 bio 4.1M    0
13:52:11.402139 cpu [SSSSSSSDII] ctx   62 int  149 bio 4.0M 4096
13:52:11.501748 cpu [SSSSSSSSDI] ctx   55 int  142 bio 4.1M    0
13:52:11.601638 cpu [SSSSSSSSDI] ctx   58 int  144 bio 4.0M    0
13:52:11.701665 cpu [SSSSSSSDII] ctx   59 int  143 bio 4.1M    0
13:52:11.801702 cpu [SSSSSSSSDI] ctx   57 int  142 bio 4.1M    0
13:52:11.900620 cpu [SSSSSSDDII] ctx   60 int  147 bio 3.9M  76k
13:52:12.001602 cpu [SSSSSSSSDI] ctx   59 int  141 bio 4.1M    0
13:52:12.102003 cpu [SSSSSSSSDI] ctx   60 int  141 bio 4.1M    0
13:52:12.202031 cpu [SSSSSSSDII] ctx   46 int  154 bio 4.1M    0
13:52:12.300878 cpu [SSSSSSSSDI] ctx   56 int  138 bio 4.0M    0
13:52:12.401747 cpu [SSSSSSSDDI] ctx   56 int  149 bio 4.1M    0
13:52:12.501482 cpu [SSSSSSSSDI] ctx   62 int  140 bio 4.0M    0
13:52:12.600455 cpu [SSSSSSSDII] ctx   57 int  151 bio 4.0M    0
13:52:12.700400 cpu [SSSSSUDDDI] ctx   35 int  138 bio 2.6M    0
13:52:12.801719 cpu [SSSSSSSDDI] ctx   48 int  140 bio 3.7M    0
13:52:12.901651 cpu [SSSSSSSSDI] ctx   50 int  148 bio 4.0M    0
13:52:13.001352 cpu [SSSSSSDDII] ctx   43 int  138 bio 4.1M    0
13:52:13.103070 cpu [SSSSSSSDDI] ctx   47 int  151 bio 4.0M    0
13:52:13.201283 cpu [SSSSSSD...] ctx   41 int  123 bio 2.3M    0
13:52:13.301254 cpu [..........] ctx    2 int  101 bio    0    0
13:52:13.401230 cpu [..........] ctx    2 int  100 bio    0    0
13:52:13.501211 cpu [..........] ctx    4 int  100 bio    0    0
13:52:13.601189 cpu [..........] ctx    2 int  102 bio    0    0
13:52:13.701168 cpu [..........] ctx    2 int  100 bio    0    0
13:52:13.801146 cpu [..........] ctx    2 int  101 bio    0    0
13:52:13.901125 cpu [..........] ctx    2 int  100 bio    0    0

/dev/hda:

 Model=SAMSUNG SV0411N, FwRev=UA100-07, SerialNo=S01RJ10X122455
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78242976
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: (null): 

 * signifies the current active mode

Note: CPU is mostly busy in system (S), not in disk wait (D).
My CPU is not that new:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Celeron(TM) CPU                1200MHz
stepping        : 1
cpu MHz         : 1196.195
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2359.29


hdc (an old disk):

13:52:38.701903 cpu [..........] ctx    3 int  101 bio    0    0
13:52:38.801869 cpu [..........] ctx    2 int  100 bio    0    0
13:52:38.901849 cpu [..........] ctx    2 int  101 bio    0    0
13:52:39.001830 cpu [..........] ctx    4 int  101 bio    0    0
13:52:39.101107 cpu [SUDDDDDDI.] ctx   24 int  108 bio 1.0M    0
13:52:39.202024 cpu [SSDDDDDDDD] ctx   21 int  111 bio 1.2M    0
13:52:39.301787 cpu [SSDDDDDDDD] ctx   21 int  109 bio 1.2M    0
13:52:39.401764 cpu [SSDDDDDDDI] ctx   27 int  112 bio 1.2M    0
13:52:39.501744 cpu [SSDDDDDDDD] ctx   22 int  110 bio 1.2M    0
13:52:39.601725 cpu [SSDDDDDDDI] ctx   24 int  111 bio 1.2M    0
13:52:39.701702 cpu [SSDDDDDDDD] ctx   27 int  110 bio 1.2M    0
13:52:39.801677 cpu [SSDDDDDDDD] ctx   28 int  111 bio 1.2M    0
13:52:39.901909 cpu [SSDDDDDDDI] ctx   26 int  110 bio 1.2M    0
13:52:40.001772 cpu [SSDDDDDDDD] ctx   25 int  110 bio 1.1M    0
13:52:40.100723 cpu [SSDDDDDDDI] ctx   25 int  111 bio 1.2M    0
13:52:40.201718 cpu [SSSDDDDDDD] ctx   26 int  112 bio 1.2M    0
13:52:40.301569 cpu [SSDDDDDDDD] ctx   28 int  109 bio 1.2M    0
13:52:40.402552 cpu [SSDDDDDDDI] ctx   23 int  111 bio 1.2M    0
13:52:40.502535 cpu [SSDDDDDDDD] ctx   22 int  110 bio 1.2M    0
13:52:40.601507 cpu [SSDDDDDDDI] ctx   26 int  111 bio 1.2M    0
13:52:40.701493 cpu [SSDDDDDDDD] ctx   23 int  110 bio 1.2M    0
13:52:40.801470 cpu [SSDDDDDDDI] ctx   24 int  110 bio 1.2M    0
13:52:40.901451 cpu [SSDDDDDDDD] ctx   23 int  111 bio 1.2M    0
13:52:41.001448 cpu [SSDDDDDDDI] ctx   26 int  110 bio 1.2M    0
13:52:41.101449 cpu [SSDDDDDDDD] ctx   24 int  111 bio 1.1M    0
13:52:41.201394 cpu [SSDDDDDDDD] ctx   24 int  110 bio 1.2M    0
13:52:41.302404 cpu [SSDDDDDDDI] ctx   23 int  112 bio 1.2M    0
13:52:41.402345 cpu [SSDDDDDDDD] ctx   23 int  109 bio 1.2M    0
13:52:41.501318 cpu [SSDDDDDDDI] ctx   23 int  109 bio 1.2M    0
13:52:41.602298 cpu [SSDDDDDDDD] ctx   26 int  115 bio 1.2M    0
13:52:41.702281 cpu [SSDDDDDDDI] ctx   23 int  112 bio 1.2M    0
13:52:41.802260 cpu [SSDDDDDDDD] ctx   24 int  110 bio 1.2M    0
13:52:41.902239 cpu [SSSDDDDDDI] ctx   35 int  116 bio 1.2M 124k
13:52:42.002220 cpu [SSDDDDDDDD] ctx   24 int  132 bio 1.2M  92k
13:52:42.102199 cpu [SSDDDDDDDI] ctx   25 int  113 bio 1.2M    0
13:52:42.203194 cpu [SSDDDDDDDD] ctx   23 int  111 bio 1.2M    0
13:52:42.302944 cpu [SSDDDDDDDD] ctx   22 int  111 bio 1.2M    0
13:52:42.402144 cpu [SSDDDDDDDI] ctx   23 int  109 bio 1.1M    0
13:52:42.502114 cpu [SSDDDDDDDD] ctx   22 int  110 bio 1.2M    0
13:52:42.601088 cpu [SSDDDDDDDI] ctx   27 int  110 bio 1.2M    0
13:52:42.702070 cpu [SSDDDDDDDD] ctx   23 int  113 bio 1.2M    0
13:52:42.802048 cpu [SSSUDDDDDD] ctx   23 int  110 bio 1.2M    0
13:52:42.902029 cpu [SSDDDDDDDI] ctx   23 int  111 bio 1.2M    0
13:52:43.002007 cpu [SSDDDDDDDD] ctx   25 int  111 bio 1.2M    0
13:52:43.101981 cpu [SSDDDDDDDD] ctx   25 int  111 bio 1.2M    0
13:52:43.201966 cpu [SSDDDDDDDI] ctx   23 int  111 bio 1.2M    0
13:52:43.301945 cpu [SSDDDDDDDD] ctx   24 int  110 bio 1.2M    0
13:52:43.402606 cpu [SSDDDDDDDI] ctx   27 int  111 bio 1.2M    0
13:52:43.501933 cpu [SSDDDDDDDD] ctx   23 int  109 bio 1.1M    0
13:52:43.601882 cpu [SSDDDDDDDI] ctx   24 int  112 bio 1.2M    0
13:52:43.701860 cpu [SSDDDDDDDD] ctx   23 int  112 bio 1.2M    0
13:52:43.801839 cpu [SSDDDDDDDI] ctx   23 int  110 bio 1.2M    0
13:52:43.901820 cpu [SSDDDDDDDD] ctx   24 int  111 bio 1.2M    0
13:52:44.001792 cpu [SSDDDDDDDD] ctx   24 int  111 bio 1.2M    0
13:52:44.101809 cpu [SSSDDDDDDI] ctx   23 int  110 bio 996k    0
13:52:44.201740 cpu [SSSSSSSS..] ctx   12 int  100 bio    0    0
13:52:44.301706 cpu [..........] ctx    2 int  100 bio    0    0
13:52:44.402686 cpu [..........] ctx    2 int  102 bio    0    0
13:52:44.502664 cpu [..........] ctx    2 int  100 bio    0    0
13:52:44.602643 cpu [..........] ctx    4 int  100 bio    0    0
13:52:44.702621 cpu [..........] ctx    4 int  104 bio    0    0

/dev/hdc:

 Model=Maxtor 90640D4, FwRev=PAS24F15, SerialNo=V41Y3ABA
 Config={ Fixed }
 RawCHS=13328/15/63, TrkSize=0, SectSize=0, ECCbytes=29
 BuffType=DualPortCache, BuffSize=256kB, MaxMultSect=16, MultSect=16
 CurCHS=13328/15/63, CurSects=12594960, LBA=yes, LBAsects=12594960
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4

 * signifies the current active mode
--
vda
