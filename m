Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSILUS2>; Thu, 12 Sep 2002 16:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSILUS2>; Thu, 12 Sep 2002 16:18:28 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:12108 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S317191AbSILUS1>;
	Thu, 12 Sep 2002 16:18:27 -0400
Date: Thu, 12 Sep 2002 22:23:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <20020912202314.GA12775@win.tue.nl>
References: <Pine.LNX.4.33.0209111428280.20725-100000@ccvsbarc.wipro.com> <20020911171934.GA12449@win.tue.nl> <3D7FF3E7.61772A26@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D7FF3E7.61772A26@digeo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 06:54:47PM -0700, Andrew Morton wrote:
> Andries Brouwer wrote:
> > 
> > ...
> > Again. We have 2^30 = 10^9 pids. In reality there are fewer than 10^4
> > processes. So once in 10^5 pid allocations do we make a scan over
> > these 10^4 processes,
> 
> Inside tasklist_lock?  That's pretty bad from a latency point of
> view.  A significant number of users would take the slower common
> case to avoid this.

That would be unwise of all these users.
As soon as people have so many processes that this becomes a problem,
then instead of making things slower they should make things faster
still, at the cost of a little bit of extra code.

Similarly, people that need real-time guarantees will probably add
that extra code.

Now that things are ten thousand times better than they were very
recently I find it a bit surprising that people worry. But yes, when
needed it is very easy to come with further improvements.
Once people stand up and say that they need Linux machines with 10^6
processes, or with 10^4 processes and real time guarantees, then we
must have a discussion about data structures, and a discussion about
standards.

The standards part is this: what values are allowed for p->pgrp,
p->tgid, p->session? Can these be arbitrary numbers? Or can the
positive values among them be restricted to pid's?
If this restriction can be imposed we can be slightly more efficient.

But these future discussions must not be about get_pid() but about
task list handling, scheduling, sending signals, all places that
today have for_each_task(p) ...

Andries
