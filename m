Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAIAVQ>; Mon, 8 Jan 2001 19:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131829AbRAIAVG>; Mon, 8 Jan 2001 19:21:06 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:36872 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129387AbRAIAUy>; Mon, 8 Jan 2001 19:20:54 -0500
Date: Tue, 9 Jan 2001 00:20:52 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2 vs. 2.4 benchmarks
Message-ID: <Pine.LNX.4.30.0101090000110.9761-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I ran some 2.2 vs. 2.4 benchmarks, particularly in the area of file i/o,
using bonnie++.

The machine is a SMP 128Mb PII-350 with a udma2 drive capable of some
20Mb/sec+. Kernels involved are 2.4.0, and the default RH7.0 kernel
(2.2.16 plus more patches than you can shake a stick at).

Not going too much into the gory details, here are the differences exposed
between 2,2 and 2.4:

1) Amazing 2.4 increase in streaming write performance; 13Mb/sec ->
20Mb/sec. I suspect this is the result of the "last minute" 2.4.0 dirty
buffer/sync waiting handling changes.

2) Slight 2.4 increase in streaming read performance; 16Mb/sec ->
17Mb/sec. This leaves 2.4.0 writing faster than reading, I find that
surprising.

3) Some 10% drop in rewrite performance from 2.2 -> 2.4 (possibly because
page aging, like LRU, isn't too hot for the 2nd+ linear scan over data)

4) File creation 30% faster in 2.4; random deletes 30% faster; sequential
deletes 10% slower.


I did one other quick test, with disappointing results for 2.4.0. I did a
kernel build with 32Mb.

2.4.0 was taking about 10 mins to do the build. 2.2.x was 1min30 quicker
:( I was hoping/expecting the 2.4.0 page aging to do better, due to
keeping the more useful pages in RAM better. I have no explanation.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
