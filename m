Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTBOQ0P>; Sat, 15 Feb 2003 11:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTBOQ0P>; Sat, 15 Feb 2003 11:26:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20954 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262807AbTBOQ0O>;
	Sat, 15 Feb 2003 11:26:14 -0500
Date: Sat, 15 Feb 2003 17:35:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CFQ scheduler, #2
Message-ID: <20030215163550.GO26738@suse.de>
References: <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net> <Pine.LNX.4.50L.0302150920510.16301-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302150920510.16301-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15 2003, Rik van Riel wrote:
> On Sat, 15 Feb 2003, Mike Galbraith wrote:
> 
> >I gave this a burn, and under hefty load it seems to provide a bit of
> >anti-thrash benefit.
> 
> Judging from your log, it ends up stalling kswapd and
> dramatically increases the number of times that normal
> processes need to go into the pageout code.

With 30 odds processes, it doesn't take a whole lot for one process to
have its share of requests eaten.

> If this provides an anti-thrashing benefit, something's
> wrong with the VM in 2.5 ;)

It's not a vm problem. But it is a problem if kswapd + pdflush can
consume the entire request pool, stalling real user processes.

Mike, please retry the test with more requests available. CFQ does not
rely on request queue length for fairness. Just changes:

	 (queue_nr_requests > 128)
		queue_nr_requests = 128;

to

	 (queue_nr_requests > 512)
		queue_nr_requests = 512;

in ll_rw_blk.c:blk_dev_init() and see how that runs.

-- 
Jens Axboe

