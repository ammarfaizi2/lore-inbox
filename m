Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVGGARt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVGGARt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVGFUFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:55002 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262454AbVGFSNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:13:50 -0400
Date: Wed, 6 Jul 2005 20:13:49 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
Message-ID: <20050706181349.GN21330@wotan.suse.de>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net> <20050706175603.GL21330@wotan.suse.de> <Pine.LNX.4.62.0507061058260.30702@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507061058260.30702@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 11:01:14AM -0700, Christoph Lameter wrote:
> On Wed, 6 Jul 2005, Andi Kleen wrote:
> 
> > On Wed, Jul 06, 2005 at 09:35:32AM -0700, Christoph Lameter wrote:
> > > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > > 
> > > > Instead of adding messy kmalloc_node()s everywhere run the 
> > > > PCI driver probe on the node local to the device.
> > > > Then the normal NUMA aware allocators do the right thing.
> > > 
> > > That depends on the architecture. Some do round robin allocs for periods 
> > > of time during bootup. I think it is better to explicitly place control 
> > 
> > slab will usually do the right thing because it has a forced
> > local node policy, but __gfp might not.
> 
> GFP allocs may not do the right thing. If you want to do this then it 
> may be best to set the memory policy to restrict allocations to the node 
> on which the device resides.

They will do the right thing. Under memory pressue on the node 
it is better to back off than to fail.

> 
> Plus there are CPU less nodes. What happens to those?

They are not worse off that they are now.

> 
> > Patching every driver in existence? That sounds like a lot of
> > work. 
> 
> No just patch those that would benefit from it. The existing 

This would be "all devices that SGI ships on Altixes" ?

IMHO all can benefit.

-Andi
