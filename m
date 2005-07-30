Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVG3SLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVG3SLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbVG3SLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:11:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25293 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263094AbVG3SKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:10:04 -0400
Date: Sat, 30 Jul 2005 11:10:01 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: long delays (possibly infinite) in time_interpolator_get_counter
In-Reply-To: <1122742054.28719.58.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0507301105120.25104@schroedinger.engr.sgi.com>
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com> 
 <Pine.LNX.4.62.0507291625390.19428@schroedinger.engr.sgi.com>
 <1122742054.28719.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Alex Williamson wrote:

> On Fri, 2005-07-29 at 16:31 -0700, Christoph Lameter wrote:
> > What you are dealing with is a machine that is using ITC as a time bases. 
> > That is a special case.
> 
>    The default time source for ia64 systems is a "special case"?  4
> socket and smaller boxes typically do not have any other time source.

It is a special case because we typically use other time sources. The 
limitations of cycle counters in SMP environments are well known and most 
hardware manufacturers have dealt with this issue by using another clock 
source.

>    And what if you don't have any HPET and aren't willing to take that
> risk?  We need a solution that works with all time sources.  A system
> with the default time source should not hang or have unreasonable delays
> with the standard setup.  Why is a synchronized ITC driven from a common
> clock such a terrible time source for small systems

If it is really synchronized then you can run with "nojitter" without any 
issue. Then you wont have to deal with the cmpxchg and everything is fine. 
But I suspect that the ITC are NOT truly synchronized (it has an 
"offset" that may be nonzero right?) otherwise you would have used nojitter.

> in progress.  In any case, I think we need to focus on a solution that
> works well on all systems, not just those with extra timer hardware.

Extra timer hardware is necessary to fix the ITC deficiency. You are at 
the source of the problem. Fix the damn hardware to provide a standardized 
synchronized clock or provide a truly synchronized ITC.
