Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVLFPip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVLFPip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVLFPip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:38:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:49283 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750759AbVLFPin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:38:43 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Arch specific zone reclaim framework
References: <20051205190104.12037.69672.sendpatchset@schroedinger.engr.sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Dec 2005 13:08:40 -0700
In-Reply-To: <20051205190104.12037.69672.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <p73lkyyq987.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:

> Generic framework for arch specific zone reclaim.
> 
> Zone reclaim allows the reclaiming of pages from a zone if the number of free
> pages falls below the watermark even if other zones still have enough pages
> available.
> 
> Zone reclaim is of particular importance for NUMA machines. It can be more
> beneficial to reclaim a page than taking the performance penalties that come
> with allocating a page on a remote zone. Maybe this will also be useful
> to implement reclaim for DMA zones in some architectures.
> 
> The penalty incurred by remote page accesses varies depending on the NUMA
> factor of the archictecture. If the NUMA factor is very low (architectures
> that have multiple nodes on the same motherboard like for example Opteron
> multi-processor boards) then no page reclaim may be needed since access to
> another nodes memory is almost as fast as a direct access.
> On Itanium architectures and other bus based NUMA architectures a remote
> access usually means that the access has to occur over some sort of NUMA
> interlink. It is worth to sacrifice easily reclaimable pages in order to
> allow a local allocation. Typically there are large number of easily reclaimable
> page available if a scan over some files has just been done or if an application
> has just terminated that mmapped many files.
> 
> Other architectures (especially software NUMA like VirtualIron) may have
> higher NUMA factors and consequently it may be beneficial to do even more
> cleaning of the local zone before going off-node for those.

I think it's a very very bad idea to have architecture specific
functions for such generic VM tasks. I'm all for fixing this
particular problem, but do it in generic code, possible
with an ifdef and some arch settable parameters. But no
architecture specific VM code please. Going down that path     
would cause long term maintenance headaches.

I suppose this particular problem could be just handled by
just checking node_distance()

-Andi
