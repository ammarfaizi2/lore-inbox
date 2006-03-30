Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWC3Gsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWC3Gsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWC3Gsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:48:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751146AbWC3Gsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:48:35 -0500
Date: Wed, 29 Mar 2006 22:47:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: nagar@watson.ibm.com, greg@kroah.com, arjan@infradead.org, hadi@cyberus.ca,
       ak@suse.de, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Patch 0/8] per-task delay accounting
Message-Id: <20060329224737.071b9567.akpm@osdl.org>
In-Reply-To: <20060330062357.GB18387@in.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<20060329210314.3db53aaa.akpm@osdl.org>
	<20060330062357.GB18387@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
> On Wed, Mar 29, 2006 at 09:03:14PM -0800, Andrew Morton wrote:
> > Shailabh Nagar <nagar@watson.ibm.com> wrote:
> > >
> > > Could you please include the following delay accounting patches
> > >  in -mm ?
> > 
> > I'm at a loss to evaluate the suitability of this work, really.  I always
> > am when accounting patches come along.
> > 
> > There are various people and various groups working on various different
> > things and there appears to be no coordination and little commonality of
> > aims.  I worry that picking one submission basically at random will provide
> > nothing which the other groups can work on to build up their feature.
> > 
> > On the other hand, we don't want to do nothing until some uber-grand
> > all-singing, all-dancing statistics-gathering infrastructure comes along.
> > 
> > So I'm a bit stuck.  What I would like to see happen is that there be some
> > coordination between the various stakeholders, and some vague plan which
> > they're all happy with as a basis for the eventual grand solution.
> > 
> > We already have various bits and pieces of statistics gathering in the
> > kernel and it's already a bit ad-hoc.  Adding more one-requirement-specific
> > accounting code won't improve that situation.
> > 
> > But then, I said all this a year or two ago and nothing much has happened
> > since then.  It's not your fault, but it's a problem.
> > 
> > Perhaps a good starting point would be a one-page bullet-point-form
> > wishlist of all the accounting which people want to get out of the kernel,
> > and a description of what the kernel<->user interface should look like. 
> > Right now, I don't think we even have a picture of that.
> > 
> > We need a statistics maintainer, too, to pull together the plan,
> > coordinate, push things forwards.  The first step would be to identify the
> > stakeholders, come up with that page of bullet-points.
> > 
> > Then again, maybe the right thing to do is to keep adding low-impact
> > requirement-specific statistics patches as they come along.  But if we're
> > going to do it that way, we need an up-front reason for doing so, and I
> > don't know what that would be.
> > 
> > See my problem?
> 
> One of the issues we have tried to address is the ability to provide some
> form of a common ground for all the statistics to co-exist. Various methods
> were discussed for exchanging data between kernel and user space, genetlink
> was suggested often and the clear winner.
> 
> To that end, we have created a taskstats.c file. Any subsystem wanting
> to add their statistics and sending it to user space can add their own
> types by extending taskstats.c (changing the version number) and creating
> their own types using genetlink. They will have to do the following
> 
> 1. Add statistics gathering in their own subsystem
> 2. Add a type to taskstats.c, extend it and use data from (1) and send
>    it to user space.
> 
> The data from various subsystems can co-exist. I feel that this could serve as
> the basic common infrastructure to begin with and refined later (depending on
> the needs of other people).
> 

Sounds fine to me, but I'm not a stakeholder.

Trolling back through lse-tech gives us:

pnotify:
  Erik Jacobson <erikj@sgi.com>

CSA accounting/PAGG/JOB:
  Jay Lan <jlan@engr.sgi.com>
  Limin Gu <limin@dbear.engr.sgi.com>

per-process IO statistics:
  Levent Serinol <lserinol@gmail.com>

ELSA:
  Guillaume Thouvenin <guillaume.thouvenin@bull.net>

per-cpu time statistics:
  Erich Focht <efocht@ess.nec.de>

Scalable statistics counters with /proc reporting:
  Ravikiran G Thirumalai <kiran@in.ibm.com>
  (Kiran feft IBM, but presumably the requirement lives on)

There was a long thread "A common layer for Accounting packages".  Did it
come to a conclusion?

Anyway, if mostly everyone is mostly happy with what you propose then that
it good news.
