Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVKHCJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVKHCJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVKHCJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:09:51 -0500
Received: from fmr21.intel.com ([143.183.121.13]:1429 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030233AbVKHCJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:09:48 -0500
Subject: Re: [PATCH]: Cleanup of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051107175358.62c484a3.akpm@osdl.org>
References: <20051107174349.A8018@unix-os.sc.intel.com>
	 <20051107175358.62c484a3.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 07 Nov 2005 18:16:30 -0800
Message-Id: <1131416195.20471.31.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 02:09:29.0274 (UTC) FILETIME=[7373E1A0:01C5E409]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 17:53 -0800, Andrew Morton wrote:
> "Rohit, Seth" <rohit.seth@intel.com> wrote:
> >
> > [PATCH]: Clean up of __alloc_pages. Couple of difference from original behavior:
> > 	1- remove the initial reclaim logic
> > 	2- GFP_HIGH pages are allowed to go little below watermark sooner.
> > 	3- Search for free pages unconditionally after direct reclaim.
> 
> Would it be possible to break these into three separate patches?  The
> cleanup part should be #1.
> 

Doing the above three things as part of this clean up patch makes the
code look extra clean... Is there any specific issue coming out of 2 & 3
above.

> > +		if (!skip_cpuset_chk && (!cpuset_zone_allowed(z, gfp_mask)))
> 
> It'd be nice to not have the `skip_cpuset_chk' flag there.  a) it gives
> Linus conniptions and b) it's a little extra overhead for !CONFIG_CPUSETS
> kernels.
> 

I think it will be easier to do this change as a follow on patch as that
will change the header file, function definition and such.  Can we defer
this to separate follow on patch.

> > -	zone_statistics(zonelist, z);
> > +	zone_statistics(zonelist, page_zone(page));
> 
> Evaluating page_zone() is not completely trivial.  Can we avoid the above?

Okay.  Last time Nick also mentioned this but agreed to keep it here.  I
will uplevel so that I don't go through the page_zone.

-rohit

