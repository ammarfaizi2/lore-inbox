Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVJEQ5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVJEQ5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVJEQ5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:57:17 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:19607 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030249AbVJEQ5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:57:15 -0400
Date: Wed, 5 Oct 2005 17:57:03 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH 3/7] Fragmentation Avoidance V16: 003_fragcore
In-Reply-To: <1128530908.26009.28.camel@localhost>
Message-ID: <Pine.LNX.4.58.0510051749510.16421@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie> 
 <20051005144602.11796.53850.sendpatchset@skynet.csn.ul.ie>
 <1128530908.26009.28.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Dave Hansen wrote:

> On Wed, 2005-10-05 at 15:46 +0100, Mel Gorman wrote:
> >
> > @@ -1483,8 +1540,10 @@ void show_free_areas(void)
> >
> >                 spin_lock_irqsave(&zone->lock, flags);
> >                 for (order = 0; order < MAX_ORDER; order++) {
> > -                       nr = zone->free_area[order].nr_free;
> > -                       total += nr << order;
> > +                       for (type=0; type < RCLM_TYPES; type++) {
> > +                               nr = zone->free_area_lists[type][order].nr_free;
> > +                               total += nr << order;
> > +                       }
>
> Can that use the new for_each_ macro?
>

Yes, yes it can. Not sure why I dismissed it the first time around.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
