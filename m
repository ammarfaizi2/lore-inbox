Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWEWB76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWEWB76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEWB76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:59:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55698 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751239AbWEWB75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:59:57 -0400
Date: Mon, 22 May 2006 18:59:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: cpusets: only wakeup kswapd for zones in the current cpuset
In-Reply-To: <20060522182356.fbea4aec.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
 <20060522182356.fbea4aec.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006, Paul Jackson wrote:

> Three months ago, Christoph wrote:
> > If we get under some memory pressure in a cpuset (we only scan zones
> > that are in the cpuset for memory) then kswapd is woken
> > up for all zones. This patch only wakes up kswapd in zones that are
> > part of the current cpuset.
> > 
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
> > 
> > Index: linux-2.6.16-rc2/mm/page_alloc.c
> > ===================================================================
> > --- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
> > +++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 00:05:09.000000000 -0800
> > @@ -923,7 +923,8 @@ restart:
> >  		goto got_pg;
> >  
> >  	do {
> > -		wakeup_kswapd(*z, order);
> > +		if (cpuset_zone_allowed(*z, gfp_mask))
> > +			wakeup_kswapd(*z, order);
> >  	} while (*(++z));
> >  
> >  	/*
> > 
> 
> Christoph,
> 
> Does this patch serve any use?  Chris Wright just noticed (in private
> email) that wakeup_kswapd() already contains a check for cpuset
> confinement, so it would seem the above added check is superfluous.

None if that is the case.
