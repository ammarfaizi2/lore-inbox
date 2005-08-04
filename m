Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVHDVRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVHDVRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVHDVQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:16:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:1243 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262707AbVHDVOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:14:48 -0400
Date: Thu, 4 Aug 2005 23:14:45 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: NUMA policy interface
Message-ID: <20050804211445.GE8266@wotan.suse.de>
References: <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net> <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net> <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net> <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net> <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508041011590.7314@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. BIND policy implemented in a way that fills up nodes from the lowest 
>    to the higest instead of allocating memory on the local node.

Hmm, there was a patch from PJ for that at some point. Not sure why it 
was not merged. iirc the first implementation was too complex, but
there was a second reasonable one.

> 
> 2. No separation between sys_ and do_ functions. Therefore difficult
>    to use from kernel context.

set_fs(KERNEL_DS)
Some policies can be even set without that.

There are already kernel users BTW that prove you wrong.


> 3. Functions have weird side effect (f.e. get_nodes updating 
>    and using cpuset policies). Code is therefore difficult 
>    to maintain.

Agreed that should be cleaned up.

> 4. Uses bitmaps instead of nodemask_t.

Should be easy to fix if someone is motivated.  When I wrote the code
nodemask_t didn't exist yet, and when it was merged it wasn't 
converted over. Not a big deal.

> 
> 5. No means to figure out where the memory was allocated although
>    mempoliy.c implements scans over ptes that would allow that 
>    determination.

You lost me here.

>  
> 6. Needs hook into page migration layer to move pages to either conform
>    to policy or to move them menually.

Does it really? So far my feedback from all users I talked to is that they only
use a small subset of the functionality, even what is there is too complex.
Nobody with a real app so far has asked me for page migration.

There was one implementation of simple page migration in Steve L.'s patches,
but that was just because it was too hard to handle one corner case
otherwise.


> The long term impact of this missing functionality is already showing 
> in the numbers of workarounds that I have seen at a various sites, 

Examples? 

-Andi

