Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWIUBYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWIUBYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWIUBYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:24:48 -0400
Received: from dvhart.com ([64.146.134.43]:37607 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750924AbWIUBYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:24:48 -0400
Message-ID: <4511E9AC.2050507@mbligh.org>
Date: Wed, 20 Sep 2006 18:23:56 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: ZONE_DMA
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org> <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org> <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Martin J. Bligh wrote:
> 
>> Having something that's used in generic code that means random
>> things on different arches just seems like a recipe for disaster
>> to me.
> 
> ZONE_DMA is only used as ZONE_NORMAL if the architecture does not 
> need ZONE_NORMAL because all of memory is reachable via DMA.

That's still inconsistent because it doesn't say DMA for *which*
device.

>> OK ... but requesting ZONE_DMA means what? DMAable for which device?
>> Is it always a floppy disk? on some platforms a PCI card? And how
>> is the VM meant to know what the device is capable of anyway?
> 
> I already explained that twice to you.

We seem to be miscommunicating ... you did indeed give a technically
correct definition. But in practice, AFAICS, it's useless. The requestor
has no idea what the arch has implemented, if it's a driver from
arch-independent code.

> I think we all agree that the situation could be better.

Indeed, that would seem to cause little dispute.

>> Having an arch-specific definition of the limit is arbitrary and
>> useless, is it not? The limit is imposed by the device and its
>> driver, we're not communicating it into any sensible way into the
>> VM code, AFAICS. Unless we're pretending we never call it from
>> generic code, which seems woefully unlikely to me.
> 
> Its bad but its not useless. See how various arches use it.
> 
>> Are we redefining ZONE_DMA to always be 16MB limit across all
>> architectures? At least that'd be consistent.
> 
> That wont work because many architectures use different limits. Maybe you 
> should once in a while have a look at the sources.

I'm perfectly well aware that it's inconsistent, that's my whole point.
However, by some chance of history, it's sort of vaguely working. I
think it's dangerous to mess with it rather than fixing it properly.

AFAICS, the correct way to do this is have the requestor pass a memory
bound into the allocator, and have the arch figure out which zones
are applicable.

> Actually the desaster is cleaned up by this patch. A couple of 
> architectures that were wrongly using ZONE_DMA now use ZONE_NORMAL.

Odd that the PPC64 maintainers didn't seem to know about this.
Perhaps it might be a good idea to talk to them before doing this?

M.

