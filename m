Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265034AbSKKNiq>; Mon, 11 Nov 2002 08:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbSKKNiq>; Mon, 11 Nov 2002 08:38:46 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:57269 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265034AbSKKNip>; Mon, 11 Nov 2002 08:38:45 -0500
Date: Mon, 11 Nov 2002 11:45:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@digeo.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
In-Reply-To: <20021111015445.GB5343@x30.random>
Message-ID: <Pine.LNX.4.44L.0211111139450.30221-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, Andrea Arcangeli wrote:

> [snip bad example by somebody who hasn't read Andrew's patch]

> Anybody claiming there isn't the potential of a global I/O throughput
> slowdown would be clueless.

IO throughput isn't the point.  Due to the fundamental asymmetry
between reads and writes IO throughput does NOT correspond to
program throughput under many kinds of IO patterns.

Sure, the best IO throughput is good for writeout, but it'll slow
down any program doing reads, including async IO programs because
those too need to get their data before they can process it.

> all you can argue is that the decrease of latency for lots of common
> interactive workloads could worth the potential of a global throghput
> slowdown. On that I may agree.

On the contrary, the decrease of latency will probably bring a
global throughput increase.  Just program throughput, not raw
IO throughput.

> However I think even read-latency is more a workarond to a problem in
> the I/O queue dimensions. I think the I/O queue should be dunamically
> limited to amount of data queued (in bytes not in number of requests).

The number of bytes makes surprisingly little sense when you keep
into account that one disk seek on a modern costs as much time as
it takes to read about half a megabyte worth of data.

> But when each request is large 512k it is pointless to allow the same
> number of requests that we allow when the requests are 4k.

A request of 512 kB will take about twice the time to service as a 4 kB
request would take, assuming the disk does around 50 MB/s throughput.
If you take one of those really modern disks Andre Hedrick has in his
lab the difference gets even smaller.

> Infact I today think the max_bomb_segment I researched some year back
> was so beneficial in terms of read-latency just because it effectively

That must be why it was backed out ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

