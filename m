Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288280AbSACSgk>; Thu, 3 Jan 2002 13:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287355AbSACSgb>; Thu, 3 Jan 2002 13:36:31 -0500
Received: from ns.caldera.de ([212.34.180.1]:59355 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288277AbSACSgT>;
	Thu, 3 Jan 2002 13:36:19 -0500
Date: Thu, 3 Jan 2002 19:35:38 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020103193537.A13386@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Daniel Phillips <phillips@bonn-fries.net>, acme@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <200201031545.g03Fjtj11546@ns.caldera.de> <E16MAbL-00018W-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16MAbL-00018W-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Jan 03, 2002 at 05:20:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 05:20:12PM +0100, Daniel Phillips wrote:
> On January 3, 2002 04:45 pm, Christoph Hellwig wrote:
> > In article <E16M7Gz-00015E-00@starship.berlin> you wrote:
> > > -	inode = get_empty_inode();
> > > +	inode = get_empty_inode(sb);
> > 
> > How about killing get_empty_inode completly and using new_inode() instead?
> > There should be no regularly allocated inode without a superblock.
> 
> There are: sock_alloc rd_load_image.  However that's a nit because the new, 
> improved get_empty_inode understands the concept of null sb.

get_empty_inode is hopefully going to die in the current, non-static version.

> (Another thing 
> we could do is require every inode to have a superblock - that's probably 
> where it will go in time.)

Any inode that gets into the icache already has and superblock.
If any other are left they really should use a different allocator.

> We put this inside get_empty_inode:
> 
> 	if (inode) {
> 		inode->i_dev = sb->s_dev;
> 		inode->i_blkbits = sb->s_blocksize_bits;
> 	}
> 
> then rename it new_inode.  But this is outside of the scope of the fs.h work 
> I'm doing, don't you think?

Rename your current get_empty_inode to __get_empty_inode and mark it
static.  Add a new get_empty_inode that calls __get_empty_inode(NULL) or
better let it die.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
