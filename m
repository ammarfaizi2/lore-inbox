Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTBUIEp>; Fri, 21 Feb 2003 03:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTBUIEp>; Fri, 21 Feb 2003 03:04:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:47299 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267235AbTBUIEo>;
	Fri, 21 Feb 2003 03:04:44 -0500
Date: Fri, 21 Feb 2003 00:16:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-Id: <20030221001624.278ef232.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
	<Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 08:14:44.0637 (UTC) FILETIME=[4AA8A4D0:01C2D981]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> wrote:
>
> one other useful test would be the time to copy a large (multi-gig) file.
> currently this takes forever and uses very little fo the disk bandwidth, I
> suspect that the AS would give more preference to reads and therefor would
> go faster.

Yes, that's a test.

	time (cp 1-gig-file foo ; sync)

2.5.62-mm2,AS:		1:22.36
2.5.62-mm2,CFQ:		1:25.54
2.5.62-mm2,deadline:	1:11.03
2.4.21-pre4:		1:07.69

Well gee.


> for a real-world example, mozilla downloads files to a temp directory and
> then copies it to the premanent location. When I download a video from my
> tivo it takes ~20 min to download a 1G video, during which time the system
> is perfectly responsive, then after the download completes when mozilla
> copies it to the real destination (on a seperate disk so it is a copy, not
> just a move) the system becomes completely unresponsive to anything
> requireing disk IO for several min.

Well 2.4 is unreponsive period.  That's due to problems in the VM - processes
which are trying to allocate memory get continually DoS'ed by `cp' in page
reclaim.

For the reads-starved-by-writes problem which you describe, you'll see that
quite a few of the tests did cover that.  contest does as well.

