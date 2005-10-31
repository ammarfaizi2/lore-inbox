Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVJaTCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVJaTCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVJaTCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:02:44 -0500
Received: from fmr23.intel.com ([143.183.121.15]:17854 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932162AbVJaTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:02:44 -0500
Subject: Re: [PATCH]: Clean up of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051029171630.04a69660.pj@sgi.com>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	 <20051029171630.04a69660.pj@sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 31 Oct 2005 11:09:39 -0800
Message-Id: <1130785780.4853.5.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2005 19:02:29.0213 (UTC) FILETIME=[A3D090D0:01C5DE4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 17:16 -0700, Paul Jackson wrote:
> Seth wroteL
> > @@ -851,19 +853,11 @@
> >  	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
> >  	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
> >  	 */
> > -	for (i = 0; (z = zones[i]) != NULL; i++) {
> > -		if (!zone_watermark_ok(z, order, z->pages_min,
> > -				       classzone_idx, can_try_harder,
> > -				       gfp_mask & __GFP_HIGH))
> > -			continue;
> > -
> > -		if (wait && !cpuset_zone_allowed(z, gfp_mask))
> > -			continue;
> > -
> > -		page = buffered_rmqueue(z, order, gfp_mask);
> > -		if (page)
> > -			goto got_pg;
> > -	}
> > +	if (!wait)
> > +		page = get_page_from_freelist(gfp_mask, order, zones, 
> > +						can_try_harder);
> 
> Thanks for the clean-up work.  Good stuff.
> 
> I think you've changed the affect that the cpuset check has on the
> above pass.
> 
> As you know, the above is the last chance we have for GFP_ATOMIC (can't
> wait) allocations before getting into the oom_kill code.  The code had
> been written to ignore cpuset constraints for GFP_ATOMIC (that is,
> "!wait") allocations.  The intent is to allow taking GFP_ATOMIC memory
> from any damn node we can find it on, rather than start killing.
> 
> Your change will call into get_page_from_freelist() in such cases,
> where the cpuset check is still done.


Shooo....I will fix it.

-rohit

