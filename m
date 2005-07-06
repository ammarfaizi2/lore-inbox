Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVGGAX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVGGAX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVGFUE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:04:58 -0400
Received: from graphe.net ([209.204.138.32]:8894 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262145AbVGFSBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:01:19 -0400
Date: Wed, 6 Jul 2005 11:01:14 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
In-Reply-To: <20050706175603.GL21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507061058260.30702@graphe.net>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net>
 <20050706175603.GL21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> On Wed, Jul 06, 2005 at 09:35:32AM -0700, Christoph Lameter wrote:
> > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > 
> > > Instead of adding messy kmalloc_node()s everywhere run the 
> > > PCI driver probe on the node local to the device.
> > > Then the normal NUMA aware allocators do the right thing.
> > 
> > That depends on the architecture. Some do round robin allocs for periods 
> > of time during bootup. I think it is better to explicitly place control 
> 
> slab will usually do the right thing because it has a forced
> local node policy, but __gfp might not.

GFP allocs may not do the right thing. If you want to do this then it 
may be best to set the memory policy to restrict allocations to the node 
on which the device resides.

Plus there are CPU less nodes. What happens to those?

> Patching every driver in existence? That sounds like a lot of
> work. 

No just patch those that would benefit from it. The existing 
dma_alloc_coherent already takes care of many of the placement 
issues for driver memory. We would probably need to patch more locations 
where higher level control structure allocations are being done.

> The node local placement should be correct for nearly all drivers. I didn't 
> see any other fancy placement in your patches. If a driver still wants to do 
> fancy placement it is free to overwrite the policy. Having a good
> default is good.

Definitely.
