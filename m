Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274333AbRITGbd>; Thu, 20 Sep 2001 02:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274335AbRITGbY>; Thu, 20 Sep 2001 02:31:24 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:32149 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274333AbRITGbS>; Thu, 20 Sep 2001 02:31:18 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Thu, 20 Sep 2001 08:31:34 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010920063121Z274333-760+14427@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. September 2001 00:44 schrieb Robert Love:
> Available at:
> http://tech9.net/rml/linux/patch-rml-2.4.9-ac12-preempt-stats-1 and
> http://tech9.net/rml/linux/patch-rml-2.4.10-pre12-preempt-stats-1
> for 2.4.9-ac12 and 2.4.10-pre12, respectively.
>
> This patch is provided thanks to MontaVista (http://mvista.com).

Great, thanks.

Here are some results for 2.4.10-pre12 (Andrea's VM :-)

Athlon II 1 GHz (0.18 µm)
MSI MS-6167 Rev 1.0B (Irongate C4)
640 MB PC100-2-2-2 SDRAM
IBM DDYS 18 GB U160 (on AHA-2940UW)
ReiserFS 3.6 on all partitions

Sound driver is the new kernel one for SB Live! (not ALSA).
No swap used during whole test.

2.4.10-pre12 + patch-rml-2.4.10-pre12-preempt-kernel-1 + 
patch-rml-2.4.10-pre12-preempt-stats-1

Hope my numbers help to find the right reason for the hiccups.
ReiserFS seems _NOT_ to be the culprit for this.
Maybe the scheduler it self?

-Dieter

KDE-2.2.1 noatun running MP3/Ogg-Vorbis
+
time ./dbench 16
Throughput 29.3012 MB/sec (NB=36.6265 MB/sec  293.012 MBit/sec)
7.450u 28.830s 1:13.10 49.6%    0+0k 0+0io 511pf+0w
load: 1140

Worst 20 latency times of 5583 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  5664  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  2586        BKL        1  1302/inode.c         c016f2f9  1381/sched.c
  2329        BKL        0  1302/inode.c         c016f2f9   842/inode.c
  2231        BKL        1  1302/inode.c         c016f2f9   697/sched.c
  2088        BKL        1  1437/namei.c         c014c42f   697/sched.c
  1992        BKL        0    30/inode.c         c016cdf1  1381/sched.c
  1953        BKL        1  1302/inode.c         c016f2f9    52/inode.c
  1952        BKL        0  1302/inode.c         c016f2f9  1380/sched.c
  1947        BKL        1    30/inode.c         c016cdf1   697/sched.c
  1923   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
  1908        BKL        0  1302/inode.c         c016f2f9  1306/inode.c
  1904        BKL        1   452/exit.c          c011af61   697/sched.c
  1892        BKL        1   129/attr.c          c015765d   697/sched.c
  1875        BKL        0  1437/namei.c         c014c42f  1381/sched.c
  1823  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
  1790   reacqBKL        0  1375/sched.c         c0114d94  1439/namei.c
  1779        BKL        1  1366/namei.c         c014c12c  1381/sched.c
  1762  spin_lock        0   547/sched.c         c0112fe4  1380/sched.c
  1756   reacqBKL        1  1375/sched.c         c0114d94    52/inode.c
  1754        BKL        0   927/namei.c         c014b2bf  1381/sched.c


time ./dbench 32
Throughput 28.0138 MB/sec (NB=35.0172 MB/sec  280.138 MBit/sec)
14.570u 61.520s 2:31.80 50.1%   0+0k 0+0io 911pf+0w
load: 2690

Worst 20 latency times of 8091 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  8347        BKL        1   533/inode.c         c016d96d   842/inode.c
  7808  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  6181        BKL        1  1302/inode.c         c016f2f9  1381/sched.c
  3325        BKL        1  1302/inode.c         c016f2f9   842/inode.c
  3314  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
  3014        BKL        1   129/attr.c          c015765d   697/sched.c
  2956        BKL        1  1302/inode.c         c016f2f9  1380/sched.c
  2954   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  2795        BKL        1   927/namei.c         c014b2bf   697/sched.c
  2750        BKL        1  1302/inode.c         c016f2f9   697/sched.c
  2667        BKL        1    30/inode.c         c016cdf1   697/sched.c
  2623  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c
  2613  spin_lock        0  1376/sched.c         c0114db3  1306/inode.c
  2566   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
  2527        BKL        0  1437/namei.c         c014c42f   697/sched.c
  2526        BKL        0  1437/namei.c         c014c42f  1380/sched.c
  2525  spin_lock        1   547/sched.c         c0112fe4  1380/sched.c
  2513        BKL        0   927/namei.c         c014b2bf  1380/sched.c
  2442        BKL        0    30/inode.c         c016cdf1  1381/sched.c
  2353        BKL        0   452/exit.c          c011af61  1380/sched.c


time ./dbench 40
Throughput 24.664 MB/sec (NB=30.83 MB/sec  246.64 MBit/sec)
18.690u 77.980s 3:35.09 44.9%   0+0k 0+0io 1111pf+0w
load: 3734

Worst 20 latency times of 7340 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  9313  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  9040        BKL        1  1302/inode.c         c016f2f9  1306/inode.c
  8530        BKL        1  1302/inode.c         c016f2f9   842/inode.c
  8268   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  5432  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
  3630   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  3519        BKL        1  1437/namei.c         c014c42f  1380/sched.c
  3387        BKL        0  1302/inode.c         c016f2f9   697/sched.c
  3194  spin_lock        0   547/sched.c         c0112fe4  1380/sched.c
  3180  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
  3015  spin_lock        1   547/sched.c         c0112fe4   842/inode.c
  2894        BKL        0  1302/inode.c         c016f2f9  1381/sched.c
  2778  spin_lock        1  1376/sched.c         c0114db3  1380/sched.c
  2755        BKL        1  1302/inode.c         c016f2f9  1380/sched.c
  2676        BKL        1   452/exit.c          c011af61   697/sched.c
  2354        BKL        1   533/inode.c         c016d96d   697/sched.c
  2237        BKL        0    30/inode.c         c016cdf1   697/sched.c
  2104        BKL        0  1437/namei.c         c014c42f  1381/sched.c
  2097  spin_lock        0  1376/sched.c         c0114db3  1381/sched.c
  2082        BKL        0    30/inode.c         c016cdf1  1380/sched.c


time ./dbench 48
Throughput 24.5409 MB/sec (NB=30.6761 MB/sec  245.409 MBit/sec)
22.080u 97.560s 4:19.19 46.1%   0+0k 0+0io 1311pf+0w
load: 4622

Worst 20 latency times of 10544 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 12831        BKL        1    30/inode.c         c016cdf1    52/inode.c
 10869   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  9303        BKL        1  1302/inode.c         c016f2f9   697/sched.c
  9145        BKL        1  1302/inode.c         c016f2f9  1306/inode.c
  7984  spin_lock        1   547/sched.c         c0112fe4  1380/sched.c
  5983        BKL        1  1302/inode.c         c016f2f9   842/inode.c
  4947   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  4497  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
  4310  spin_lock        1  1376/sched.c         c0114db3  1380/sched.c
  4290   reacqBKL        0  1375/sched.c         c0114d94  1306/inode.c
  4002  spin_lock        1   547/sched.c         c0112fe4  1381/sched.c
  3822  spin_lock        0  1376/sched.c         c0114db3   697/sched.c
  3683        BKL        0  1302/inode.c         c016f2f9  1380/sched.c
  3422  spin_lock        1   547/sched.c         c0112fe4  1306/inode.c
  3193        BKL        0  1437/namei.c         c014c42f  1380/sched.c
  3006        BKL        1    30/inode.c         c016cdf1  1380/sched.c
  2990        BKL        1   129/attr.c          c015765d   697/sched.c
  2971        BKL        1  1437/namei.c         c014c42f  1381/sched.c
  2939        BKL        0   927/namei.c         c014b2bf  1381/sched.c
  2862        BKL        0  1302/inode.c         c016f2f9  1381/sched.c


KDE-2.2.1 noatun running MP3/Ogg-Vorbis

Worst 20 latency times of 2252 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
   237        BKL        0  2763/buffer.c        c01410aa   697/sched.c
   218  spin_lock        0   547/sched.c         c0112fe4  1381/sched.c
   215   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
   215        BKL        0  2763/buffer.c        c01410aa  1381/sched.c
   205        BKL        0   359/buffer.c        c013d1bc  1381/sched.c
   205       eth1        0   585/irq.c           c010886f   647/irq.c
   149  spin_lock        0   547/sched.c         c0112fe4   697/sched.c
   147        BKL        0   359/buffer.c        c013d1bc   697/sched.c
   135  spin_lock        0  1376/sched.c         c0114db3  1380/sched.c
   130   reacqBKL        0  1375/sched.c         c0114d94   697/sched.c
   111        BKL        0   452/exit.c          c011af61   697/sched.c
   105    unknown        1    76/softirq.c       c011c634   119/softirq.c
    86        BKL        4   712/tty_io.c        c018cf6b   714/tty_io.c
    61  spin_lock        0  1715/dev.c           c01dc4b3  1728/dev.c
    58        BKL        0   301/namei.c         c0149db1   303/namei.c
    56  spin_lock        2   468/netfilter.c     c01e4303   119/softirq.c
    44        BKL        1    59/ioctl.c         c014ea3a   111/ioctl.c
    43        BKL        0  1302/inode.c         c016f2f9  1306/inode.c
    43  spin_lock        1    69/i387.c          c010ca23   227/mmx.c
    42        BKL        1    26/readdir.c       c014ed07    28/readdir.c


Renice -20 both artsd prozesses (the KDE-2.2.1 noatun sound daemon)
help a little bit but there are still some hiccups (1~3 sec)
remaining.

But the system is very responsive (mouse, keyboard).

time ./dbench 16
Throughput 30.8602 MB/sec (NB=38.5752 MB/sec  308.602 MBit/sec)
7.490u 29.350s 1:09.44 53.0%    0+0k 0+0io 511pf+0w

Worst 20 latency times of 5851 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  5518  spin_lock        1  1376/sched.c         c0114db3  1380/sched.c
  2553        BKL        1  1302/inode.c         c016f2f9   697/sched.c
  2284        BKL        0  1302/inode.c         c016f2f9   842/inode.c
  2235   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  2227        BKL        0  1302/inode.c         c016f2f9  1380/sched.c
  2183        BKL        0   927/namei.c         c014b2bf  1306/inode.c
  2055        BKL        1   927/namei.c         c014b2bf   697/sched.c
  2037        BKL        1   452/exit.c          c011af61   697/sched.c
  2032        BKL        0    30/inode.c         c016cdf1   697/sched.c
  2008        BKL        1  1302/inode.c         c016f2f9  1381/sched.c
  1943        BKL        0   927/namei.c         c014b2bf  1439/namei.c
  1926        BKL        1   452/exit.c          c011af61    52/inode.c
  1919  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  1880        BKL        0  1437/namei.c         c014c42f  1381/sched.c
  1865        BKL        0    30/inode.c         c016cdf1  1380/sched.c
  1858  spin_lock        0   547/sched.c         c0112fe4  1380/sched.c
  1849   reacqBKL        0  1375/sched.c         c0114d94  1439/namei.c
  1821   reacqBKL        0  1375/sched.c         c0114d94   697/sched.c
  1774        BKL        1   129/attr.c          c015765d   697/sched.c
  1720        BKL        1  1437/namei.c         c014c42f  1380/sched.c


time ./dbench 48
Throughput 22.85 MB/sec (NB=28.5626 MB/sec  228.5 MBit/sec)
21.840u 98.560s 4:38.30 43.2%   0+0k 0+0io 1311pf+0w

Worst 20 latency times of 8664 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 11179  spin_lock        1   547/sched.c         c0112fe4   697/sched.c
 10943        BKL        1  1302/inode.c         c016f2f9   697/sched.c
 10798  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
  9367  spin_lock        1  1376/sched.c         c0114db3  1306/inode.c
  7230  spin_lock        1  1376/sched.c         c0114db3  1381/sched.c
  6870  spin_lock        1   547/sched.c         c0112fe4  1381/sched.c
  5610   reacqBKL        1  1375/sched.c         c0114d94  1381/sched.c
  5356  spin_lock        0   547/sched.c         c0112fe4  1380/sched.c
  4162   reacqBKL        0  1375/sched.c         c0114d94  1306/inode.c
  4068   reacqBKL        1  1375/sched.c         c0114d94   697/sched.c
  3335        BKL        0  1302/inode.c         c016f2f9  1380/sched.c
  3161  spin_lock        1  1376/sched.c         c0114db3  1380/sched.c
  3030        BKL        1  1437/namei.c         c014c42f   697/sched.c
  2974        BKL        0  1437/namei.c         c014c42f  1380/sched.c
  2832        BKL        0  1302/inode.c         c016f2f9  1381/sched.c
  2817        BKL        0   927/namei.c         c014b2bf  1380/sched.c
  2713  spin_lock        1   483/dcache.c        c0153efa   520/dcache.c
  2522  spin_lock        1   547/sched.c         c0112fe4  1306/inode.c
  2522        BKL        0   533/inode.c         c016d96d  1381/sched.c
  2508        BKL        0   533/inode.c         c016d96d   929/namei.c
