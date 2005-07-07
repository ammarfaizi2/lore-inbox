Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVGGKlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVGGKlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVGGKlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:41:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:1944 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261273AbVGGKjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:39:22 -0400
Date: Thu, 7 Jul 2005 12:39:18 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
Message-ID: <20050707103918.GV21330@wotan.suse.de>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net> <20050706175603.GL21330@wotan.suse.de> <Pine.LNX.4.62.0507061232040.720@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507061232040.720@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 12:33:51PM -0700, Christoph Lameter wrote:
> On Wed, 6 Jul 2005, Andi Kleen wrote:
> 
> > > That depends on the architecture. Some do round robin allocs for periods 
> > > of time during bootup. I think it is better to explicitly place control 
> > 
> > slab will usually do the right thing because it has a forced
> > local node policy, but __gfp might not.
> 
> The slab allocator will do the right thing with the numa slab allocator in 
> Andrew's tree but not with the one in Linus'tree. The one is Linus tree
> will just pickup whatever slab is available irregardless of the node.

It should usually do the right thing because it
runs on the correct CPUs. The only case that doesn't work 
is freeing on different CPUs than it was allocated, but hopefully
that is not too common during system startup.

And then at some point NUMA aware slab will make it into mainline
I guess.

> Only kmalloc_node will make a reasonable attempt to locate the memory on 
> a specific node.

You forgot __get_free_pages.

-Andi
