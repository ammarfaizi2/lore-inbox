Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUDNEBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUDNEBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:01:14 -0400
Received: from waste.org ([209.173.204.2]:36739 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263628AbUDNEBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:01:12 -0400
Date: Tue, 13 Apr 2004 23:01:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: alex@clusterfs.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] extents,delayed allocation,mballoc for ext3
Message-ID: <20040414040101.GO1175@waste.org>
References: <m365c3pthi.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m365c3pthi.fsf@bzzz.home.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 11:28:57PM +0400, alex@clusterfs.com wrote:
> 
> these patches implement several features for ext3:
> - extents
> - multiblock allocator
> - delayed allocation (a.k.a. allocation on flush)
> 
> 
> extents
> =======
> it's just a way to store inode's blockmap in well-known triples
> [logical block; phys. block; length]. all the extents are stored
> in B+Tree. code is splitted in two parts:
> 1) generic extents support
>    implements primitives like lookup, insert, remove, walk
> 2) VFS part
>    implements ->getblock() and ->truncate() methods

I'm going to assume that there's no way for ext3 without extents
support to mount such a filesystem, so I think this means changing the
FS name. Is there a simple migration path to extents for existing filesystems?
 
> multiblock allocator
> ===================
> the larger extents the better. the reasonable way is to ask block
> allocator to allocate several blocks at once. it is possible to
> scan bitmaps, but such a scanning isn't very good method. so, here
> is mballoc - buddy algorithm + possibility to find contig.buddies
> fast way. mballoc is backward-compatible, buddies are stored on a
> disk as usual file (temporal solution until fsck support is ready)
> and regenerated at mount time. also, with existing block-at-once
> allocator it's impossible to write at very high rate (several
> hundreds MB a sec). multiblock allocator solves this issue.

Similar questions here.
 
> NOTE: don't try to use it in production. all the patches (probably
> excluding extents) are pre-pre-alpha. because of size I put patches
> in ftp://ftp.clusterfs.com/pub/people/alex/2.6.4-mm2/

You might also mention that on-disk format issues such as endian
layout are not finalized.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
