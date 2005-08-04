Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVHDVVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVHDVVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVHDVVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:21:42 -0400
Received: from graphe.net ([209.204.138.32]:11962 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262710AbVHDVVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:21:14 -0400
Date: Thu, 4 Aug 2005 14:21:09 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: NUMA policy interface
In-Reply-To: <20050804211445.GE8266@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508041416490.10150@graphe.net>
References: <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net>
 <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net>
 <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net>
 <20050804211445.GE8266@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Andi Kleen wrote:

> > 1. BIND policy implemented in a way that fills up nodes from the lowest 
> >    to the higest instead of allocating memory on the local node.
> 
> Hmm, there was a patch from PJ for that at some point. Not sure why it 
> was not merged. iirc the first implementation was too complex, but
> there was a second reasonable one.

Yes he mentioned that patch earlier in this thread.

> > 5. No means to figure out where the memory was allocated although
> >    mempoliy.c implements scans over ptes that would allow that 
> >    determination.
> 
> You lost me here.

There is this scan over the page table that verifies if all nodes are 
allocated according to the policy. That scan could easily be used to 
provide a map to the application (and to /proc/<pid>/smap) of where the
memory was allocated.
 
> > 6. Needs hook into page migration layer to move pages to either conform
> >    to policy or to move them menually.
> 
> Does it really? So far my feedback from all users I talked to is that they only
> use a small subset of the functionality, even what is there is too complex.
> Nobody with a real app so far has asked me for page migration.

Maybe we have different customers. My feedback is consistently that this 
is a very urgently feature needed.
 
> There was one implementation of simple page migration in Steve L.'s patches,
> but that was just because it was too hard to handle one corner case
> otherwise.

There is a page migration implementation in the hotplug patchset.

> > The long term impact of this missing functionality is already showing 
> > in the numbers of workarounds that I have seen at a various sites, 
> 
> Examples? 

Two of the high profile ones are NASA and APA. One person from the APA 
posted in one of our earlier discussions.
