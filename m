Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264391AbUFPSRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUFPSRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUFPSRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:17:40 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:23508 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264391AbUFPSRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:17:32 -0400
Date: Wed, 16 Jun 2004 13:16:31 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040616181631.GE6069@sgi.com>
References: <27JKg-4ht-11@gated-at.bofh.it> <m3r7sfmq0r.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r7sfmq0r.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 06:22:28PM +0200, Andi Kleen wrote:
> Dimitri Sivanich <sivanich@sgi.com> writes:
> 
> > I would like to know what others think about running cache_reap() as a low
> > priority realtime kthread, at least on certain cpus that would be configured
> > that way (probably configured at boottime initially).  I've been doing some
> > testing running it this way on CPU's whose activity is mostly restricted to
> > realtime work (requiring rapid response times).
> >
> > Here's my first cut at an initial patch for this (there will be other changes
> > later to set the configuration and to optimize locking in cache_reap()).
> 
> I would run it in the standard work queue threads. We already have 
> too many kernel threads, no need to add more.
> 
> Also is there really a need for it to be real time? 

Not especially.  Normal time sharing would be OK with me, but I'd like to
emphasize that if it is real time, it would need to be lowest priority.

> Note that we don't make any attempt at all in the linux kernel to handle
> lock priority inversion, so this isn't an argument.
> 
> -Andi
