Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbQLaC6x>; Sat, 30 Dec 2000 21:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132103AbQLaC6n>; Sat, 30 Dec 2000 21:58:43 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:52455 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S135680AbQLaC6b>; Sat, 30 Dec 2000 21:58:31 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] VM fixes + RSS limits 2.4.0-test13-pre5 / test13-pre7
Date: Sun, 31 Dec 2000 03:30:39 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00123103303900.00634@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,

I did some more benchmarks on this --- puh, took me some time...:-)

Test machine: 256 MB, K7 550 SlotA, SCSI, IDE, ReiserFS 3.6.23, Blocksize=4K
Test: dbench 48

2.4.0-test13-pre5 + Rik's VM fix #2

/dev/sda7:
 Timing buffered disk reads:  64 MB in  6.07 seconds = 10.54 MB/sec

Throughput 7.54785 MB/sec (NB=9.43482 MB/sec  75.4785 MBit/sec)
41.200u 95.870s 13:59.50 16.3%  0+0k 0+0io 1797pf+0w

-O -mcpu=k6 -mpreferred-stack-boundary=2 -malign-functions=4
-fschedule-insns2 -fexpensive-optimizations

Throughput 7.7981 MB/sec (NB=9.74762 MB/sec  77.981 MBit/sec)
42.180u 96.620s 13:32.54 17.0%  0+0k 0+0io 1799pf+0w

--------------------------------------------------

/dev/hdc1:
 Timing buffered disk reads:  64 MB in  2.89 seconds = 22.15 MB/sec

Throughput 9.4113 MB/sec (NB=11.7641 MB/sec  94.113 MBit/sec)
36.990u 117.720s 11:13.24 22.9% 0+0k 0+0io 1505pf+0w

-O -mcpu=k6 -mpreferred-stack-boundary=2 -malign-functions=4
-fschedule-insns2 -fexpensive-optimizations

Throughput 10.254 MB/sec (NB=12.8175 MB/sec  102.54 MBit/sec)
36.620u 112.870s 10:17.91 24.1% 0+0k 0+0io 1505pf+0w

*******************************************************************************

2.4.0-test13-pre7

/dev/sda7:
 Timing buffered disk reads:  64 MB in  6.07 seconds = 10.54 MB/sec

Throughput 9.61382 MB/sec (NB=12.0173 MB/sec  96.1382 MBit/sec)
43.950u 96.790s 10:59.06 21.3%  0+0k 0+0io 1746pf+0w

-O -mcpu=k6 -mpreferred-stack-boundary=2 -malign-functions=4
-fschedule-insns2 -fexpensive-optimizations

Throughput 10.8312 MB/sec (NB=13.539 MB/sec  108.312 MBit/sec)
44.510u 93.000s 9:44.99 23.5%   0+0k 0+0io 1795pf+0w

-------------------------------------------------

/dev/hdc1:
 Timing buffered disk reads:  64 MB in  2.89 seconds = 22.15 MB/sec

Throughput 12.3312 MB/sec (NB=15.414 MB/sec  123.312 MBit/sec)
35.220u 112.630s 8:33.83 28.7%  0+0k 0+0io 1505pf+0w

-O -mcpu=k6 -mpreferred-stack-boundary=2 -malign-functions=4
-fschedule-insns2 -fexpensive-optimizations

Throughput 14.4331 MB/sec (NB=18.0414 MB/sec  144.331 MBit/sec)
36.060u 119.760s 7:19.00 35.4%  0+0k 0+0io 1505pf+0w

Addition:
Your fix show some 'bad' swap behavior on my 'normal' load (3D medical 
visualization). It do some 'little' swap out and in. Mostly the (not needed?) 
swap in hurts performance. A little 'cp -a X11R6 X11R6-new' take more than 2 
times longer. If my system hits the 'ZERO swap wall' the currently running 
process (render) abort immediately and restart. With test13-pre7 it runs 
several times longer (render generates some more frames) but then load goes 
up to 10 and render would be killed.

SunWave1>cat /proc/version
Linux version 2.4.0-test13-pre7 (root@SunWave1) (gcc version 2.95.2 19991024 
(release)) #1 Sat Dec 30 22:13:04 CET 2000
SunWave1>free -t
             total       used       free     shared    buffers     cached
Mem:        255728     164980      90748          0      34160      46488
-/+ buffers/cache:      84332     171396
Swap:       200772          8     200764
Total:      456500     164988     291512

Happy New Year!
I'll be back on Monday.

-Dieter

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
