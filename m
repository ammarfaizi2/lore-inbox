Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSHAS0m>; Thu, 1 Aug 2002 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSHAS0m>; Thu, 1 Aug 2002 14:26:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29966 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316608AbSHAS0l>; Thu, 1 Aug 2002 14:26:41 -0400
Date: Thu, 1 Aug 2002 14:24:18 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
In-Reply-To: <20020801085152.GC1096@suse.de>
Message-ID: <Pine.LNX.3.96.1020801141845.15133B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002, Jens Axboe wrote:

> On Tue, Jul 30 2002, Bill Davidsen wrote:

> > Now a request, if someone is running a database app and tests this I'd
> > love to see the results. I expect things like LMbench to show more threads
> > ending at the same time, but will it help a reall app?
> 
> Note that the deadline i/o scheduler only considers deadlines on
> individual requests so far, so there's no real guarentee that process X,
> Y, and Z will receive equal share of the bandwidth. This is something
> I'm thinking about, though.

I'm not sure that equal bandwidth and deadline are compatible, some
processes may need more bandwidth to meet deadlines. I'm not unhappy about
that, it's the reads waiting in a flood of write or vice-versa that
occasionally make an app really rot.
 
> My testing does seem to indicate that the deadline scheduler is fairer
> than the linus scheduler, but ymmv.
> 
> > I bet it was tested briefly on IDE, my last use of IDE a week or so ago
> > lasted until I did "make dep" and the output went all over every attached
> > drive :-( Still, nice to know it will work if IDE makes it into 2.5.
> 
> :/
> 
> I'll say that 2.5.29 IDE did work fine for the testing I did with the
> deadline scheduler, at least it survived a dbench 64 (that's about the
> testing it got).

Hum, looks as if I should plan to retest with 29 and the deadline patches.
My personal test is a program doing one read/sec while making CD images
(mkisofs) on a machine with large memory. It tends to build the whole
700MB in memory and then bdflush decides it should be written and the read
latency totally goes to hell. I will say most of this can be tuned out at
some small cost to total performance (thanks Andrea).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

