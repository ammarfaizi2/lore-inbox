Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVCBDMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVCBDMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 22:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVCBDMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 22:12:30 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:16785 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262148AbVCBDM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 22:12:26 -0500
Date: Tue, 1 Mar 2005 20:13:26 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nathan Lynch <ntl@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] explicitly bind idle tasks
In-Reply-To: <20050302014701.GA5897@otto>
Message-ID: <Pine.LNX.4.61.0503012012140.3122@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com>
 <20050227031655.67233bb5.akpm@osdl.org> <1109542971.14993.217.camel@gaston>
 <20050227144928.6c71adaf.akpm@osdl.org> <20050302014701.GA5897@otto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005, Nathan Lynch wrote:

> On Sun, Feb 27, 2005 at 02:49:28PM -0800, Andrew Morton wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > >
> > > > -		if (cpu_is_offline(smp_processor_id()) &&
> > >  > +		if (cpu_is_offline(_smp_processor_id()) &&
> > >  >  		    system_state == SYSTEM_RUNNING)
> > >  >  			cpu_die();
> > >  >  	}
> > >  > _
> > > 
> > >  This is the idle loop. Is that ever supposed to be preempted ?
> > 
> > Nope, it's a false positive.  We had to do the same in x86's idle loop and
> > probably others will hit it.
> 
> Perhaps I'm missing something, but is there any reason we can't do
> the following?  I've tested it on ppc64, doesn't seem to break anything.
> 
> With hotplug cpu and preempt, we tend to see smp_processor_id warnings
> from idle loop code because it's always checking whether its cpu has
> gone offline.  Replacing every use of smp_processor_id with
> _smp_processor_id in all idle loop code is one solution; another way
> is explicitly binding idle threads to their cpus (the smp_processor_id
> warning does not fire if the caller is bound only to the calling cpu).
> This has the (admittedly slight) advantage of letting us know if an
> idle thread ever runs on the wrong cpu.

Makes sense to me, for some reason i thought the smp_processor_id() 
function did a cpu_rq->idle check of some sort.

Thanks,
	Zwane

