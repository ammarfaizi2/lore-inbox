Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbSKJT03>; Sun, 10 Nov 2002 14:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265112AbSKJT02>; Sun, 10 Nov 2002 14:26:28 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:24026 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265111AbSKJT0Z>; Sun, 10 Nov 2002 14:26:25 -0500
Date: Sun, 10 Nov 2002 17:32:44 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
In-Reply-To: <20021110024451.GE2544@x30.random>
Message-ID: <Pine.LNX.4.44L.0211101727230.8133-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Andrea Arcangeli wrote:
> On Sat, Nov 09, 2002 at 01:00:19PM +1100, Con Kolivas wrote:

> > 2.4.19-ck9 [2]          78.3    88      31      8       1.10
> > 2.4.20-rc1 [3]          105.9   69      32      2       1.48
> > 2.4.20-rc1aa1 [1]       106.3   69      33      3       1.49
>
> again ck9 is faster because of elevator hacks ala read-latency.
>
> in short your whole benchmark seems all about interacitivy of reads
> during write flood.

Which is a very important thing.  You have to keep in mind that
reads and writes are fundamentally different operations since
the majority of the writes happen asynchronously while the program
continues running, while the majority of reads are synchronous and
your program will block while the read is going on.

Because of this it is also much easier to do writes in large chunks
than it is to do reads in large chunks, because with writes you
know exactly what data you're going to write while you can't know
which data you'll need to read next.

> All the difference is there and it will hurt you badly if you do
> async-io benchmarks,

Why would read-latency hurt the async-io benchmark ?

Whether the IO is synchronous or asynchronous shouldn't matter much,
if you do a read you still need to wait for the data to be read in
before you can process it while the data you write is still in memory
and can be used over and over again.

What is the big difference with asynchronous IO that removes the big
asymetry between reads and writes ?

> kernel. Either that or change the name of your project, if somebody wins
> this context that's probably a bad I/O scheduler in many other aspects,
> some of the reason I didn't merge read-latency from Andrew.

Any reasons in particular or just a gut feeling ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

