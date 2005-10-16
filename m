Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVJPCwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVJPCwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 22:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVJPCwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 22:52:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59044 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751277AbVJPCwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 22:52:33 -0400
Date: Sat, 15 Oct 2005 19:52:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, jschopp@austin.ibm.com, mel@csn.ul.ie, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/8] Fragmentation Avoidance V17
Message-Id: <20051015195213.44e0dabb.pj@sgi.com>
In-Reply-To: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> +#define __GFP_USER       0x80000u  /* User and other easily reclaimed pages */
> +#define __GFP_KERNRCLM   0x100000u /* Kernel page that is reclaimable */

Sorry, but that __GFP_USER name is still sticking in my craw.

I won't try to reopen my quest to get it named __GFP_REALLY_REALLY_EASY_RCLM
or whatever it was, but instead will venture on a new quest.

Can we get the 'RCLM' in there.  Especially since this term appears
naked in such code as:

> -				page = alloc_page(GFP_HIGHUSER);
> +				page = alloc_page(GFP_HIGHUSER|__GFP_USER);

where it is not at all obvious to the reader of this file (fs/exec.c)
that the __GFP_USER term is commenting on the reclaim behaviour of
the page to be allocated.

I'd be happier with:

> +#define __GFP_USERRCLM    0x80000u /* User and other easily reclaimed pages */
> +#define __GFP_KERNRCLM   0x100000u /* Kernel page that is reclaimable */

and:

> -				page = alloc_page(GFP_HIGHUSER);
> +				page = alloc_page(GFP_HIGHUSER|__GFP_USERRCLM);

Also the bold assymetry of these two #defines seems to be without motivation,
one with the 'RCLM', and the other with '    ' four spaces.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
