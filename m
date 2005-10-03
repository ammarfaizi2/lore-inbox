Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVJCR5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVJCR5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVJCR5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:57:01 -0400
Received: from dvhart.com ([64.146.134.43]:6291 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751168AbVJCR5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:57:00 -0400
Date: Mon, 03 Oct 2005 10:56:57 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 (Oops, possibly Netfilter related?)
Message-ID: <102290000.1128362217@[10.10.2.4]>
In-Reply-To: <1128360043.8472.23.camel@akash.sc.intel.com>
References: <20050921222839.76c53ba1.akpm@osdl.org> <4338F136.1020404@reub.net><20050927004410.29ab9c03.akpm@osdl.org> <925820000.1127847556@flay> <20051002101319.659afcde.pj@sgi.com> <48080000.1128288669@[10.10.2.4]> <1128360043.8472.23.camel@akash.sc.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk patch tries to
> allocate more physical contiguous pages for pcp.  This would cause some
> extra fragmentation at the higher orders but has the potential benefit
> of spreading more uniformly across caches.  I agree though that for this
> scheme to work nicely we should have the capability of draining the pcps
> so that higher order requests can be serviced whenever possible.

Unfortunately, I don't think it's that simple. We'll end up taking the
higher order elements from the buddy into the caches, and using them
all piecemeal - ie fragmenting it all. 

If we take lists of 0 order pages from the buddy, we're trying to use
whatever dross was left over in there (from a fragmentation point of view)
up first, before breaking into the more precious stuff (phys contig bits).

That was why I wrote it that way in the first place - it wasn't 
accidental ;-)

>From the direction the thread was going in previously, it sounded like
you were finding other ways to alleviate the colouring issue you were
seeing ... I was hoping that would fix it up enough the desire for higher
order allocations would disappear.

To be blunt about it ... making sure that we don't fall over on higher 
order allocs seems to me to be more important than a bit of variability 
in benchmark runs ...

M.


