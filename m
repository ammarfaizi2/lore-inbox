Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752348AbWCFJZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbWCFJZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbWCFJZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:25:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751958AbWCFJZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:25:49 -0500
Date: Mon, 6 Mar 2006 10:25:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] bsg, block layer sg
Message-ID: <20060306092528.GA4329@suse.de>
References: <20060302111945.GG4329@suse.de> <20060304180814.11f459b9.akpm@osdl.org> <20060306085735.GY4329@suse.de> <20060306011355.4df811f6.akpm@osdl.org> <20060306091959.GZ4329@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306091959.GZ4329@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06 2006, Jens Axboe wrote:
> On Mon, Mar 06 2006, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > ...
> > > > 
> > > > If you expand the two above statements you get:
> > > > 
> > > > 	spin_lock_irqsave(q->queue_lock, flags);
> > > > 	__elv_add_request(q, rq, where, plug);
> > > > 	spin_unlock_irqrestore(q->queue_lock, flags);
> > > > 	spin_lock_irq(q->queue_lock);
> > > > 	__generic_unplug_device(q);
> > > > 	spin_unlock_irq(q->queue_lock);
> > > > 
> > > > which is a bit sad.
> > > 
> > > Indeed, I'll do the locking manually and use the __ functions.
> > 
> > blk_execute_rq_nowait() and pkt_generic_packet() also do the above two
> > calls.   It might be worth creating a new library function.
> 
> Yes it might, there are other call sites like this in the kernel. But
> it's basically blk_execute_rq_nowait(). I'll make that change.

First step:

http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=commitdiff;h=6a09cbe527fe051c919c5d9526ba4a2d2689fb61

Second step:

http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=commitdiff;h=0f62c8deddf27b15f56edcf6414c3905e93fd0ef

-- 
Jens Axboe

