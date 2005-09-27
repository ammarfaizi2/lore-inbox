Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVI0XI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVI0XI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbVI0XI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:08:57 -0400
Received: from fmr15.intel.com ([192.55.52.69]:31403 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S965231AbVI0XI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:08:56 -0400
Subject: Re: 2.6.14-rc2-mm1
From: Rohit Seth <rohit.seth@intel.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1007710000.1127861369@flay>
References: <922980000.1127847470@flay>
	 <1127851502.6144.10.camel@akash.sc.intel.com>  <970900000.1127855894@flay>
	 <1127857919.7258.13.camel@akash.sc.intel.com>  <985130000.1127858385@flay>
	 <1127861347.7258.47.camel@akash.sc.intel.com>  <1007710000.1127861369@flay>
Content-Type: text/plain
Organization: Intel 
Date: Tue, 27 Sep 2005 16:16:12 -0700
Message-Id: <1127862972.7258.59.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 23:08:43.0586 (UTC) FILETIME=[67FB7A20:01C5C3B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 15:49 -0700, Martin J. Bligh wrote:


> > 
> > Thinking of initiating this drain operation after the swapper daemon is
> > woken up.  hopefully that will allow other possible pages to be put back
> > on freelist and reduce the possible thrash of pages between freemem pool
> > and pcps.
> 
> OK, but waking up kswapd doesn't indicate a low memory condition.
> It's standard procedure .... we'll have to wake it up whenever we dip
> below the high watermarks. Perhaps before dropping into direct reclaim
> would be more appropriate?
>  

Agreed.  That is a better place.
 
> >> >> Could you elaborate on what the benefits were from this change in the
> >> >> first place? Some page colouring thing on ia64? It seems to have way more
> >> >> downside than upside to me.
> >> > 
> >> > The original change was to try to allocate a higher order page to
> >> > service a batch size bulk request.  This was with the hope that better
> >> > physical contiguity will spread the data better across big caches.
> >> 
> >> OK ... but it has an impact on fragmentation. How much benefit are you
> >> getting?
> > 
> > Benefit is in terms of reduced performance variation (and expected
> > throughput) of certain workloads from run to run on the same kernel. 
> 
> Mmmm. how much are you talking about in terms of throughput, and on what
> platforms? all previous attempts to measure page colouring seemed to 
> indicate it did nothing at all - maybe some specific types of h/w are
> more susceptible?
> 

In terms of percentages, between 10-15% variation.  Nothing out of
regular about the platforms.  Do you remember what workloads were run in
the previous attempts to see if there is any coloring.  I agree that
with 2.6.x based kernel, there is better handle on the variation (as
compared to 2.4).  And the best results of 2.6 matches the best results
of any coloring patch. 

-rohit
> 

