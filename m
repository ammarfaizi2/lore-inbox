Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSKJU62>; Sun, 10 Nov 2002 15:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265175AbSKJU62>; Sun, 10 Nov 2002 15:58:28 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:63201 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265174AbSKJU61>; Sun, 10 Nov 2002 15:58:27 -0500
Date: Sun, 10 Nov 2002 19:05:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
In-Reply-To: <3DCEC6F7.E5EC1147@digeo.com>
Message-ID: <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> >
> > > Whether the IO is synchronous or asynchronous shouldn't matter much,
> >
> > the fact the I/O is sync or async makes the whole difference. with sync
> > reads the vmstat line in the read column will be always very small
> > compared to the write column under a write flood. This can be fixed either:
> >
> > 1) with hacks in the elevator ala read-latency that are not generic and
> >    could decrease performance of other workloads

It'd be nice if you specified which kind of workloads. Generic
handwaving is easy, but if you think about this problem a bit
more you'll see that most workloads which look like they might
suffer at first view should be just fine in reality...

> read-latency will only do the front-insertion if it was unable to find a
> merge or insert on the tail-to-head search.
>
> And the problem it desparately addresses is severe.

Note that async-IO shouldn't make a big difference here, except
maybe in synthetic benchmarks.

This is because the stream of data in a server will be approximately
the same regardless of whether the application is coded to use async
IO, threads or processes and because clients still need to wait for
the data on read while most writes are asynchronous.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

