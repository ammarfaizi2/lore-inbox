Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbTBUFL2>; Fri, 21 Feb 2003 00:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbTBUFL2>; Fri, 21 Feb 2003 00:11:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:32699 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267144AbTBUFL1>;
	Fri, 21 Feb 2003 00:11:27 -0500
Date: Thu, 20 Feb 2003 21:23:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: IO scheduler benchmarking
Message-Id: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:21:26.0457 (UTC) FILETIME=[14DC4A90:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following this email are the results of a number of tests of various I/O
schedulers:

- Anticipatory Scheduler (AS) (from 2.5.61-mm1 approx)

- CFQ (as in 2.5.61-mm1)

- 2.5.61+hacks (Basically 2.5.61 plus everything before the anticipatory
  scheduler - tweaks which fix the writes-starve-reads problem via a
  scheduling storm)

- 2.4.21-pre4

All these tests are simple things from the command line.

I stayed away from the standard benchmarks because they do not really touch
on areas where the Linux I/O scheduler has traditionally been bad.  (If they
did, perhaps it wouldn't have been so bad..)

Plus all the I/O schedulers perform similarly with the usual benchmarks. 
With the exception of some tiobench phases, where AS does very well.

Executive summary: the anticipatory scheduler is wiping the others off the
map, and 2.4 is a disaster.

I really have not sought to make the AS look good - I mainly concentrated on
things which we have traditonally been bad at.  If anyone wants to suggest
other tests, please let me know.

The known regressions from the anticipatory scheduler are:

1) 15% (ish) slowdown in David Mansfield's database run.  This appeared to
   go away in later versions of the scheduler.

2) 5% dropoff in single-threaded qsbench swapstorms

3) 30% dropoff in write bandwidth when there is a streaming read (this is
   actually good).

The test machine is a fast P4-HT with 256MB of memory.  Testing was against a
single fast IDE disk, using ext2.



