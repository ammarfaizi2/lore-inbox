Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268008AbRG0RVt>; Fri, 27 Jul 2001 13:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268883AbRG0RVj>; Fri, 27 Jul 2001 13:21:39 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:16139 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268008AbRG0RVc>; Fri, 27 Jul 2001 13:21:32 -0400
Message-ID: <3B61A4A5.41E7B891@zip.com.au>
Date: Sat, 28 Jul 2001 03:28:05 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>,
        "Gryaznova E." <grev@namesys.botik.ru>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>,
					<Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int> <3B619956.6AA072F9@zip.com.au> <3B619D63.9989F9F@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hans Reiser wrote:
> 
> Andrew, can you do this such that there is no disruption of our
> disk format, and make a mount option
> out of it, and probably we should use this patch....

I'll defer to Chris :)

There's no disruption to disk format - it just simulates
the user typing `sync' at the right time.  I think the
concept is sound, and I'm sure Chris can find a more efficient
way...


> After you make a mount option out of it, grev will benchmark
> it for us using the usual suite of benchmarks.
> 

Ordered-data is a funny thing.  Under heavy loads it tends
to make a significant throughput difference - on ext3 it 
almost halves throughput wrt writeback mode.

But this by no means indicates that writes are half as slow;
what happens is that metadata-intensive workloads fill the
journal up quickly, so the `sync' happens more frequently.
Under normal workloads, or less metadata-intense workloads
the difference is very small.

During testing of that little patch I noted that the 
disk went crunch every thirty seconds or so, which is good.
Presumably the reiserfs journal is larger, or more space-efficient.

-
