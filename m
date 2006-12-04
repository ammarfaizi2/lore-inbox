Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966387AbWLDUGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966387AbWLDUGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966389AbWLDUGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:06:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37383 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966387AbWLDUGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:06:25 -0500
Date: Mon, 4 Dec 2006 12:06:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
Message-Id: <20061204120611.4306024e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie>
	<20061130173129.4ebccaa2.akpm@osdl.org>
	<Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
	<20061201110103.08d0cf3d.akpm@osdl.org>
	<20061204140747.GA21662@skynet.ie>
	<20061204113051.4e90b249.akpm@osdl.org>
	<Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 11:41:42 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> > That depends on how we do hot-unplug, if we do it.  I continue to suspect
> > that it'll be done via memory zones: effectively by resurrecting
> > GFP_HIGHMEM.  In which case there's little overlap with anti-frag.  (btw, I
> > have a suspicion that the most important application of memory hot-unplug
> > will be power management: destructively turning off DIMMs).
> 
> There are numerous other uses as well (besides DIMM and node unplug):
> 
> 1. Faulty DIMM isolation
> 2. Virtual memory managers can reduce memory without resorting to 
>    balloons.
> 3. Physical removal and exchange of memory while a system is running
>    (Likely necessary to complement hotplug cpu, cpus usually come
>    with memory).
> 
> The multi zone approach does not work with NUMA. NUMA only supports a 
> single zone for memory policy control etc.

Wot?  memory policies are a per-vma thing?

Plus NUMA of course supports more that a single zone.  Perhaps you meant
one zone per node.  If you did, that's a pretty dumb-sounding restriction
and I don't know where you got it from.

> Also multiple zones carry with 
> it a management overhead that is unnecessary for the MOVABLE/UNMOVABLE
> distinction.

I suspect you'll have to live with that.  I've yet to see a vaguely sane
proposal to otherwise prevent unreclaimable, unmoveable kernel allocations
from landing in a hot-unpluggable physical memory region.
