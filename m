Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbTAQSkL>; Fri, 17 Jan 2003 13:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTAQSkL>; Fri, 17 Jan 2003 13:40:11 -0500
Received: from fmr01.intel.com ([192.55.52.18]:12491 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267635AbTAQSkJ> convert rfc822-to-8bit;
	Fri, 17 Jan 2003 13:40:09 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH] (2/3) Initial load balancing
Date: Fri, 17 Jan 2003 10:49:06 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E244@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] (2/3) Initial load balancing
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK+WBZUfdYCyipKEdeNCQBQi+Bs2AAAG/SA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Zwane Mwaikambo" <zwane@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jan 2003 18:49:07.0193 (UTC) FILETIME=[1D408690:01C2BE59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@holomorphy.com] 
> Sent: Friday, January 17, 2003 10:42 AM
> To: Pallipadi, Venkatesh
> Cc: Martin J. Bligh; Linus Torvalds; linux-kernel
> Subject: RE: [PATCH] (2/3) Initial load balancing
> 
> 
> On Fri, 17 Jan 2003, Pallipadi, Venkatesh wrote:
> 
> > > +{
> > > +	unsigned long old_mask;
> > > +
> > > +	old_mask = p->cpus_allowed;
> > > +	if (!(old_mask & (1UL << dest_cpu)))
> > > +		return;
> > > +	/* force the process onto the specified CPU */
> > > +	set_cpus_allowed(p, 1UL << dest_cpu);
> > > +
> > > +	/* restore the cpus allowed mask */
> > > +	set_cpus_allowed(p, old_mask);
> > > +}
> > 
> > It may be better to add a _note_ to this function saying 
> that it is not
> > supposed to be called by multiple callers at the same time. 
> As of now, 
> > as it is called at exec time only, I think it is safe. But, 
> if it get used at other
> > places, (or called once+preempt) we may have situations 
> where we may loose the cpus_allowed mask
> > or miss some sched_migrate_task(). I am looking at, what if 
> some sched_migrate_task() 
> > or user set_affinity gets initiated in between two 
> set_cpus_allowed in
> > this routine. 
> 
> Shouldn't there be a get_task_struct there?
> 
> 	Zwane

Yes. A get_task_struct() and put_task_struct() there will make the whole

stuff in there lock-protected and should get rid of the issues I was
mentioning.

Thanks,
-Venkatesh
