Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUFPSJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUFPSJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUFPSGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:06:39 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:19359 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264375AbUFPSDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:03:17 -0400
Date: Wed, 16 Jun 2004 13:02:08 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-mm@kvack.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040616180208.GD6069@sgi.com>
References: <40D08225.6060900@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D08225.6060900@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 07:23:49PM +0200, Manfred Spraul wrote:
> Dimitri wrote:
> 
> >In the process of testing per/cpu interrupt response times and CPU 
> >availability,
> >I've found that running cache_reap() as a timer as is done currently 
> >results
> >in some fairly long CPU holdoffs.
> >
> What is fairly long?
Into the 100's of usec.  I consider anything over 30 usec too long.
I've seen this take longer than 30usec on a small (8p) system.

> If cache_reap() is slow than the caches are too large.
> Could you limit cachep->free_limit and check if that helps? It's right 
> now scaled by num_online_cpus() - that's probably too much. It's 
> unlikely that all 500 cpus will try to refill their cpu arrays at the 
> same time. Something like a logarithmic increase should be sufficient.

I haven't tried this yet, but I'm even seeing this on 4 cpu systems.

> Do you use the default batchcount values or have you increased the values?

Default.

> I think the sgi ia64 system do not work with slab debugging, but please 
> check that debugging is off. Debug enabled is slow.

# CONFIG_DEBUG_SLAB is not set

> 
> --
>    Manfred

Dimitri Sivanich <sivanich@sgi.com>
