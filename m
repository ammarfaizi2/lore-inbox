Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVCRMbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVCRMbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 07:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCRMbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 07:31:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32967 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261163AbVCRMbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 07:31:32 -0500
Date: Fri, 18 Mar 2005 06:31:13 -0600
From: Robin Holt <holt@sgi.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: vm_dirty_ratio seems a bit large.
Message-ID: <20050318123112.GA28473@lnx-holt.americas.sgi.com>
References: <20050317205213.GC17353@lnx-holt.americas.sgi.com> <20050317133148.1122e9c4.akpm@osdl.org> <16954.1107.911531.142306@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16954.1107.911531.142306@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 09:27:31AM +1100, Peter Chubb wrote:
> >>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:
> 
> Andrew> Robin Holt <holt@sgi.com> wrote:
> 
> >>  One other issue we have is the vm_dirty_ratio and background_ratio
> >> adjustments are a little coarse with these memory sizes.  Since our
> >> minimum adjustment is 1%, we are adjusting by 40GB on the largest
> >> configuration from above.  The hardware we are shipping today is
> >> capable of going to far greater amounts of memory, but we don't
> >> have customers demanding that yet.  I would like to plan ahead for
> >> that and change vm_dirty_ratio from a straight percent into a
> >> millipercent (thousandth of a percent).  Would that type of change
> >> be acceptable?
> 
> Andrew> Oh drat.  I think such a change would require a new set of
> Andrew> /proc entries.  
> 
> No, you could just extend them to understand fixed point.  Keep
> printing integers as integers, print non-integers with one (or two:
> will we ever need 0.01% increments?) decimal places.

Right now, it is possible to build our largest Altix configuration with
64TB of memory (unfortunatetly, we can't get any customers to pay that
large of bill ;).  We are currently shipping a few 4TB systems and hope
to be selling 20TB systems by the end of the year (at least engineering
hopes to).

Given that, two decimal places are really not enough.  We probably need
at least 3.

Is there any reason to not do 3 places?  Is this the right direction to
head or does anybody know of problems this would cause?

Thanks,
Robin Holt
