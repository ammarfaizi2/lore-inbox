Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUCNVJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCNVJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 16:09:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16859 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261619AbUCNVJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 16:09:15 -0500
Date: Sun, 14 Mar 2004 22:09:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mason@suse.com, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040314210907.GA31082@suse.de>
References: <1079121113.4181.189.camel@watt.suse.com> <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de> <1079123647.4186.211.camel@watt.suse.com> <20040312203452.GD16880@suse.de> <1079124097.4187.216.camel@watt.suse.com> <20040312205104.GE16880@suse.de> <1079297032.4185.277.camel@watt.suse.com> <20040314204701.GA2649@suse.de> <20040314130437.512f00f2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314130437.512f00f2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > I reproduced on 2.6.4-mm1 + backing dev, but 2.6.4-mm1 alone ran fine. 
> > > To make a long story short, the swap address space and backing dev don't
> > > define an unplug_io_fn.  I was able to reproduce quickly with a swap
> > > heavy workload.  The patch below should fix the oops, but probably isn't
> > > correct solution since no queues will get unplugged while waiting on
> > > swap pages.
> > 
> > Duh of course, that's pretty silly actually. So the question is if we
> > want to keep assigning a dummy unplug_io_fn (default_backing_dev already
> > has it), or just keep the check. I propose to check like Chris added,
> > and just kill the default_unplug_io_fn() from readahead.c
> > 
> 
> I'd be inclined to leave that as-is actually.  I'll run with Chris's patch
> temporarily, but we need a real unplug function for swapper_space.  Which
> will leave default_backing_dev_info unique.

We were just discussing this on irc, btw. :-)

> I'll do swap_unplug_io_fn().  swap implements a poor-man's raid0.  What are
> the locking rules for the unplug function btw?  It can sleep, yes?

There are no locking rules for bdi->unplug_io_fn(). You can sleep if the
caller can sleep.

-- 
Jens Axboe

