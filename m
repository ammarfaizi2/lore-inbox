Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbULOXlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbULOXlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbULOXlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:41:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41643 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262509AbULOXlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:41:47 -0500
Date: Wed, 15 Dec 2004 15:41:41 -0800
From: Greg KH <greg@kroah.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215234141.GA9268@kroah.com>
References: <20041215011132.GA16099@kroah.com> <Pine.LNX.4.44.0412151656010.2704-100000@localhost.localdomain> <20041215175805.GA9207@kroah.com> <20041215190343.GI16322@dualathlon.random> <20041215224826.GC28286@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215224826.GC28286@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 11:48:26PM +0100, Andrea Arcangeli wrote:
> On Wed, Dec 15, 2004 at 08:03:43PM +0100, Andrea Arcangeli wrote:
> > +			if (page->mapping)
> > +				page_remove_rmap(page);
> 
> This had to be page_mapping, since I believe the page->mapping can go
> away with the truncate while the page is still being mapped.
> 
> The rule is that if a page must not be accounted it will never be
> accounted and page_mapping will be always 0. If it has been accounted
> previously, then it must be unaccounted too. This worked fine so far.
> 
> Plus I noticed other goodness that got dropped in the same area from my
> original 2.6.5 patches, and I resurrected those too in sync with SP1
> (I'm talking about the fork path).
>  
> So here an updated patch, please give this one a spin.

No oops with this patch or odd messages in the syslog!  It works fine
for me, thanks a lot.

I'll let the mm developers battle it out to determine if this is a good
fix or not :)

thanks,

greg k-h
