Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWBNAIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWBNAIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBNAIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:08:34 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:27559 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964879AbWBNAIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:08:32 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v25
Date: Tue, 14 Feb 2006 11:09:01 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
References: <200602120141.46084.kernel@kolivas.org> <Pine.LNX.4.62.0602131256000.3026@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602131256000.3026@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141109.01790.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 07:58 am, Christoph Lameter wrote:
> On Sun, 12 Feb 2006, Con Kolivas wrote:
> > Once pages have been added to the swapped list, a timer is started,
> > testing for conditions suitable to prefetch swap pages every 5 seconds.
> > Suitable conditions are defined as lack of swapping out or in any pages,
> > and no watermark tests failing. Significant amounts of dirtied ram and
> > changes in free ram representing disk writes or reads also prevent
> > prefetching.
> >
> > It then checks that we have spare ram looking for at least 3* pages_high
> > free per zone and if it succeeds that will prefetch pages from swap into
> > the swap cache. The pages are added to the tail of the inactive list to
> > preserve LRU ordering.
>
> spare ram when swapping??? We are already under memory pressure. Why make
> it worse by getting rid of the few bits of available memory? If a system
> swaps then we are per definition in the bad performance range. Add more
> memory.

This patch only prefetches the swapped pages when idle and tacks them onto the 
end of the inactive list so they will be the first thing that is removed if 
we need ram in the future.

Ordinary desktops swap under ordinary workloads day to day on normal pcs. It 
is extraordinary common that one workload will swap out other applications 
and then when complete we have free ram, yet our applications are floundering 
on swapspace.

Your solution of add more memory is unrealistic. Desktops do have a limit on 
how much ram we are likely to have/can afford and our workloads have, do, and 
will for ever more outstrip all available ram. A huge chunk of linux in the 
wild is on these sort of desktops. This patch makes a substantial difference 
to ordinary desktops, is configurable on or off and it can be runtime 
enabled/disabled.

Cheers,
Con
