Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVLaJlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVLaJlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLaJlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:41:10 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.25]:28230 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S932114AbVLaJlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:41:09 -0500
Subject: Re: [PATCH 14/14] page-replace-kswapd-incmin.patch
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
In-Reply-To: <20051231011507.GC4913@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
	 <20051230224212.765.38527.sendpatchset@twins.localnet>
	 <20051231011507.GC4913@dmt.cnet>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 10:40:40 +0100
Message-Id: <1136022040.17853.11.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 23:15 -0200, Marcelo Tosatti wrote:
> On Fri, Dec 30, 2005 at 11:42:34PM +0100, Peter Zijlstra wrote:
> > 
> > From: Nick Piggin <npiggin@suse.de>
> > 
> > Explicitly teach kswapd about the incremental min logic instead of just scanning
> > all zones under the first low zone. This should keep more even pressure applied
> > on the zones.
> > 
> > The new shrink_zone() logic exposes the very worst side of the current
> > balance_pgdat() function. Without this patch reclaim is limited to ZONE_DMA.
> 
> Can you please describe the issue with over protection of DMA zone you experienced?
> 
> I'll see if I can reproduce it with Nick's standalone patch on top of vanilla, what
> load was that?

With the mdb bench the following behaviour was observed:
(mem=128M)

- PageCache would fill zone_normal
- PageCache would fill zone_dma
- reclaim starts
- initially things look right
- after a while zone_dma is reclaimed so fast that it frequently gets a
full eviction (nr_resident == 0).
- from this point onward zone_normal practiaclly sits idle and zone_dma
goes wild with all the action.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

