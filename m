Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293186AbSCEGpa>; Tue, 5 Mar 2002 01:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293614AbSCEGpV>; Tue, 5 Mar 2002 01:45:21 -0500
Received: from [208.29.163.248] ([208.29.163.248]:26844 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S293186AbSCEGpK>; Tue, 5 Mar 2002 01:45:10 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 4 Mar 2002 22:45:00 -0800 (PST)
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <794671086.1015277905@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44.0203042243520.8696-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1G x86 machines are becoming fairly common and they either need to waste
ram or turn on himem.

David Lang

On Mon, 4 Mar 2002, Martin J. Bligh wrote:

> > They're not in my tree and for very good reasons, Ben did such mistake
> > the first time at some point during 2.3. You've a big downside with the
> > per-zone information, all normal machines (like with 64M of ram or 2G of
> > ram) where theorical O(N) complexity is perfectly fine for lowmem
> > dma/normal allocations, will get hurted very much by the per-node lrus.
>
> I'm not sure why it has to be a big impact for the "common desktop"
> machine - they should only have one zone anyway. ZONE_DMA should
> shrivel up and die in a lonely corner. Yeah, OK, keep it as a
> back-compatibility option for those museum pieces that need it,
> but personally I'd make ISA DMA support a config option defaulting
> to off ... maybe it's possible to do dynamically (just stick no
> pages in it, though I suspect it's too late by the time we know).
> Hardly any common desktop will need HIGHMEM support, and those
> that do will probably get enough kickback from per-zone things to
> pay for the cost.
>
> To me, per-node would probably be about as good, but I don't think
> per-zone is as bad as you think.
>
> > making it a per-lru spinlock is natural scalability optimization,
> > but anyways pagemap_lru_lock isn't a very critical spinlock.
>
> see my other email - it's worse in rmap.
>
> M.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
