Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288250AbSACQs7>; Thu, 3 Jan 2002 11:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288251AbSACQsz>; Thu, 3 Jan 2002 11:48:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2224 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288250AbSACQsA>;
	Thu, 3 Jan 2002 11:48:00 -0500
Date: Thu, 3 Jan 2002 11:47:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Christoph Hellwig <hch@ns.caldera.de>, acme@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
In-Reply-To: <E16MAbL-00018W-00@starship.berlin>
Message-ID: <Pine.GSO.4.21.0201031145210.23312-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Daniel Phillips wrote:

> On January 3, 2002 04:45 pm, Christoph Hellwig wrote:
> > In article <E16M7Gz-00015E-00@starship.berlin> you wrote:
> > > -	inode = get_empty_inode();
> > > +	inode = get_empty_inode(sb);
> > 
> > How about killing get_empty_inode completly and using new_inode() instead?
> > There should be no regularly allocated inode without a superblock.
> 
> There are: sock_alloc rd_load_image.  However that's a nit because the new, 
> improved get_empty_inode understands the concept of null sb.  (Another thing 
> we could do is require every inode to have a superblock - that's probably 
> where it will go in time.)

It's _already_ there.  RTFS, please - sock_alloc() creates inodes with
sockfs superblock in ->i_sb and rd_load_image() just does normal open()
for device nodes on rootfs.

Please, don't reintroduce the crap we'd already killed.

