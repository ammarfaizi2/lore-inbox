Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWBTXRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWBTXRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWBTXRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:17:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38589 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932215AbWBTXRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:17:04 -0500
Date: Tue, 21 Feb 2006 10:16:38 +1100
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, jeremy@sgi.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060221101638.A9468044@wobbly.melbourne.sgi.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060221085953.H9484650@wobbly.melbourne.sgi.com> <1140476772.22756.28.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1140476772.22756.28.camel@dyn9047017100.beaverton.ibm.com>; from pbadari@us.ibm.com on Mon, Feb 20, 2006 at 03:06:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 03:06:11PM -0800, Badari Pulavarty wrote:
> On Tue, 2006-02-21 at 08:59 +1100, Nathan Scott wrote:
> ...
> > I wonder if this change will end up ruining things for the lunatic
> > fringe issuing these kinds of IOs?  Maybe the get_block call could
> > take a block count rather than a byte count?  
> 
> Yes. I thought about it too.. I wanted to pass "block count" instead
> of "byte count". Right now it does ..
> 
> 	bh->b_size = 1 << inode->i_blkbits;
> 	call get_block();
> 
> First thing get_block() does is
> 	blocks = bh->b_size >> inode->i_blkbits;
> 
> All, the unnecessary shifting around for nothing :(

Yeah, pretty silly really, but theres not much choice if the
goal is to keep this simple.  Oh well.

> But, I ended up doing "byte count" just to avoid confusion of
> asking in "blocks" getting back in "bytes".

Understood.

> I have no problem making b_size as "size_t" to handle 64-bit.
> But again, if we are fiddling with buffer_head - may be its time
> to look at alternative to "buffer_head" with the information exactly 
> we need for getblock() ?

That is a much bigger change - I'm not in a position to make the
call on whether thats in everyones best interests.  However, I do
want to make sure we don't regress anything, so I guess the u32
to size_t switch probably should be made to resolve this issue.

Thanks again for following up on this.

cheers.

-- 
Nathan
