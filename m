Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287626AbSANQzC>; Mon, 14 Jan 2002 11:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSANQyn>; Mon, 14 Jan 2002 11:54:43 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:14307 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287626AbSANQyc>; Mon, 14 Jan 2002 11:54:32 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 17:53:15 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114165441Z287626-13996+5488@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 11:39, Andrea Arcangeli wrote:
> On Sun, Jan 13, 2002 at 01:22:57PM -0500, Robert Love wrote:
> > Again, preempt seems to reign supreme.  Where is all the information
>
> those comparison are totally flawed. There's nothing to compare in
> there. 
>
> minill misses the O(1) scheduler, and -aa has faster vm etc... there's
> absolutely nothing to compare in the above numbers, all variables
> changes at the same time.
>
> I'm amazed I've to say this, but in short:
>
> 1) to compare minill with preempt, apply both patches to 18-pre3, as the
>    only patch applied (no O(1) in the way of preempt!!!!)
> 2) to compare -aa with preempt, apply -preempt on top of -aa and see
>    what difference it makes

Oh Andrea,

I know your -aa VM is _GREAT_. I've used it all the time when I have the muse 
to apply your vm-XX patch "by hand" to the "current" tree.
If you only get to the point and _send_ the requested patch set to Marcelo...

All (most) of my preempt Test were running with your -aa VM and I saw the 
speed up with your VM _AND_ preempt especially for latency (interactivity, 
system start time and latencytest0.42-png). O(1) gave additional "smoothness"

What should I run for you?

Below are the dbench 32 (yes, I know...) numbers for 2.4.18-pre3-VM-22 and 
2.4.18-pre3-VM-22-preempt+lock-break.
Sorry, both with O(1)...

2.4.18-pre3
sched-O1-2.4.17-H7.patch
10_vm-22
00_nanosleep-5
bootmem-2.4.17-pre6
read-latency.patch
waitq-2.4.17-mainline-1
plus
all 2.4.18-pre3.pending ReiserFS stuff

dbench/dbench> time ./dbench 32
32 clients started
..............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+..........................................................................................................................................................................................................................................................++....................................................................................................++...................................+................................+...+...+........................................+..+......+................+...........++....................++++...++..++.....+...+....+........+...+++++********************************
Throughput 41.5565 MB/sec (NB=51.9456 MB/sec  415.565 MBit/sec)
14.860u 48.320s 1:41.66 62.1%   0+0k 0+0io 938pf+0w


preempt-kernel-rml-2.4.18-pre3-ingo-2.patch
lock-break-rml-2.4.18-pre1-1.patch
2.4.18-pre3
sched-O1-2.4.17-H7.patch
10_vm-22
00_nanosleep-5
bootmem-2.4.17-pre6
read-latency.patch
waitq-2.4.17-mainline-1
plus
all 2.4.18-pre3.pending ReiserFS stuff

dbench/dbench> time ./dbench 32
32 clients started
..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+...................................+.....................................................................+...............................................................................................................................+.....+........................................+........................+............................................................................+...........................................................+..............+...................+........+.......+...............+...............+.....+..................+..+......+...++.........+....+..+...+....+......+.....................................+.+..+.......++********************************
Throughput 47.0049 MB/sec (NB=58.7561 MB/sec  470.049 MBit/sec)
14.280u 49.370s 1:30.88 70.0%   0+0k 0+0io 939pf+0w

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
