Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287367AbSACQQ6>; Thu, 3 Jan 2002 11:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287371AbSACQQt>; Thu, 3 Jan 2002 11:16:49 -0500
Received: from dsl-213-023-043-254.arcor-ip.net ([213.23.43.254]:59661 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287367AbSACQQc>;
	Thu, 3 Jan 2002 11:16:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Christoph Hellwig <hch@ns.caldera.de>
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Thu, 3 Jan 2002 17:20:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <200201031545.g03Fjtj11546@ns.caldera.de>
In-Reply-To: <200201031545.g03Fjtj11546@ns.caldera.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MAbL-00018W-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 04:45 pm, Christoph Hellwig wrote:
> In article <E16M7Gz-00015E-00@starship.berlin> you wrote:
> > -	inode = get_empty_inode();
> > +	inode = get_empty_inode(sb);
> 
> How about killing get_empty_inode completly and using new_inode() instead?
> There should be no regularly allocated inode without a superblock.

There are: sock_alloc rd_load_image.  However that's a nit because the new, 
improved get_empty_inode understands the concept of null sb.  (Another thing 
we could do is require every inode to have a superblock - that's probably 
where it will go in time.)

We put this inside get_empty_inode:

	if (inode) {
		inode->i_dev = sb->s_dev;
		inode->i_blkbits = sb->s_blocksize_bits;
	}

then rename it new_inode.  But this is outside of the scope of the fs.h work 
I'm doing, don't you think?  There are a lot of things I'd like to clean up 
on the way through this, but it's probably best to just resist the temptation 
for now.

--
Daniel
