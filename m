Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbTAQScw>; Fri, 17 Jan 2003 13:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbTAQScw>; Fri, 17 Jan 2003 13:32:52 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:16154
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267630AbTAQScw>; Fri, 17 Jan 2003 13:32:52 -0500
Date: Fri, 17 Jan 2003 13:42:19 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] (2/3) Initial load balancing
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E242@fmsmsx405.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0301171336030.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Pallipadi, Venkatesh wrote:

> > +{
> > +	unsigned long old_mask;
> > +
> > +	old_mask = p->cpus_allowed;
> > +	if (!(old_mask & (1UL << dest_cpu)))
> > +		return;
> > +	/* force the process onto the specified CPU */
> > +	set_cpus_allowed(p, 1UL << dest_cpu);
> > +
> > +	/* restore the cpus allowed mask */
> > +	set_cpus_allowed(p, old_mask);
> > +}
> 
> It may be better to add a _note_ to this function saying that it is not
> supposed to be called by multiple callers at the same time. As of now, 
> as it is called at exec time only, I think it is safe. But, if it get used at other
> places, (or called once+preempt) we may have situations where we may loose the cpus_allowed mask
> or miss some sched_migrate_task(). I am looking at, what if some sched_migrate_task() 
> or user set_affinity gets initiated in between two set_cpus_allowed in
> this routine. 

Shouldn't there be a get_task_struct there?

	Zwane
-- 
function.linuxpower.ca

