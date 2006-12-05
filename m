Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968389AbWLEQAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968389AbWLEQAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968391AbWLEQAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:00:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47179 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S968389AbWLEQAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:00:52 -0500
Date: Tue, 5 Dec 2006 08:00:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061204142259.3cdda664.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612050754560.11213@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
 <20061204120611.4306024e.akpm@osdl.org> <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
 <20061204131959.bdeeee41.akpm@osdl.org> <Pine.LNX.4.64.0612041337520.851@schroedinger.engr.sgi.com>
 <20061204142259.3cdda664.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Andrew Morton wrote:

> > > What happens when we need to run reclaim against just a section of a zone?
> > > Lumpy-reclaim could be used here; perhaps that's Mel's approach too?
> > 
> > Why would we run reclaim against a section of a zone?
> 
> Strange question.  Because all the pages are in use for something else.

We always run reclaim against the whole zone not against parts. Why 
would we start running reclaim against a portion of a zone?

> > Mel aready has that for anti-frag. The sections are per MAX_ORDER area 
> > and the only states are movable unmovable and reclaimable. There is 
> > nothing more to it. No other state information should be added. Why would 
> > we need sub zones? For what purpose?
> 
> You're proposing that for memory hot-unplug, we take a single zone and by
> some means subdivide that into sections which correspond to physically
> hot-unpluggable memory.  That certainly does not map onto MAX_ORDER
> sections.

Mel's patches are already managing "sections" (if you want to call it 
that) of a zone in units of MAX_ORDER. If we memorize where the lowest 
unmovable MAX_ORDER block is then we have the necessary separation and can 
do memory unplug on the remainder of the zone.

> > What feature are you talking about?
> 
> Memory hot-unplug, of course.

There are multiple issues that we discuss here. Please be clear. 
Categorical demands for perfection certainly wont help us.
