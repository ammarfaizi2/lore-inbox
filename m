Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbULXQXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbULXQXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 11:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULXQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 11:23:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261235AbULXQXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 11:23:05 -0500
Date: Fri, 24 Dec 2004 11:22:54 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
In-Reply-To: <20041224160136.GG4459@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
 <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
 <20041224160136.GG4459@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004, Andrea Arcangeli wrote:

> So I recommend you to try again with at least "Andrew's
> ignore-swap-token, Andrew's total_scanned, Con's disable-swap-token and
> my lowmem_reserve". Effectively disable-swap-token obsoletes
> ignore-swap-token, but both makes sense together since just in case
> somebody enables the feature, ignore-swap-token will give it a chance
> not to generate a suprious oom kills.

That makes little sense, since 99% of lowmem is in the page
cache and not mapped into any process, so the swap token
won't get involved at all.  Same for the lowmem_reserve patch,
since the pagecache allocations for dding to a block device
do not use __GFP_HIGHMEM, so the lowmem_reserve protection of
low memory won't be activated.

I am already running with akpm's total_scanned, my lowering of
the dirty limit for non-highmem capable mappings and my "do not
OOM kill if we had to skip writes due to congestion" patch.

The system can still be made to OOM kill, it just takes a day
instead of a few minutes.  And no, the process text, data and
libraries all live in highmem, which isn't scanned by the VM
because there's still 2.7GB free...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
