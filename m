Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268165AbTBYMnj>; Tue, 25 Feb 2003 07:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268164AbTBYMnj>; Tue, 25 Feb 2003 07:43:39 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:55474 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S268165AbTBYMnh>; Tue, 25 Feb 2003 07:43:37 -0500
Date: Tue, 25 Feb 2003 07:59:42 -0500
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-ID: <20030225125942.GA1657@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why does 2.5.62-mm2 have higher sequential
>> write latency than 2.5.61-mm1?

> And there are various odd interactions in, at least, ext3.  You did not
> specify which filesystem was used.

ext2

>>                     Thr  MB/sec   CPU%     avg lat      max latency
>> 2.5.62-mm2-as         8   14.76   52.04%     6.14        4.5
>> 2.5.62-mm2-dline      8    9.91   13.90%     9.41         .8
>> 2.5.62-mm2            8    9.83   15.62%     7.38      408.9

> Fishiness.  2.5.62-mm2 _is_ 2.5.62-mm2-as.  Why the 100x difference?

Bad EXTRAVERSION naming on my part.  2.5.62-mm2 _was_ booted with 
elevator=cfq.

How it happened:
2.5.61-mm1 tested
2.5.61-mm1-cfq tested and elevator=cfq added to boot flags
2.5.62-mm1 tested (elevator=cfq still in lilo boot boot flags)
Then to test the other two schedulers I changed extraversion and boot
flags.

> That 408 seconds looks suspect.

AFAICT, that's the one request in over 500,000 that took the longest.
The numbers are fairly consistent.  How relevant they are is debatable.  

> If you want to test write latency, do this:

Your approach is more realistic than tiobench.  

> There is a place in VFS where one writing task could accidentally hammer a
> different one.  I cannot trigger that, but I'll fix it up in next -mm.

2.5.62-mm3 or 2.5.63-mm1?  (-mm3 is running now)

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

