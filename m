Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273282AbRIWFUf>; Sun, 23 Sep 2001 01:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273289AbRIWFUZ>; Sun, 23 Sep 2001 01:20:25 -0400
Received: from h24-76-60-12.vf.shawcable.net ([24.76.60.12]:3200 "HELO
	g-box.vf.shawcable.net") by vger.kernel.org with SMTP
	id <S273282AbRIWFUO>; Sun, 23 Sep 2001 01:20:14 -0400
Date: Sat, 22 Sep 2001 22:20:13 -0700 (PDT)
From: GregoryFinch@home.com
Reply-To: GregoryFinch@home.com
Subject: More benchmarks of Preemptable Kernel
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010923052017.0F7B8597D3@g-box.vf.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are my latest results with preempt patch.

Dual P3-550, 256MB ram, no swap, both kernels with CONFIG_SMP=y, 440BX,
2-20GB 5400rpm drives, all partitions now mounted with noatime option as
I've noticed a nice speed improvement, and don't have any software that
cares about atimes.

All benchmarks running in an Eterm on E on XF86-4.1.0-DRI with xmms running to
listen for latency probs. Benchmarks run as root, everything else as regular
user.

linux-2.4.10-pre14

Throughput 35.8872 MB/sec (NB=44.859 MB/sec  358.872 MBit/sec)
Throughput 36.6262 MB/sec (NB=45.7827 MB/sec  366.262 MBit/sec)
Throughput 34.7709 MB/sec (NB=43.4636 MB/sec  347.709 MBit/sec)
Throughput 35.7473 MB/sec (NB=44.6841 MB/sec  357.473 MBit/sec)
Throughput 35.6551 MB/sec (NB=44.5689 MB/sec  356.551 MBit/sec)
loadavg around 11

Bonnie
              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
         1024  9211 99.8 17227 16.0  6085  9.7  6208 79.4 22711 21.6  96.7  1.9

System is buttery smooth during above benchmarks, as well as with a
dbench 32, although throughput drops off to the same as
linux-2.4.10pre6. A dbench 64 starts impacting usability and causes
quite a few short skips in xmms. The recent changes to the vm and vfs
components of the kernel have really improved things.

linux-2.4.10-pre14 with rml netdev-random-pre13 patch and rml-preempt-pre13 patch
(both applied cleanly to pre14)

Throughput 32.1798 MB/sec (NB=40.2248 MB/sec  321.798 MBit/sec)
Throughput 35.9245 MB/sec (NB=44.9057 MB/sec  359.245 MBit/sec)
Throughput 36.0735 MB/sec (NB=45.0918 MB/sec  360.735 MBit/sec)
Throughput 32.8641 MB/sec (NB=41.0801 MB/sec  328.641 MBit/sec)
Throughput 33.5652 MB/sec (NB=41.9565 MB/sec  335.652 MBit/sec)
loadavg around 10

Bonnie
              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
         1024  9145 99.6 17213 15.6  6109  9.4  6199 79.9 23509 21.6  95.7  1.7

System is almost the same as with the vanilla kernel. Perfectly smooth
for the above benchmarks, as well as with dbench 32. The difference is
with dbench 64. System is much better behaved, X froze twice, once for
20 secs, once for 10 secs. There were also about 10 short (less than
1sec) glitches in X as well. xmms didn't skip once. All in all, I'm
really impressed at the usability of my system with the preempt patch.
During the dbench 64 run, I started up another Eterm to see what the
loadavg was. It only took about 1 sec longer to start than when the
system is unloaded, and that's with a loadavg of 66!

I'm looking forward to playing with 2.5 and hopefully seeing something
similar to this idea making it into linus' tree.

--
Gregory Finch

