Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSKKNuE>; Mon, 11 Nov 2002 08:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265062AbSKKNuE>; Mon, 11 Nov 2002 08:50:04 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:20151 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265058AbSKKNuD>; Mon, 11 Nov 2002 08:50:03 -0500
Date: Mon, 11 Nov 2002 11:56:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
In-Reply-To: <3DCF3BD1.4A95617D@digeo.com>
Message-ID: <Pine.LNX.4.44L.0211111149000.30221-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Andrew Morton wrote:

> Really, it should be in terms of "time".  If you assume 6 msec seek and
> 30 mbyte/sec bandwidth, the crossover is a 120 kbyte I/O.

Now figure in the rotational latency and the crossover point has
moved to 200 kB. ;)

> Not that I'm sure this means anything interesting ;)  But the lesson is
> that the size of a request isn't very important.

Besides, larger requests are much more efficient so penalising
those is the very last thing we want to do.

> Better would be to perform those reads and writes in nice big batches.
> That's easy for the writes, but for reads we need to wait for the
> application to submit another one.  That means actually deliberately
> leaving the disk head idle for a few milliseconds in the anticipation
> that the application will submit another nearby read.  This is called
> "anticipatory scheduling" and has been shown to provide 20%-70%
> performance boost in web serving workloads.   It just makes heaps of
> sense to me and I'd love to see it in Linux...

It only makes sense under heavy multiprocessing workloads where
we have multiple processes submitting IO, but if it's just one
process all this deliberate delay will achieve is a slowdown of
the process.

> See http://www.cs.ucsd.edu/sosp01/papers/iyer.pdf

Looking at it now.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

