Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTBUGmj>; Fri, 21 Feb 2003 01:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTBUGmj>; Fri, 21 Feb 2003 01:42:39 -0500
Received: from [209.195.52.120] ([209.195.52.120]:19150 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S267179AbTBUGmi>; Fri, 21 Feb 2003 01:42:38 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2003 22:51:37 -0800 (PST)
Subject: Re: IO scheduler benchmarking
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one other useful test would be the time to copy a large (multi-gig) file.
currently this takes forever and uses very little fo the disk bandwidth, I
suspect that the AS would give more preference to reads and therefor would
go faster.

for a real-world example, mozilla downloads files to a temp directory and
then copies it to the premanent location. When I download a video from my
tivo it takes ~20 min to download a 1G video, during which time the system
is perfectly responsive, then after the download completes when mozilla
copies it to the real destination (on a seperate disk so it is a copy, not
just a move) the system becomes completely unresponsive to anything
requireing disk IO for several min.

David Lang

On Thu, 20 Feb 2003, Andrew Morton wrote:

> Date: Thu, 20 Feb 2003 21:23:04 -0800
> From: Andrew Morton <akpm@digeo.com>
> To: linux-kernel@vger.kernel.org
> Subject: IO scheduler benchmarking
>
>
> Following this email are the results of a number of tests of various I/O
> schedulers:
>
> - Anticipatory Scheduler (AS) (from 2.5.61-mm1 approx)
>
> - CFQ (as in 2.5.61-mm1)
>
> - 2.5.61+hacks (Basically 2.5.61 plus everything before the anticipatory
>   scheduler - tweaks which fix the writes-starve-reads problem via a
>   scheduling storm)
>
> - 2.4.21-pre4
>
> All these tests are simple things from the command line.
>
> I stayed away from the standard benchmarks because they do not really touch
> on areas where the Linux I/O scheduler has traditionally been bad.  (If they
> did, perhaps it wouldn't have been so bad..)
>
> Plus all the I/O schedulers perform similarly with the usual benchmarks.
> With the exception of some tiobench phases, where AS does very well.
>
> Executive summary: the anticipatory scheduler is wiping the others off the
> map, and 2.4 is a disaster.
>
> I really have not sought to make the AS look good - I mainly concentrated on
> things which we have traditonally been bad at.  If anyone wants to suggest
> other tests, please let me know.
>
> The known regressions from the anticipatory scheduler are:
>
> 1) 15% (ish) slowdown in David Mansfield's database run.  This appeared to
>    go away in later versions of the scheduler.
>
> 2) 5% dropoff in single-threaded qsbench swapstorms
>
> 3) 30% dropoff in write bandwidth when there is a streaming read (this is
>    actually good).
>
> The test machine is a fast P4-HT with 256MB of memory.  Testing was against a
> single fast IDE disk, using ext2.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
