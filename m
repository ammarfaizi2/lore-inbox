Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263110AbSJFCKW>; Sat, 5 Oct 2002 22:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263120AbSJFCKW>; Sat, 5 Oct 2002 22:10:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:51844 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263110AbSJFCKV>;
	Sat, 5 Oct 2002 22:10:21 -0400
Message-ID: <3D9F9CD5.CEB61219@digeo.com>
Date: Sat, 05 Oct 2002 19:15:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - 
 (NUMA))
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 02:15:51.0202 (UTC) FILETIME=[4AB9B820:01C26CDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> And the work that matters for the desktop is LATENCY work.

100% true.

You should resist any confusion between IO latency and CPU
scheduling latency.  They really are worlds apart.

In a stock 2.4 kernel it is hugely rare for the kernel to stall
a ready-to-run task for longer than a monitor refresh interval,
so I continue to disbelieve any claims that the low-latency
and preemptivity patches make any difference in desktop use.

(And 2.5 improves on this a _lot_.  The now-departed buffer LRU
and truncate list walks were the main culprits)

Any attempt to link IO priority with nice is probably doomed
to confused failure.  It should be a clearly separated concept.
There are priority inversions everywhere, too.

I disagree with you on the new CPU scheduler.  In my experience
it is significantly worse than the old one - a `make -j3' is
still sending interactive applications on extended lunch breaks.
Not that I have tried to tune this away.

Deadline scheduler is critical.  As is a correct setting for
/proc/sys/vm/dirty_async_ratio and the soon-to-be-born
/proc/sys/vm/swappiness.  These will boot up with sane values,
as much as is humanly possible.

It's not all kernel though.  Application (KDE) startup is *slow*,
even when zero I/O is performed.  Presumably because of the vtable
dynamic linking thing.  I'm not sure how the prelinking work is
getting along, but the initial figures I saw on that indicated
that the benefit may not be sufficient.
