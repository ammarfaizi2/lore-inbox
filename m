Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWFNAxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWFNAxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWFNAxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:53:45 -0400
Received: from relay01.pair.com ([209.68.5.15]:54799 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932380AbWFNAxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:53:44 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: bidulock@openss7.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Date: Tue, 13 Jun 2006 19:53:19 -0500
User-Agent: KMail/1.9.3
Cc: Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <200606131859.43695.chase.venters@clientec.com> <20060613183112.B8460@openss7.org>
In-Reply-To: <20060613183112.B8460@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131953.42002.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 19:30, Brian F. G. Bidulock wrote:

> Yes, and the long list of open source licenses listed on the FSF website
> as incompatible with the GPL.

Conceded, I suppose. The usage of EXPORT_SYMBOL() though tends to be for the 
reason of enabling drivers to offer functionality to the kernel -- not for 
people who want to turn the kernel into applications. (Consider for example 
how netfilter is exposed as GPL. You can build applications [routers] out of 
it, but in that case you're doing a work derived off of Linux, and you should 
be abiding by its GPL licensing terms)

> > Then would offering a 'stable API in disguise' not be a disaster and an
> > irritation to these people? If the kernel doesn't specify that an
> > in-kernel interface is stable, then there is no reason to expect it to
> > be. It might not change, but there won't be too much sympathy for
> > out-of-tree users if it does. The kernel comes with big warnings about
> > the lack of a stable API for a reason.
>
> In fact most core kernel facilities (spin lock, memory caches, character
> and block device interface, even core file system) have had a very stable
> API (way back to early 2.4 kernels).  An in fact most of them are derived
> from some variant or precursor to UNIX.  For example, memory caches are a
> Sun Solaris concept.

I'm not advocating changing the API for no reason / just to piss off out of 
tree developers. I'm just trying to make clear that in these cases, 'stable' 
is just an observation -- not something you can count on.

> It is the lack of an ABI that is most frustrating to these users.

And the presence of an ABI would be _very_ frustrating to core developers. Not 
only would these people suffer, everyone would -- developer time would be 
wasted dealing with cruft, and forward progress would be slowed.

> > > Another thing to consider is that the first step for many organizations
> > > in opening a driver under GPL is to release a proprietary module that
> > > at least first works.
> >
> > If the driver is an old-tech Linux port, then it seems there isn't too
> > much stopping them from doing this today (aside from the fact that some
> > people think proprietary modules are murky anyway). In this case, we
> > don't want a stable API/ABI, because then we leave them with little
> > incentive to open the code.
>
> "old-tech"?  No, these are high-tech drivers supported by commercial RTOS,
> from which Linux stands to benefit.  And, by not allowing these
> organizations to take the first step (generate a workable Linux driver)
> such a policy provides them little incentive to ever move the driver to
> Linux, and cuts them off from opening it.

Perhaps another term may have been more appropriate. What I mean by 'old tech' 
is more 'existing code' -- ie, something you would port. 

And these organizations _are_ afforded the opportunity to take the first step 
-- that's why interfaces critical to drivers are currently EXPORT_SYMBOL().

> I don't think that it is fair to say that an unstable API/ABI, in of
> itself, provides an incentive to open an existing proprietary driver.

Sure it does, depending on your perspective and what you're willing to 
consider. The lack of a stable API/ABI means that if you don't want to have 
to do work tracking the kernel, you should push to have your drivers merged.

> > We're not as perfect as I wish we were. But the lack of stable API (dead
> > horse) is something that is fairly well established and understood. I
> > think most people feel that the cost-benefit analysis, for Linux anyway,
> > strongly favors no stable API.
>
> Well, the lack of a stable ABI is well known.  The API is largely stable
> (but not sacrosanctly so) for the major reason that changing it within a
> large code base is difficult and error prone at best.

Perhaps, but calling it 'stable' in any sense other than idle observation is a 
disaster, because the idea leads to pain and suffering when you do have a 
major reason to change the API.

Thanks,
Chase
