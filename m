Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUCXQf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbUCXQf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:35:59 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:6123 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263766AbUCXQfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:35:55 -0500
Date: Wed, 24 Mar 2004 08:35:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <35130000.1080146145@[10.10.2.4]>
In-Reply-To: <20040324162116.GQ2065@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]> <20040321235207.GC3649@dualathlon.random> <1684742704.1079970781@[10.10.2.4]> <20040324061957.GB2065@dualathlon.random> <24560000.1080143798@[10.10.2.4]> <20040324162116.GQ2065@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> here it's not the fastest (though a 0.03 difference should be in the
> error range with an unlimited -j)
>
> overall I think for the fast path we can conclude they're at least
> equally fast.

Yup, I think they're all within the noise level between anon_mm and anon_vma,
though both are faster than partial by something at lease statistically
significant (though maybe not even enough to care about for these 
workloads).

> it's interesting I get 0 standard deviation. Is it possible I get lower
> standard deviation because you run it less times? just wondering. I'd
> expect SDET has a default number of passes, so I expect the answer is no
> of course.

Yeah, it does 5 passes, and throws away the fastest and slowest. So it's
only 3 it's calculating off ... I think you just got lucky with a 0.0% ;-)
That's the most stable way I found of getting consistent results.

> it's one of the -mm patches probably that boosts those bits (the
> cost page_add_rmap and the page faults should be the same with both
> anon-vma and anonmm). as for the regression, the pgd_alloc slowdown is
> the unslabify one from andrew that releases 8 bytes per page in 32bit
> archs and 16 bytes per page in 64bit archs.

OK, great ... thanks for the info. I think I'd happily pay that cost in
pgd_alloc for the space gain - kernbench & SDET are about as bad as it
gets on pgd_alloc, so that seems like a good tradeoff.
 
> My current page_t is now 36 bytes (compared to 48bytes of 2.4) in 32bit
> archs, and 56bytes on 64bit archs (hope I counted right this time, Hugh
> says I'm counting wrong the page_t, methinks we were looking different
> source trees instead but maybe I was really counting wrong ;).

IIRC, with PAE etc on, mainline is 44 bytes. So if we saved 8 from Andrew's
change, and 4 from objrmap, I'd be hoping for 32?

M.


