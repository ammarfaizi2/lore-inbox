Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVIWX6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVIWX6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVIWX6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:58:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17811 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751348AbVIWX6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:58:07 -0400
Date: Fri, 23 Sep 2005 16:57:29 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alok Kataria <alokk@calsoftinc.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <433458B6.7000008@calsoftinc.com>
Message-ID: <Pine.LNX.4.62.0509231648090.25804@schroedinger.engr.sgi.com>
References: <433458B6.7000008@calsoftinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Alok Kataria wrote:

> But the nodeid is already accessible through the slab-descriptor of this
> object, and this nodeid is set in the cache_grow
> function.

Correct. We still have no explanation why the slab was later assigned to 
the wrong node. The patch fixes the locking issue though because the wrong 
nodeid field is now ignored. There is certianly more to fix here.

> > /Also removes the check for the current node from kmalloc_cache_node since
> > the
> > process may shift later to another node which may lead to an allocation on
> > another
> > node than intended.
> > /
> > 
> Yeah that is possible, but won't putting a check in __cache_alloc_node after
> disabling the interrupt be better, because kmalloc_node/kmem_cache_alloc_node
> can be called at runtime as well, and getting the object directly from the
> slabs, instead of the arraycaches may slow up things.
> Thus tweaking the patch a little.

Good

