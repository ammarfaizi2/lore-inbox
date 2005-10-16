Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVJPMAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVJPMAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 08:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVJPMAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 08:00:01 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:40936 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751221AbVJPMAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 08:00:01 -0400
Date: Sun, 16 Oct 2005 12:59:53 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, jschopp@austin.ibm.com, kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/8] Fragmentation Avoidance V17
In-Reply-To: <20051015195213.44e0dabb.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0510161255570.32005@skynet>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
 <20051015195213.44e0dabb.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2005, Paul Jackson wrote:

> Mel wrote:
> > +#define __GFP_USER       0x80000u  /* User and other easily reclaimed pages */
> > +#define __GFP_KERNRCLM   0x100000u /* Kernel page that is reclaimable */
>
> Sorry, but that __GFP_USER name is still sticking in my craw.
>
> I won't try to reopen my quest to get it named __GFP_REALLY_REALLY_EASY_RCLM
> or whatever it was, but instead will venture on a new quest.
>
> Can we get the 'RCLM' in there.  Especially since this term appears
> naked in such code as:
>

__GFP_USERRCLM is the original name and the motivation for changing it to
__GFP_USER no longer exists. However, __GFP_EASYRCLM would also make sense
as it flags pages that are (surprise surprise) easily reclaimed. Would
__GFP_EASYRCLM be the best choice? __GFP_USERRCLM may imply to some
readers that it is reclaimed by the user somehow. The flags would then be;

__GFP_EASYRCLM - Allocations for pages that are easily reclaimed such as
userspace and buffer pages

__GFP_KERNRCLM - Allocations for pages that may be reclaimed by the kernel
such as caches

No flag - Page cannot be easily reclaimed by any mechanism.

I would be happy with __GFP_USERRCLM but __GFP_EASYRCLM may be more
obvious?

> > -				page = alloc_page(GFP_HIGHUSER);
> > +				page = alloc_page(GFP_HIGHUSER|__GFP_USER);
>
> where it is not at all obvious to the reader of this file (fs/exec.c)
> that the __GFP_USER term is commenting on the reclaim behaviour of
> the page to be allocated.
>
> I'd be happier with:
>
> > +#define __GFP_USERRCLM    0x80000u /* User and other easily reclaimed pages */
> > +#define __GFP_KERNRCLM   0x100000u /* Kernel page that is reclaimable */
>
> and:
>
> > -				page = alloc_page(GFP_HIGHUSER);
> > +				page = alloc_page(GFP_HIGHUSER|__GFP_USERRCLM);
>
> Also the bold assymetry of these two #defines seems to be without motivation,
> one with the 'RCLM', and the other with '    ' four spaces.
>
>

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
