Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVAXC62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVAXC62 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 21:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVAXC62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 21:58:28 -0500
Received: from waste.org ([216.27.176.166]:36035 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261426AbVAXC6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 21:58:20 -0500
Date: Sun, 23 Jan 2005 18:57:38 -0800
From: Matt Mackall <mpm@selenic.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, Andi Kleen <ak@muc.de>,
       Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050124025738.GX12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de> <20050123042930.GI3867@waste.org> <20050124112129.C1545508@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124112129.C1545508@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 11:21:29AM +1100, Nathan Scott wrote:
> On Sat, Jan 22, 2005 at 08:29:30PM -0800, Matt Mackall wrote:
> > On Sun, Jan 23, 2005 at 03:39:34AM +0100, Andi Kleen wrote:
> > 
> > c) the three-way median selection does help avoid worst-case O(n^2)
> > behavior, which might potentially be triggerable by users in places
> > like XFS where this is used
> 
> XFS's needs are simple - we're just sorting dirents within a
> single directory block or smaller, and sorting EA lists/ACLs -
> all of which are small arrays, so a qsort optimised for small
> arrays suits XFS well. 

Ok, I've worked up a much smaller, cleaner version that wins on lists
of 10000 entries or less and is still within 5% at 1M entries (ie well
past what any kernel code has any business doing). More after I've
fiddled around a bit more with the benchmarks.

> Take care not to put any arrays on the
> stack though, else the CONFIG_4KSTACKS punters won't be happy.

I'm afraid I'm one of those punters - 4k stacks were getting cleaned up and
tested in my -tiny tree long before mainline.

-- 
Mathematics is the supreme nostalgia of our time.
