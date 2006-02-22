Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWBVIcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWBVIcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWBVIcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:32:06 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:11162 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932514AbWBVIcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:32:04 -0500
Date: Wed, 22 Feb 2006 14:01:55 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to allocate per-cpu data for online CPUs only (and safely)?
Message-ID: <20060222083155.GB5111@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <43FB942E.5070309@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB942E.5070309@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 11:29:02PM +0100, Martin Peschke wrote:
> I am trying to optimize the memory footprint of some code of mine.
> the disadvantage of getting hold of memory for CPU's which aren't there
> (yet).
> 
> I could imagine using CPU-hotplug notifications as triggers for
> additional allocations or for cleaning up unneeded memory. But
> alloc_percpu() appears to conflict with that idea.
> 
> I was briefly tempted to derive some code from alloc_percpu() more to my
> liking, until I was scared off by this comment in alloc_percpu():
> 
>         /*
>          * Cannot use for_each_online_cpu since a cpu may come online
>          * and we have no way of figuring out how to fix the array
>          * that we have allocated then....
>          */
> 
> Well, and then there is kernel/profile.c, for example, which boldly
> ignors alloc_percpu()'s qualms and allocates and releases per-cpu data
> as needed.
> 
> Is that the way to go?
> If so, why alloc_percpu()'s reservations?

The above comment in alloc_percpu regarding use of for_each_online_cpu
probably refers to the fact that once we handover 'pdata' to the caller
of alloc_percpu, there is no way to go back and fix it (i.e allocate
objects) for CPUs that come online later. This could have been possible if 
alloc_percpu kept track of all per-CPU allocations (chain togther all pdata's 
in a linked list?), but I guess they didn't do it to keep it simple.

I would say the code in kernel/profile.c is fine enough to emulate.

> Or, does that comment imply that the exploiter isn't expected to take
> care of CPU hotplug events?
> Am I missing anything?
> 
> Thank you.
> 
> Martin

-- 
Regards,
vatsa
