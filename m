Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292927AbSCEFl4>; Tue, 5 Mar 2002 00:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293608AbSCEFlq>; Tue, 5 Mar 2002 00:41:46 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:40078 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S292927AbSCEFld>; Tue, 5 Mar 2002 00:41:33 -0500
Date: Mon, 04 Mar 2002 21:38:26 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <794671086.1015277905@[10.10.2.3]>
In-Reply-To: <20020305000102.S20606@dualathlon.random>
In-Reply-To: <20020305000102.S20606@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They're not in my tree and for very good reasons, Ben did such mistake
> the first time at some point during 2.3. You've a big downside with the
> per-zone information, all normal machines (like with 64M of ram or 2G of
> ram) where theorical O(N) complexity is perfectly fine for lowmem
> dma/normal allocations, will get hurted very much by the per-node lrus.

I'm not sure why it has to be a big impact for the "common desktop"
machine - they should only have one zone anyway. ZONE_DMA should
shrivel up and die in a lonely corner. Yeah, OK, keep it as a 
back-compatibility option for those museum pieces that need it,
but personally I'd make ISA DMA support a config option defaulting
to off ... maybe it's possible to do dynamically (just stick no
pages in it, though I suspect it's too late by the time we know).
Hardly any common desktop will need HIGHMEM support, and those
that do will probably get enough kickback from per-zone things to
pay for the cost.

To me, per-node would probably be about as good, but I don't think
per-zone is as bad as you think.

> making it a per-lru spinlock is natural scalability optimization,
> but anyways pagemap_lru_lock isn't a very critical spinlock.

see my other email - it's worse in rmap.

M.


