Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTBDNnj>; Tue, 4 Feb 2003 08:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTBDNnj>; Tue, 4 Feb 2003 08:43:39 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:24231 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267254AbTBDNni>; Tue, 4 Feb 2003 08:43:38 -0500
Date: Tue, 4 Feb 2003 14:29:42 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Padraig@Linux.ie, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030204132942.GB15817@wohnheim.fh-wedel.de>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com> <3E3F9C82.7000607@Linux.ie> <3E3FBC1C.167E779A@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E3FBC1C.167E779A@aitel.hist.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 February 2003 14:11:56 +0100, Helge Hafting wrote:
> 
> Looks like a cacheline alignment issue to me.
> This loop of yours occupy x cachelines on your cpu,
> moving it in memory by adding the printf
> might cause it to ocupy x+1 cachelines.
> That might be noticeable if x is a really small number,
> such as 1.

Makes a lot of sense.

> My advice is to put your test loop in a function of its own,
> and do the printing in the function that calls it.
> functions are always aligned the same (good) way so
> that calling them will be fast.
> 
> You can tune the speed of your inner loop by experimenting
> with the insertion of one or more NOP asms in front
> of the loop.  Just be aware that all such tuning is wasted once
> you change anything at all in that function - you'll have to
> re-do the tuning each time. 
> 
> The compiler should ideally align the loops for maximum performance.
> That can be hard though, considering all the different processors
> that might run your program.  And aligning everything optimally
> could waste a _lot_ of code space - so do this only for
> small loops with lots of iterations.

The compiler has a hard time to identify those loops that affect
performance as opposed to those that are run 2-3 times.

But the developer can usually profile and figure out, where those
loops are. I wonder if the following would be possible.

printf();
__cacheline_aligned_code;
for(;;)
	do_sorting_loop_test();

include/linux/cache.h appears to define such for data structures, but
not for code.

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
