Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbULXQk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbULXQk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 11:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULXQk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 11:40:57 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:38016 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261313AbULXQkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 11:40:51 -0500
Date: Fri, 24 Dec 2004 17:40:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20041224164024.GK4459@dualathlon.random>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com> <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 11:22:54AM -0500, Rik van Riel wrote:
> On Fri, 24 Dec 2004, Andrea Arcangeli wrote:
> 
> >So I recommend you to try again with at least "Andrew's
> >ignore-swap-token, Andrew's total_scanned, Con's disable-swap-token and
> >my lowmem_reserve". Effectively disable-swap-token obsoletes
> >ignore-swap-token, but both makes sense together since just in case
> >somebody enables the feature, ignore-swap-token will give it a chance
> >not to generate a suprious oom kills.
> 
> That makes little sense, since 99% of lowmem is in the page
> cache and not mapped into any process, so the swap token
> won't get involved at all.  Same for the lowmem_reserve patch,
> since the pagecache allocations for dding to a block device
> do not use __GFP_HIGHMEM, so the lowmem_reserve protection of
> low memory won't be activated.

Since you provided no debugging output I had to provide you the full
reccomandation. There was no sign that you didn't run out of lowmemory,
I don't know what else is running on the box with the cp.

> I am already running with akpm's total_scanned, my lowering of
> the dirty limit for non-highmem capable mappings and my "do not
> OOM kill if we had to skip writes due to congestion" patch.
> 
> The system can still be made to OOM kill, it just takes a day

Did you apply Con's disable-swap-token leaving the sysctl to the default
value after applying that patch?

Of course I know if you don't apply Con's fix it will run oom, you don't
need a cp for that.
