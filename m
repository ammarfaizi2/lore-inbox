Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUBZRnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUBZRnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:43:47 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:36254 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262896AbUBZRnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:43:43 -0500
Date: Thu, 26 Feb 2004 10:43:38 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 - large inode_cache
Message-ID: <20040226174338.GP1257@schnapps.adilger.int>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
References: <20040226013313.GN29776@unthought.net> <20040226111912.GB4554@core.home> <Pine.LNX.4.58L.0402261004310.5003@logos.cnet> <20040226130344.GP29776@unthought.net> <Pine.LNX.4.58L.0402261109190.5003@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402261109190.5003@logos.cnet>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2004  11:23 -0300, Marcelo Tosatti wrote:
> On Thu, 26 Feb 2004, Jakob Oestergaard wrote:
> > On Thu, Feb 26, 2004 at 10:08:23AM -0300, Marcelo Tosatti wrote:
> > > This should be normal behaviour -- the i/d caches grew because of file
> > > system activitity. This memory will be reclaimed in case theres pressure.
> >
> > But how is "pressure" defined?
> >
> > Will a heap of busy knfsd processes doing reads or writes exert
> > pressure?   Or is it only local userspace that can pressurize the VM (by
> > either anonymously backed memory or file I/O).
> 
> Any allocator will cause VM pressure.

But won't all of the knfsd allocations be by necessity GFP_NOFS to avoid
deadlocks, so they will be unable to clear inodes or dentries?  Both
shrink_icache_memory() and shrink_dcache_memory() do nothing if __GFP_FS
isn't set so if there is no user-space allocation pressure we will never
get into the dcache/icache freeing paths from knfsd allocations.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

