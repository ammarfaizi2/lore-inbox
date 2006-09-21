Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWIUAvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWIUAvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWIUAvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:51:11 -0400
Received: from dvhart.com ([64.146.134.43]:34535 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750884AbWIUAvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:51:10 -0400
Message-ID: <4511E1CA.6090403@mbligh.org>
Date: Wed, 20 Sep 2006 17:50:18 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: ZONE_DMA
References: <20060920135438.d7dd362b.akpm@osdl.org>	<4511D855.7050100@mbligh.org> <20060920172253.f6d11445.akpm@osdl.org>
In-Reply-To: <20060920172253.f6d11445.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> (Subject rewritten, developer cc'ed, thwap delivered)
> 
> On Wed, 20 Sep 2006 17:09:57 -0700
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
>>> introduce-config_zone_dma.patch
>>> optional-zone_dma-in-the-vm.patch
>>> optional-zone_dma-in-the-vm-tidy.patch
>>> optional-zone_dma-for-i386.patch
>>> optional-zone_dma-for-x86_64.patch
>>> optional-zone_dma-for-ia64.patch
>>> remove-zone_dma-remains-from-parisc.patch
>>> remove-zone_dma-remains-from-sh-sh64.patch
>> Would it not make sense to define what ZONE_DMA actually means
>> consistently before trying to change it? The current mess across
>> different architectures seems like a disaster area to me.
>>
>> What DOES requesting ZONE_DMA from a driver actually mean?
>>
> 
> AFAIK it means "floppy disks" ;)

That's the problem - it doesn't mean that at all, except on ia32.
It means totally different things on different architectures. IIRC,
on PPC64, it's all of memory.

Having something that's used in generic code that means random
things on different arches just seems like a recipe for disaster
to me.

> My concern about these patches is that they'll only be useful for
> self-compiled kernels, because distros will be forced to enable ZONE_DMA
> for evermore anyway.
> 
> If that's correct then perhaps we should drop these patches, because they
> will serve to weaken ongoing testing.

Well, I think we actually need to define what it means before we
mess with it any more. It's not Christoph's fault that it's broken.
But messing with something that's pretty much undefined will likely
have undefined consequences.

Christoph Lameter wrote:
 > Actually the desaster is cleaned up by this patch. A couple of
 > architectures that were wrongly using ZONE_DMA now use ZONE_NORMAL.

OK ... but requesting ZONE_DMA means what? DMAable for which device?
Is it always a floppy disk? on some platforms a PCI card? And how
is the VM meant to know what the device is capable of anyway?

Having an arch-specific definition of the limit is arbitrary and
useless, is it not? The limit is imposed by the device and its
driver, we're not communicating it into any sensible way into the
VM code, AFAICS. Unless we're pretending we never call it from
generic code, which seems woefully unlikely to me.

Are we redefining ZONE_DMA to always be 16MB limit across all
architectures? At least that'd be consistent.

M.
