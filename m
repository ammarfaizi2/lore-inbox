Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbSJBSwx>; Wed, 2 Oct 2002 14:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbSJBSwx>; Wed, 2 Oct 2002 14:52:53 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:12812 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262626AbSJBSww>; Wed, 2 Oct 2002 14:52:52 -0400
Date: Wed, 2 Oct 2002 19:58:14 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, willy@debian.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
Message-ID: <20021002185814.GA23100@compsoc.man.ac.uk>
References: <20021002023901.GA91171@compsoc.man.ac.uk> <20021002032327.GA91947@compsoc.man.ac.uk> <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk> <3D9B2734.D983E835@digeo.com> <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17wohK-0001Y9-00*Teh8hHqmrUI* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 07:30:52PM +0100, Matthew Wilcox wrote:

>  *  FL_FLOCK locks never deadlock, an existing lock is always removed before
>  *  upgrading from shared to exclusive (or vice versa). When this happens
>  *  any processes blocked by the current lock are woken up and allowed to
>  *  run before the new lock is applied.
>  *  Andy Walker (andy@lysaker.kvaerner.no), June 09, 1995
> 
> > If there really is a solid need to hand the CPU over to some now-runnable
> > higher-priority process then a cond_resched() will suffice.

How will cond_resched() work ?  Surely that will only give a chance if
the current process has reached the end of its timeslice (need_resched)
? Isn't "schedule()" the right thing here ?

> check needs_resched at syscall exit, so we don't need to do it for
> unlocks, right?

right ...

regards
john

-- 
"Me and my friends are so smart, we invented this new kind of art:
 Post-modernist throwing darts"
	- the Moldy Peaches
