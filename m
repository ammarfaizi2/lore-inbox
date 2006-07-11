Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWGKRdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWGKRdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGKRdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:33:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16665 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751142AbWGKRdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:33:24 -0400
Date: Tue, 11 Jul 2006 19:36:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] Consolidate the request merging
Message-ID: <20060711173604.GA4120@suse.de>
References: <20060711090838.GU5210@suse.de> <44B379F6.4070309@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B379F6.4070309@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11 2006, Nick Piggin wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >Right now, every IO scheduler implements its own backmerging (except for
> >noop, which does no merging). That results in duplicated code for
> >essentially the same operation, which is never a good thing. This patch
> >moves the backmerging out of the io schedulers and into the elevator
> >core. We save 1.6kb of text and as a bonus get backmerging for noop as
> >well. Win-win!
> >
> >Notes:
> >
> >- I dropped the "move hot entries to front" logic. It's never been
> >  proven good, and some research indicates that it's a bad idea. I doubt
> >  it matters in real life, so lets just cut that away.
> >
> >- Next it might be a good idea to move the rb sorting into the elevator
> >  core as well. We could save some more kernel text, but more
> >  importantly it gets us one step closer to dropping deadline_rq from
> >  the deadline scheduler.
> 
> Seems like a good idea. I don't think this could be a downside for anyone
> except maybe Ken Chen, if it adds any overhead to the noop scheduler.
> 
> BTW, IMO it is a good idea for the noop scheduler to do as much merging as
> possible, especially as it could be used for things like network block
> devices (but more merging may actually cut down on CPU and IO bandwidth
> even in the local disk case).

I agree, I actually think it's a win for noop with the cheap merging. If
anyone complains, we can always make it tweakable with a sysfs
parameter. Even for "intelligent" hardware, you have a command overhead
per request, so it makes a lot of sense to always do merging.

-- 
Jens Axboe

