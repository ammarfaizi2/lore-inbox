Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273014AbRIIS6J>; Sun, 9 Sep 2001 14:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273015AbRIIS5u>; Sun, 9 Sep 2001 14:57:50 -0400
Received: from h24-76-60-12.vf.shawcable.net ([24.76.60.12]:13440 "HELO
	g-box.vf.shawcable.net") by vger.kernel.org with SMTP
	id <S273014AbRIIS52>; Sun, 9 Sep 2001 14:57:28 -0400
Date: Sun, 9 Sep 2001 11:57:24 -0700 (PDT)
From: grue@lakesweb.com
Reply-To: grue@lakesweb.com
Subject: Re: Feedback on preemptible kernel patch
To: rml@tech9.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <999928066.903.18.camel@phantasy>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010909185727.586B1597C5@g-box.vf.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Just finished running some benchmarks on my workstation.
Dual P3-550, 256MB ram, no swap, both kernels with CONFIG_SMP=y, 440BX,
2-20GB 5400rpm drives.

All benchmarks running in an Eterm on E on XF86-4.1.0-DRI with xmms running to
listen for latency probs. Benchmarks run as root, everything else as regular
user.

linux-2.4.10-pre6 with rml-netdev-random patch and rml-preempt patch (pre5 patches
applied to pre6), with CONFIG_PREEMPT=y

dbench 16
Throughput 23.4608 MB/sec (NB=29.326 MB/sec  234.608 MBit/sec)
Throughput 22.6915 MB/sec (NB=28.3644 MB/sec  226.915 MBit/sec) - .5sec hiccup in xmms
Throughput 20.4314 MB/sec (NB=25.5392 MB/sec  204.314 MBit/sec) - .5sec hiccup in xmms
Throughput 27.2849 MB/sec (NB=34.1061 MB/sec  272.849 MBit/sec) - .5sec hiccup in xmms
Throughput 20.5148 MB/sec (NB=25.6435 MB/sec  205.148 MBit/sec) - 2sec and .5sec in xmms
loadavg around 14

Bonnie
              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
         1024  9002 98.0 15893 15.1  6519 10.8  6101 78.6 23330 24.4 104.3  2.2

linux-2.4.10-pre6

dbench 16
Throughput 18.1821 MB/sec (NB=22.7276 MB/sec  181.821 MBit/sec)
Throughput 22.4247 MB/sec (NB=28.0309 MB/sec  224.247 MBit/sec) - .5sec hiccup in xmms
Throughput 20.2662 MB/sec (NB=25.3328 MB/sec  202.662 MBit/sec) - 2sec hiccup in xmms
Throughput 28.4072 MB/sec (NB=35.5089 MB/sec  284.072 MBit/sec) - 3sec hiccup in xmms
Throughput 24.0549 MB/sec (NB=30.0686 MB/sec  240.549 MBit/sec)
loadavg around 14

Bonnie
              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
         1024  9173 99.4 16104 14.5  6488 10.2  6139 78.9 23260 22.1 105.1  2.3

There's no real difference in speed with either kernel, the hard drives
seem to be the bottleneck on this system.
-(root@g-box)-(~)-
->hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2491/255/63, sectors = 40031712, start = 0

The throughput from bonnie is very close to the max physical throughput
of the drives, so I'm not to concerned that there isn't much of a
difference in speed.

The biggest difference is in the usability of the system under the load.
With 2.4.10-pre6 vanilla, dbench seriously affects the interactivity of
X, as well as causes some long interuptions in xmms. With preempt
enabled, this is much improved. Still some interuptions in xmms, but the
system is still usable, although a little sluggish. On the vanilla
kernel, even bonnie caused a couple of hiccups in xmms, with preempt
enabled, bonnie didn't affect xmms at all. all programs were run without
altering nice values at all.

For a workstation, I like the difference, my system is still usable even
with the load upwards of 14, without preempt, it's like looking at a
couple of screenshots. This is not something that I would recommend for
a server, but for a workstation, it works great.

Out of morbid curiousity, I ran a make -j bzImage to see how well this
would handle being driven into the ground. No oopsen, the OOM killer
worked great, killed everything that wasn't being used. The only prob is
that it hosed my console and killed my ssh daemon. oops ;) Sending a
sysrq-SAK and then a 3-finger-salute rebooted the system perfectly, no
fsck or anything.

I couldn't build that latency test for my system, so no results from it.
I haven't had a chance to look at it's source, so I'm not sure if I can
make it work here or not.

I'll keep up with your patches and keep you posted.

--
Gregory Finch

