Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932857AbVJCQ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbVJCQ6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbVJCQ6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:58:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26281 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932855AbVJCQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:58:00 -0400
Date: Mon, 3 Oct 2005 09:57:51 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Rohit Seth <rohit.seth@intel.com>
cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
In-Reply-To: <1128358558.8472.13.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0510030952520.8266@schroedinger.engr.sgi.com>
References: <20051001120023.A10250@unix-os.sc.intel.com> 
 <Pine.LNX.4.62.0510030828400.7812@schroedinger.engr.sgi.com>
 <1128358558.8472.13.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Rohit Seth wrote:

> > Seems that this removes the logic intended to prefer local 
> > allocations over remote pages present in the existing alloc_pages? There 
> > is the danger that this modification will lead to the allocation of remote 
> > pages even if local pages are available. Thus reducing performance.
> Good catch.  I will up level the cpuset check in buffered_rmqueue rather
> then doing it in get_page_from_freelist.  That should retain the current
> preferences for local pages.

This is not only the cpuset check. If there is memory available in an 
earlier zone then it needs to be taken regardless of later pcp's 
the zonelist containing pages. Otherwise we did not take the pages nearest 
to the requested node.

> > I would suggest to just check the first zone's pcp instead of all zones.
> > 
> 
> Na. This for most cases will be ZONE_DMA pcp list having nothing much
> most of the time.  And picking any other zone randomly will be exposed
> to faulty behavior.

Maybe only check the first node?

