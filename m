Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWFPXlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWFPXlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWFPXlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:41:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18062 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932464AbWFPXlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:41:20 -0400
Date: Fri, 16 Jun 2006 18:40:56 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Chase Venters <chase.venters@clientec.com>
cc: Andi Kleen <ak@suse.de>, Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       Jes Sorensen <jes@sgi.com>, Tony Luck <tony.luck@intel.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
In-Reply-To: <Pine.LNX.4.64.0606161615450.23743@turbotaz.ourhouse>
Message-ID: <20060616181940.S91827@pkunk.americas.sgi.com>
References: <200606140942.31150.ak@suse.de> <200606161656.40930.ak@suse.de>
 <20060616102516.A91827@pkunk.americas.sgi.com> <200606161740.18611.ak@suse.de>
 <Pine.LNX.4.64.0606161615450.23743@turbotaz.ourhouse>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Chase Venters wrote:

> On Fri, 16 Jun 2006, Andi Kleen wrote:
> 
> > 
> > > To this last point, it might be more reasonable to map in a page that
> > > contained a new structure with a stable ABI, which mirrored some of
> > > the task_struct information, and likely other useful information as
> > > needs are identified in the future.  In any case, it would be hard
> > > to beat a single memory read for performance.
> > 
> > That would mean making the context switch and possibly other
> > things slower.
> 
> Well, if every process had a page of its own, what would the context switch
> overhead be?

Mostly copying the useful information into the read-only mapped page.

However, this doesn't have to be all that expensive.  The particular
information we care about in this case only needs to be copied when a
task begins running on a CPU different from the one it last ran on.  In
fact, on ia64 we already have something very similar to handle certain
I/O pecularities on SN2.

http://marc.theaimsgroup.com/?l=linux-ia64&m=113831137712197&w=2

That work could form the basis for a low-impact method of exporting
the current CPU to user space via a read-only mapped page.  I'll admit
to having zero knowledge of whether this would be workable on anything
other than ia64.

Thanks,
Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
