Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUFXPt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUFXPt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUFXPtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:49:15 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:29548 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265763AbUFXPtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:49:00 -0400
Message-ID: <40DAF7DF.9020501@yahoo.com.au>
Date: Fri, 25 Jun 2004 01:48:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Takashi Iwai <tiwai@suse.de>, Andi Kleen <ak@suse.de>, ak@muc.de,
       tripperda@nvidia.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
References: <m3acyu6pwd.fsf@averell.firstfloor.org> <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random>
In-Reply-To: <20040624152946.GK30687@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> 
> why does it fail? note that with the lower_zone_reserve_ratio algorithm I
> added to 2.4 all dma zone will be reserved for __GFP_DMA allocations so
> you should have troubles only with 2.6, 2.4 should work fine.
> 
> So with latest 2.4 it has to fail only if you already allocated 16M with
> pci_alloc_consistent which sounds unlikely.
> 
> the fact 2.6 lacks the lower_zone_reserve_ratio algorithm is a different
> issue, but I'm confortable there's no other possible algorithm to solve
> this memory balancing problem completely so there's no way around a
> forward port.
> 
> well 2.6 has a tiny hack like some older 2.4 that attempts to do what
> lower_zone_reserve_ratio does, but it's not nearly enough, there's no
> per-zone-point-of-view watermark in 2.6 etc.. 2.6 actually has a more
> hardcoded hack for highmem, but the lower_zone_reserve_ratio has
> absolutely nothing to do with highmem vs lowmem. it's by pure
> coincidence that it avoids highmem machine to lockup without swap, but
> the very same problem happens on x86-64 with lowmem vs dma.

2.6 has the "incremental min" thing. What is wrong with that?
Though I think it is turned off by default.
