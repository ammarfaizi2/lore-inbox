Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVJCRmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVJCRmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVJCRmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:42:05 -0400
Received: from fmr14.intel.com ([192.55.52.68]:18110 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932331AbVJCRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:42:02 -0400
Subject: Re: [PATCH]: Clean up of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0510030952520.8266@schroedinger.engr.sgi.com>
References: <20051001120023.A10250@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0510030828400.7812@schroedinger.engr.sgi.com>
	 <1128358558.8472.13.camel@akash.sc.intel.com>
	 <Pine.LNX.4.62.0510030952520.8266@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 03 Oct 2005 10:48:33 -0700
Message-Id: <1128361714.8472.44.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 17:41:04.0908 (UTC) FILETIME=[A0F9C4C0:01C5C841]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 09:57 -0700, Christoph Lameter wrote:
> On Mon, 3 Oct 2005, Rohit Seth wrote:
> 
> > > Seems that this removes the logic intended to prefer local 
> > > allocations over remote pages present in the existing alloc_pages? There 
> > > is the danger that this modification will lead to the allocation of remote 
> > > pages even if local pages are available. Thus reducing performance.
> > Good catch.  I will up level the cpuset check in buffered_rmqueue rather
> > then doing it in get_page_from_freelist.  That should retain the current
> > preferences for local pages.
> 
> This is not only the cpuset check. If there is memory available in an 
> earlier zone then it needs to be taken regardless of later pcp's 
> the zonelist containing pages. Otherwise we did not take the pages nearest 
> to the requested node.
> 

Ah.  Okay.

> > > I would suggest to just check the first zone's pcp instead of all zones.
> > > 
> > 
> > Na. This for most cases will be ZONE_DMA pcp list having nothing much
> > most of the time.  And picking any other zone randomly will be exposed
> > to faulty behavior.
> 
> Maybe only check the first node?
> 

I think conceptually this ask for a new flag __GFP_NODEONLY that
indicate allocations to come from current node only. 

This definitely though means I will need to separate out the allocation
from pcp patch (as Nick suggested earlier).

-rohit

