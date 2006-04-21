Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWDULvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWDULvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDULvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:51:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:10982 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751289AbWDULvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:51:05 -0400
Date: Fri, 21 Apr 2006 13:51:01 +0200
From: Nick Piggin <npiggin@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Patricia Gaughen <gone@us.ibm.com>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060421115101.GZ21660@wotan.suse.de>
References: <20060419112130.GA22648@elte.hu> <20060420091856.GB21660@wotan.suse.de> <20060421112049.GA5609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421112049.GA5609@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 01:20:50PM +0200, Ingo Molnar wrote:
> 
> * Nick Piggin <npiggin@suse.de> wrote:
> 
> > It would be interesting to know which assertion failed. I guess it 
> > might be a zone alignment problem -- it would be interesting to turn 
> > the 2 HOLES_IN_ZONE tests into BUG_ONs, and enable them (ie. move them 
> > out of HOLES_IN_ZONE).
> 
> ok, i added a couple of printks (see the patch below), and got this:
> 
>  zone c1f0a600 (HighMem):
>  pfn: 00037d00
>  zone->zone_start_pfn: 00037e00
>  zone->spanned_pages: 00007e00
>  zone->zone_start_pfn + zone->spanned_pages: 0003fc00
>  ------------[ cut here ]------------
>  kernel BUG at mm/page_alloc.c:524!
> 
> so the pfn is 1MB below the zone's start address - not good. You can 
> find the full bootup log at:

The zones are 2MB aligned, discontig.c seems to do this. They should
be 4MB aligned so the page allocator's assumption that zones are 
contiguous to MAX_ORDER is satisfied.

