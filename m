Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUJRR3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUJRR3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUJRR3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:29:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:2720 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266749AbUJRR3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:29:13 -0400
Date: Mon, 18 Oct 2004 19:21:22 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Andi Kleen <ak@suse.de>,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 4level page tables for Linux
Message-ID: <20041018172122.GD1945@verdi.suse.de>
References: <20041012135919.GB20992@wotan.suse.de> <1097606902.10652.203.camel@localhost> <20041013184153.GO17849@dualathlon.random> <20041013213558.43b3236c.ak@suse.de> <20041013200414.GP17849@dualathlon.random> <Pine.LNX.4.58.0410180957500.9916@server.graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410180957500.9916@server.graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 10:02:20AM -0700, Christoph Lameter wrote:
> On Wed, 13 Oct 2004, Andrea Arcangeli wrote:
> 
> > On Wed, Oct 13, 2004 at 09:35:58PM +0200, Andi Kleen wrote:
> > > page mapping level 4 (?) just guessing here.
> >
> > make sense.
> >
> > > PML4 is the name AMD and Intel use in their documentation. I don't see
> > > a particular reason to be different from them.
> >
> > just because we never say 'page mapping level 4', we think 'page table
> > level 4' or 'page directory level 4'.
> 
> Would it not be best to give up hardcoding these page mapping levels into
> the kernel? Linux should support N levels. pml4,pgd,pmd,pte needs to

It already does. Currently it supports 2-3 levels, with my patch
it supports 2-4 levels.

> disappear and be replaced by
> 
> pte_path[N]
> 
> We are duplicating code for pgd, pmd, pte and now pml again and again. The
> code could be much simpler if this would be generalized. Various

For most people it is already generalized (get_user_pages).
The only exception is the core VM and the low level architecture code.
The later will need to deal always with the details.


> architectures would support different levels without some strange
> feature like f.e. pmd's being "optimized away".

Nobody came up with a nice automatic iterator so far.

If you look at the different functions in mm/* who handle all level 
they all do slightly different things so it's not that easy to 
generalize. Also it is not that many, perhaps seven in mm/* plus 
another in the arch code.

> Certainly the way that pml4 is proposed to be done is less invasive but we
> are creating something more and more difficult to maintain.

I don't see us switching to more levels any time soon ...

Also I don't think it's that bad as you're claiming it is. It's a clear
abstraction which has served us well so far.

-Andi

