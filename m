Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUB0M2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUB0M2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:28:03 -0500
Received: from unthought.net ([212.97.129.88]:8926 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262614AbUB0M1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:27:16 -0500
Date: Fri, 27 Feb 2004 13:27:14 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 - large inode_cache
Message-ID: <20040227122714.GT29776@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
References: <20040226013313.GN29776@unthought.net> <20040226111912.GB4554@core.home> <Pine.LNX.4.58L.0402261004310.5003@logos.cnet> <20040226130344.GP29776@unthought.net> <Pine.LNX.4.58L.0402261109190.5003@logos.cnet> <20040226174338.GP1257@schnapps.adilger.int> <Pine.LNX.4.58L.0402261742090.8840@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402261742090.8840@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 05:43:49PM -0300, Marcelo Tosatti wrote:
> 
...
> > > Any allocator will cause VM pressure.
> >
> > But won't all of the knfsd allocations be by necessity GFP_NOFS to avoid
> > deadlocks, so they will be unable to clear inodes or dentries?  Both
> > shrink_icache_memory() and shrink_dcache_memory() do nothing if __GFP_FS
> > isn't set so if there is no user-space allocation pressure we will never
> > get into the dcache/icache freeing paths from knfsd allocations.
> 
> Hi Andreas,
> 
> AFAICS knfsd does not allocate using GFP_NOFS.

So far, it looks like the vm_vfs_scan_ratio setting of '3' (instead of
'6' which was the default) made a big difference.

Currently the machine is using about ~600MB for cache (up from ~100MB),
and about 150MB for buffers (up from 80-100MB).

I'm going to let it run a little longer just with this setting, before
experimenting further.

I'll ask around about the perceived performance of the machine, and pay
attention to it myself.  I'll post the results monday or tuesday (not a
lot of interactive users during the weekend  ;)

Again, thanks a lot for the quick feedback!

/ jakob

