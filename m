Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCXUDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCXUCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:02:21 -0500
Received: from holomorphy.com ([207.189.100.168]:18565 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261161AbUCXUCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:02:01 -0500
Date: Wed, 24 Mar 2004 12:01:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040324200156.GK791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]> <20040321235207.GC3649@dualathlon.random> <1684742704.1079970781@[10.10.2.4]> <20040324061957.GB2065@dualathlon.random> <24560000.1080143798@[10.10.2.4]> <20040324162116.GQ2065@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324162116.GQ2065@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 05:21:16PM +0100, Andrea Arcangeli wrote:
> it's one of the -mm patches probably that boosts those bits (the
> cost page_add_rmap and the page faults should be the same with both
> anon-vma and anonmm). as for the regression, the pgd_alloc slowdown is
> the unslabify one from andrew that releases 8 bytes per page in 32bit
> archs and 16 bytes per page in 64bit archs.
> My current page_t is now 36 bytes (compared to 48bytes of 2.4) in 32bit
> archs, and 56bytes on 64bit archs (hope I counted right this time, Hugh
> says I'm counting wrong the page_t, methinks we were looking different
> source trees instead but maybe I was really counting wrong ;).

Don't confuse unslabify and the ->list removal. The ->list removal went
around insisting the known universe stop using ->lru because of the
relatively arbitrary choice that slab.c use ->lru. The unslabify patch
attempts to update one user of ->lru by backing out the code using it.
Do note that non-list-heads like ->index, ->private, or ->mapping are
also unused on slab pages, and could have saved some pain for this
former user of ->list had they been chosen.


-- wli
