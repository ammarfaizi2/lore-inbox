Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUG1NiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUG1NiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266913AbUG1NiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 09:38:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55513 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266912AbUG1NiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 09:38:17 -0400
Date: Wed, 28 Jul 2004 15:31:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Sweetman <safemode@comcast.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
Message-ID: <20040728133113.GF10377@suse.de>
References: <410500FD.8070206@comcast.net> <4105D7ED.5040206@yahoo.com.au> <20040727100724.GA11189@suse.de> <41065748.8050107@comcast.net> <41065902.20909@yahoo.com.au> <4106D978.7090008@comcast.net> <4106FAAB.5080106@yahoo.com.au> <4107480A.8020808@comcast.net> <20040728064516.GC11690@suse.de> <4107A2FE.6040803@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4107A2FE.6040803@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28 2004, Ed Sweetman wrote:
> Jens Axboe wrote:
> 
> >On Wed, Jul 28 2004, Ed Sweetman wrote:
> > 
> >
> >>Nick Piggin wrote:
> >>
> >>   
> >>
> >>>Ed Sweetman wrote:
> >>>
> >>>     
> >>>
> >>>>Nick Piggin wrote:
> >>>>
> >>>>       
> >>>>
> >>>>>OK so it does sound like a different problem.
> >>>>>
> >>>>>I didn't follow your other thread closely... does /proc/slabinfo
> >>>>>show any evidence of a leak?
> >>>>>         
> >>>>>
> >>>>
> >>>>
> >>>>Surprisingly no. You'd think that since the kernel is responsible for 
> >>>>saying what memory can't be touched or swapped out it would have some 
> >>>>sort of tag on the huge 600MB of ram I currently can't do anything 
> >>>>with since i burned that audio cd but slabinfo doesn't seem to show 
> >>>>anything about it. Maybe i'm reading it wrong.
> >>>>
> >>>>       
> >>>>
> >>>It could be memory coming straight out of the page allocator that
> >>>isn't being freed.
> >>>
> >>>Jens, any ideas?
> >>>-
> >>>     
> >>>
> >>
> >>Con Kolivas' 2.6.8-rc1-ck6 snapshot patch seems fix the problem.  Not 
> >>only is my audio not corrupted when i write a disk but I get no mem leak 
> >>situation and thus no OOM.  I did 5 dummy burns with no swap being used 
> >>and stable vm statistics, final real burn resulted in successful disc.
> >>
> >>2.6.8-rc1 2.6.8-rc1-mm both flipped out.  ck touches all relevent files 
> >>so something the patch does fixed whatever was wrong. 
> >>   
> >>
> >
> >This makes about zero sense to me (a leak I can understand, corrupted
> >audio is more weird). Can you point me at the specific patch used?
> >
> > 
> >
> the corruption may have been a combination of not burning a cd without 
> -pad and without -swab at the same time as using -audio.  It appears my 
> drive burns audio just fine with just -audio as the argument for cdrecord. 

The corruption issue _must_ be a user error.

> http://ck.kolivas.org/patches/2.6/2.6.7/2.6.8-rc1/snapshot-2.6.8-rc1-ck6-0407151120.bz2

Did you use cfq with the other kernels as well? If your problem isn't
one of the vm, I still don't see how this patch can make any difference
whatsoever. There are no changes to the paths used writing the data,
once you exit the page allocation.

-- 
Jens Axboe

