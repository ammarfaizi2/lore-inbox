Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWIUP6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWIUP6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 11:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWIUP6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 11:58:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7079 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751282AbWIUP6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 11:58:43 -0400
Date: Thu, 21 Sep 2006 08:58:34 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: ZONE_DMA
In-Reply-To: <4511E9AC.2050507@mbligh.org>
Message-ID: <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org>
 <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org>
 <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com>
 <4511E9AC.2050507@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Martin J. Bligh wrote:

> > ZONE_DMA is only used as ZONE_NORMAL if the architecture does not need
> > ZONE_NORMAL because all of memory is reachable via DMA.
> 
> That's still inconsistent because it doesn't say DMA for *which*
> device.

Thats the way ZONE_DMA works right now and AFAIK the only way forward is 
to make it optional and then introduce another way of allocating memory
for a device. The migrate away from it. The first step is to allow people
who do not need ZONE_DMA to opt out.

> > That wont work because many architectures use different limits. Maybe you
> > should once in a while have a look at the sources.
> 
> I'm perfectly well aware that it's inconsistent, that's my whole point.
> However, by some chance of history, it's sort of vaguely working. I
> think it's dangerous to mess with it rather than fixing it properly.

I think you are spreading FUD. The existing scheme has been working for a 
long time. Come up with something concrete. I am not 
changing the definition of ZONE_DMA.

> AFAICS, the correct way to do this is have the requestor pass a memory
> bound into the allocator, and have the arch figure out which zones
> are applicable.

Exactly. But you cannot do that with ZONE_DMA __GFP_DMA. We likely need a 
new page  allocator API for that.

> > Actually the desaster is cleaned up by this patch. A couple of architectures
> > that were wrongly using ZONE_DMA now use ZONE_NORMAL.
> 
> Odd that the PPC64 maintainers didn't seem to know about this.
> Perhaps it might be a good idea to talk to them before doing this?

Maybe they have not been reading linux-arch? It was discussed among arch 
maintainers and 4 arches have switched off ZONE_DMA for good.
