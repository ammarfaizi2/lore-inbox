Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUCCKNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUCCKNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:13:43 -0500
Received: from ns.suse.de ([195.135.220.2]:41617 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262400AbUCCKNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:13:38 -0500
Date: Wed, 3 Mar 2004 11:13:37 +0100
From: Andi Kleen <ak@suse.de>
To: Peter Williams <peterw@aurema.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, johnl@aurema.com
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
Message-ID: <20040303101336.GC8008@wotan.suse.de>
References: <fa.fi4j08o.17nchps@ifi.uio.no.suse.lists.linux.kernel> <fa.ctat17m.8mqa3c@ifi.uio.no.suse.lists.linux.kernel> <yydjishqw10p.fsf@galizur.uio.no.suse.lists.linux.kernel> <40426E1C.8010806@aurema.com.suse.lists.linux.kernel> <p73k7224pdn.fsf@brahms.suse.de> <404554D8.5040800@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404554D8.5040800@aurema.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 02:45:28PM +1100, Peter Williams wrote:
> Andi Kleen wrote:
> >Peter Williams <peterw@aurema.com> writes:
> >
> >One comment on the patches: could you remove the zillions of numerical 
> >Kconfig
> >options and just make them sysctls? I don't think it makes any sense 
> >to require a reboot to change any of that. And the user is unlikely
> >to have much idea yet on what he wants on them while configuring.
> 
> The default initial values should be fine and the default configuration 
> allows the scheduling tuning parameters (i.e. half life and time slice 
>       ) to be changed on a running system via the /proc file system. 
> These are mainly there so that different settings can be used with 
> various benchmarks to determine what are the best settings for various 
> types of loads.  If good default values that work well for a wide 
> variety of load types can be found as a result of these experiments then 
> these parameters may be made constants in the code.  If not they 
> probably should be made settable via system calls rather than via /proc 
> as you suggest.

No doubt that there are different settings that make sense 
for different workloads. But there is no reason one has to recompile
to set them - it's much nicer to just run a script at boot time to set
them, instead of recompiling/rebooting. This will also make benchmarking
much easier, because you can just write a script that sets the
various parameters, runs workloads, sets other parameters, runs
workload again etc. Requiring a recompile and reboot makes this
much harder.

Also I suspect most people who are not heavily into scheduling
theory will go with the defaults at compile time, so it's important
that they already work well.

And consider it from the side of a standard distribution: users 
don't normally recompile their kernels there, so everything that
makes sense to be tunable should be settable without recompiling.

IMHO CONFIG_* should not be used for anything except for kernel binary
size tuning and possible compiler tuning.

-Andi

