Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270354AbRHHGjg>; Wed, 8 Aug 2001 02:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270355AbRHHGjQ>; Wed, 8 Aug 2001 02:39:16 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:28362 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S270354AbRHHGjK>; Wed, 8 Aug 2001 02:39:10 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.4.7-ac4 disk thrashing
Date: Wed, 8 Aug 2001 08:38:16 +0200
X-Mailer: KMail [version 1.2.3]
Cc: Chris Mason <mason@suse.com>, Nikita Danilov <NikitaDanilov@Yahoo.COM>,
        Daniel Phillips <phillips@bonn-fries.net>, Tom Vier <tmv5@home.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010808063914Z270354-28344+2861@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:

>switching from 2.4.7-ac3 to -ac4, disk access seems to be much more
>synchronis. running a ./configure script causes all kinds of trashing, as
>does installing .debs. i'm using reiserfs on top of software raid 0 on an
>alpha.

I can second that on 2.4.7-ac4 - ac9 (all versions).
Dbench show a dramatic decrease in disk troughput (~10 MB/sec) for every case 
I've tested. I have a ReiserFS only system and the test partition was /opt 
(/dev/sda8) with ~2.7 GB stuff on it, so we have some aging, too. It is the 
last and slowest partition on my fast IBM U160 18 GB, 10.000 RPMs disk. 

I've used 2.4.7 + acX + transaction-tracking-2 (Chris) + use-once-pages 
(Daniel).

Now, some numbers (it should be noted that the u+s times are mostly equal but 
the whole time and the throughput is different.

first lines for 2.4.7-ac3, then 2.4.7-ac9

dbench 48
Throughput 27.3983 MB/sec (NB=34.2479 MB/sec  273.983 MBit/sec)
37.580u 115.730s 3:51.30 66.2%  0+0k 0+0io 1310pf+0w

Throughput 18.4711 MB/sec (NB=23.0889 MB/sec  184.711 MBit/sec)
37.710u 121.900s 5:43.05 46.5%  0+0k 0+0io 1311pf+0w


dbench 32
Throughput 34.7552 MB/sec (NB=43.444 MB/sec  347.552 MBit/sec)
24.620u 73.980s 2:02.55 80.4%   0+0k 0+0io 911pf+0w

Throughput 21.8827 MB/sec (NB=27.3533 MB/sec  218.827 MBit/sec)
25.410u 76.610s 3:14.04 52.5%   0+0k 0+0io 912pf+0w


dbench 16
16 clients started
Throughput 37.7379 MB/sec (NB=47.1724 MB/sec  377.379 MBit/sec)
12.350u 35.330s 0:56.97 83.6%   0+0k 0+0io 511pf+0w

Throughput 30.0396 MB/sec (NB=37.5495 MB/sec  300.396 MBit/sec)
12.970u 37.320s 1:10.31 71.5%   0+0k 0+0io 511pf+0w


dbench 8
Throughput 40.9394 MB/sec (NB=51.1742 MB/sec  409.394 MBit/sec)
6.080u 17.420s 0:26.80 87.6%    0+0k 0+0io 311pf+0w

Throughput 28.174 MB/sec (NB=35.2175 MB/sec  281.74 MBit/sec)
6.280u 18.360s 0:38.49 64.0%    0+0k 0+0io 312pf+0w


dbench 4
Throughput 41.4035 MB/sec (NB=51.7544 MB/sec  414.035 MBit/sec)
3.140u 8.240s 0:13.76 82.7%     0+0k 0+0io 211pf+0w

Throughput 25.2641 MB/sec (NB=31.5801 MB/sec  252.641 MBit/sec)
3.270u 8.680s 0:21.91 54.5%     0+0k 0+0io 212pf+0w


dbench 2
Throughput 38.6387 MB/sec (NB=48.2983 MB/sec  386.387 MBit/sec)
1.680u 4.030s 0:07.83 72.9%     0+0k 0+0io 161pf+0w

Throughput 30.4352 MB/sec (NB=38.0441 MB/sec  304.352 MBit/sec)
1.690u 4.300s 0:09.68 61.8%     0+0k 0+0io 162pf+0w


dbench 1
Throughput 33.3689 MB/sec (NB=41.7111 MB/sec  333.689 MBit/sec)
0.820u 2.000s 0:04.96 56.8%     0+0k 0+0io 136pf+0w

Throughput 30.8583 MB/sec (NB=38.5729 MB/sec  308.583 MBit/sec)
0.750u 2.010s 0:05.28 52.2%     0+0k 0+0io 137pf+0w


System spec:
Athlon 550 I (yes, the first generation)
MSI MS-6167 Rev 1.0B (AMD Irongate C4, without bypass)
640 MB Pc100-2-2-2 SDRAM

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS-34560W       Rev: S71D
  Type:   Direct-Access                      ANSI SCSI revision: 02

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda3               104412     69616     34796  67% /
/dev/sda2              1518088     37392   1480696   3% /tmp
/dev/sda5              1028092    334056    694036  33% /var
/dev/sda6              2048188     87188   1961000   5% /home
/dev/sda7              5124536   1752784   3371752  35% /usr
/dev/sda8              7068348   2715860   4352488  39% /opt
tmpfs                   321188         0    321188   0% /dev/shm

Could it be that the ReiserFS cleanups in ac4 do harm?
http://marc.theaimsgroup.com/?l=reiserfs&m=99683332027428&w=2

Thanks,
	Dieter


-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
