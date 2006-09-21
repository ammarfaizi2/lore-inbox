Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWIUBKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWIUBKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWIUBKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:10:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52125 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750911AbWIUBKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:10:38 -0400
Date: Wed, 20 Sep 2006 18:10:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: ZONE_DMA
In-Reply-To: <4511E1CA.6090403@mbligh.org>
Message-ID: <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org>
 <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Martin J. Bligh wrote:

> Having something that's used in generic code that means random
> things on different arches just seems like a recipe for disaster
> to me.

ZONE_DMA is only used as ZONE_NORMAL if the architecture does not 
need ZONE_NORMAL because all of memory is reachable via DMA.

> OK ... but requesting ZONE_DMA means what? DMAable for which device?
> Is it always a floppy disk? on some platforms a PCI card? And how
> is the VM meant to know what the device is capable of anyway?

I already explained that twice to you. I think we all agree that the 
situation could be better.

> Having an arch-specific definition of the limit is arbitrary and
> useless, is it not? The limit is imposed by the device and its
> driver, we're not communicating it into any sensible way into the
> VM code, AFAICS. Unless we're pretending we never call it from
> generic code, which seems woefully unlikely to me.

Its bad but its not useless. See how various arches use it.

> Are we redefining ZONE_DMA to always be 16MB limit across all
> architectures? At least that'd be consistent.

That wont work because many architectures use different limits. Maybe you 
should once in a while have a look at the sources.

The patchset leaves the semantics of ZONE_DMA as memory beyond 
MAX_DMA_ADDRESS as is. Nothing should break. It only allows us to opt out 
of this scheme if we do not need it.

