Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbUBZUBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUBZUBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:01:23 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:25485 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262835AbUBZUBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:01:21 -0500
Date: Thu, 26 Feb 2004 17:43:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 - large inode_cache
In-Reply-To: <20040226174338.GP1257@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.58L.0402261742090.8840@logos.cnet>
References: <20040226013313.GN29776@unthought.net> <20040226111912.GB4554@core.home>
 <Pine.LNX.4.58L.0402261004310.5003@logos.cnet> <20040226130344.GP29776@unthought.net>
 <Pine.LNX.4.58L.0402261109190.5003@logos.cnet> <20040226174338.GP1257@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Andreas Dilger wrote:

> On Feb 26, 2004  11:23 -0300, Marcelo Tosatti wrote:
> > On Thu, 26 Feb 2004, Jakob Oestergaard wrote:
> > > On Thu, Feb 26, 2004 at 10:08:23AM -0300, Marcelo Tosatti wrote:
> > > > This should be normal behaviour -- the i/d caches grew because of file
> > > > system activitity. This memory will be reclaimed in case theres pressure.
> > >
> > > But how is "pressure" defined?
> > >
> > > Will a heap of busy knfsd processes doing reads or writes exert
> > > pressure?   Or is it only local userspace that can pressurize the VM (by
> > > either anonymously backed memory or file I/O).
> >
> > Any allocator will cause VM pressure.
>
> But won't all of the knfsd allocations be by necessity GFP_NOFS to avoid
> deadlocks, so they will be unable to clear inodes or dentries?  Both
> shrink_icache_memory() and shrink_dcache_memory() do nothing if __GFP_FS
> isn't set so if there is no user-space allocation pressure we will never
> get into the dcache/icache freeing paths from knfsd allocations.

Hi Andreas,

AFAICS knfsd does not allocate using GFP_NOFS.



