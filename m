Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288271AbSACRXB>; Thu, 3 Jan 2002 12:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288272AbSACRWv>; Thu, 3 Jan 2002 12:22:51 -0500
Received: from dsl-213-023-043-223.arcor-ip.net ([213.23.43.223]:31758 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288271AbSACRWf>;
	Thu, 3 Jan 2002 12:22:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Thu, 3 Jan 2002 18:25:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Christoph Hellwig <hch@ns.caldera.de>, acme@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201031145210.23312-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201031145210.23312-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MBch-000194-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 05:47 pm, Alexander Viro wrote:
> On Thu, 3 Jan 2002, Daniel Phillips wrote:
> > On January 3, 2002 04:45 pm, Christoph Hellwig wrote:
> > > In article <E16M7Gz-00015E-00@starship.berlin> you wrote:
> > > > -	inode = get_empty_inode();
> > > > +	inode = get_empty_inode(sb);
> > > 
> > > How about killing get_empty_inode completly and using new_inode() instead?
> > > There should be no regularly allocated inode without a superblock.
> > 
> > There are: sock_alloc rd_load_image.  However that's a nit because the new, 
> > improved get_empty_inode understands the concept of null sb.  (Another thing 
> > we could do is require every inode to have a superblock - that's probably 
> > where it will go in time.)
> 
> It's _already_ there.  RTFS, please - sock_alloc() creates inodes with
> sockfs superblock in ->i_sb and rd_load_image() just does normal open()
> for device nodes on rootfs.

Sockfs - yes, you'll see my patch already does it correctly, I was getting
a little tired when writing the previous reply... rd_load_image in 2.4.17 is
still using kdev_t there, however, no super_block anywhere to be seen.  I'll
track that change if it happens before I bring the patches forward to 2.5.

--
Daniel
