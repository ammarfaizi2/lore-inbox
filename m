Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266913AbUGLSV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266913AbUGLSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266906AbUGLSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:21:57 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:8006 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S266915AbUGLSVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:21:45 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@redhat.com>
Cc: Daniel Phillips <phillips@istop.com>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
In-Reply-To: <200407120023.44773.phillips@redhat.com>
References: <200407050209.29268.phillips@redhat.com>
	 <200407111544.25590.phillips@istop.com>
	 <1089605292.19787.62.camel@persist.az.mvista.com>
	 <200407120023.44773.phillips@redhat.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1089656497.608.4.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 11:21:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-11 at 21:23, Daniel Phillips wrote:
> On Monday 12 July 2004 00:08, Steven Dake wrote:
> > On Sun, 2004-07-11 at 12:44, Daniel Phillips wrote:
> > Oom conditions are another fact of life for poorly sized systems.  If
> > a cluster is within an OOM condition, it should be removed from the
> > cluster (because it is in overload, under which unknown and generally
> > bad behaviors occur).
> 
> You missed the point.  The memory deadlock I pointed out occurs in 
> _normal operation_.  You have to find a way around it, or kernel 
> cluster services win, plain and simple.
> 

The bottom line is that we just don't know if any such deadlock occurs,
under normal operations.  The remaining objections to in-kernel cluster
services give us alot of reason to test out a userland approach.

I propose after a distributed lock service is implemented in user space,
to add support for such a project into the gfs and remaining redhat
storage cluster services trees.  This will give us real data on
performance and reliability that we can't get by guessing.

Thanks
-steve


> > current code.  If at a later time the processor can reenter the
> > membership because it has freed up some memory, it will do so
> > correctly.
> 
> Think about it.  Do you want nodes spontaneously falling over from time 
> to time, even though nothing is wrong with them?  What does that do 
> your 5 nines?
> 
> > > > I would rather avoid non-mainline kernel dependencies at this
> > > > time as it makes adoption difficult until kernel patches are
> > > > merged into upstream code.  Who wants to patch their kernel to
> > > > try out some APIs?
> > >
> > > Everybody working on clusters.  It's a fact of life that you have
> > > to apply patches to run cluster filesystems right now.  Production
> > > will be a different story, but (except for the stable GFS code on
> > > 2.4) nobody is close to that.
> >
> > Perhaps people skilled in running pre-alpha software would consider
> > patching a kernel to "give it a run".  I have no doubts about that.
> >
> > I would posit a guess people interested in implementing production
> > clusters are not too interested about applying kernel patches (and
> > causing their kernel to become unsupported) to achieve clustering
> > support any time soon.
> 
> We are _far_ from production, at least on 2.6.  At this point, we are 
> only interested in people who like to code, test, tinker, and be the 
> first kid on the block with a shiny new storage cluster in their rec 
> room.  And by "we" I mean "you, me, and everybody else who hopes that 
> Linux will kick butt in clusters, in the 2.8 time frame."
> 
> > > > I am doubtful these sort of kernel patches will be merged without
> > > > a strong argument of why it absolutely must be implemented in the
> > > > kernel vs all of the counter arguments against a kernel
> > > > implementation.
> > >
> > > True.  Do you agree that the PF_MEMALLOC argument is a strong one?
> >
> > out of memory overload is a sucky situation poorly handled by any
> > software, kernel, userland, embedded, whatever.
> 
> In case you missed it above, please let me point out one more time that 
> I am not talking about OOM.  I'm talking about a deadlock that may come 
> up even when a resource usage is well within limits, which is inherent 
> in the basic design of Linux.  There is nothing Byzantine about it.
> 
> Regards,
> 
> Daniel

