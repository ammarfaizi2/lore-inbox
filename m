Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266714AbUGLEXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266714AbUGLEXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 00:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266716AbUGLEXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 00:23:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266714AbUGLEXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 00:23:48 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: sdake@mvista.com
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Mon, 12 Jul 2004 00:23:44 -0400
User-Agent: KMail/1.6.2
Cc: Daniel Phillips <phillips@istop.com>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
References: <200407050209.29268.phillips@redhat.com> <200407111544.25590.phillips@istop.com> <1089605292.19787.62.camel@persist.az.mvista.com>
In-Reply-To: <1089605292.19787.62.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407120023.44773.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 July 2004 00:08, Steven Dake wrote:
> On Sun, 2004-07-11 at 12:44, Daniel Phillips wrote:
> Oom conditions are another fact of life for poorly sized systems.  If
> a cluster is within an OOM condition, it should be removed from the
> cluster (because it is in overload, under which unknown and generally
> bad behaviors occur).

You missed the point.  The memory deadlock I pointed out occurs in 
_normal operation_.  You have to find a way around it, or kernel 
cluster services win, plain and simple.

> The openais project does just this: If everything goes to hell in a
> handbasket on the node running the cluster executive, it will be
> rejected from the membership.  This rejection is implemented with a
> distributed state machine that ensures, even in low memory
> conditions, every node (including the failed node) reaches the same
> conclusions about the current membership and works today in the
> current code.  If at a later time the processor can reenter the
> membership because it has freed up some memory, it will do so
> correctly.

Think about it.  Do you want nodes spontaneously falling over from time 
to time, even though nothing is wrong with them?  What does that do 
your 5 nines?

> > > I would rather avoid non-mainline kernel dependencies at this
> > > time as it makes adoption difficult until kernel patches are
> > > merged into upstream code.  Who wants to patch their kernel to
> > > try out some APIs?
> >
> > Everybody working on clusters.  It's a fact of life that you have
> > to apply patches to run cluster filesystems right now.  Production
> > will be a different story, but (except for the stable GFS code on
> > 2.4) nobody is close to that.
>
> Perhaps people skilled in running pre-alpha software would consider
> patching a kernel to "give it a run".  I have no doubts about that.
>
> I would posit a guess people interested in implementing production
> clusters are not too interested about applying kernel patches (and
> causing their kernel to become unsupported) to achieve clustering
> support any time soon.

We are _far_ from production, at least on 2.6.  At this point, we are 
only interested in people who like to code, test, tinker, and be the 
first kid on the block with a shiny new storage cluster in their rec 
room.  And by "we" I mean "you, me, and everybody else who hopes that 
Linux will kick butt in clusters, in the 2.8 time frame."

> > > I am doubtful these sort of kernel patches will be merged without
> > > a strong argument of why it absolutely must be implemented in the
> > > kernel vs all of the counter arguments against a kernel
> > > implementation.
> >
> > True.  Do you agree that the PF_MEMALLOC argument is a strong one?
>
> out of memory overload is a sucky situation poorly handled by any
> software, kernel, userland, embedded, whatever.

In case you missed it above, please let me point out one more time that 
I am not talking about OOM.  I'm talking about a deadlock that may come 
up even when a resource usage is well within limits, which is inherent 
in the basic design of Linux.  There is nothing Byzantine about it.

Regards,

Daniel
