Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSAGPba>; Mon, 7 Jan 2002 10:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289235AbSAGPbV>; Mon, 7 Jan 2002 10:31:21 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:12303 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289233AbSAGPbH>;
	Mon, 7 Jan 2002 10:31:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Date: Mon, 7 Jan 2002 16:33:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NbmV-0001R0-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 03:13 pm, Anton Altaparmakov wrote:
> Goodie. Now we need benchmarks for all the approaches... (-;
> 
> At 13:21 07/01/02, Jeff Garzik wrote:
> <snip>
> >patch7: implement ext2 use of s_op->{alloc,destroy}
> >
> >         at this point we have what Linus described:
> >
> >                 struct ext2_inode_info {
> >                         ...ext2 stuff...
> >                         struct inode inode;
> >                 };
> 
> If we were to raise compiler requirements to gcc-2.96 or later this could 
> be simplified with an annonymous struct (having elements in struct inode 
> with the same name as elements in ...ext2 stuff... should be a shooting 
> offence IMO):
> 
>          struct ext2_inode_info {
>                  ...ext2 stuff...
>                  struct inode;
>          };
> 
> Advantage of this would be that as far as the fs is concerned there is only 
> one inode and each element can just be dereferenced straight away without 
> need to think was that the generic inode or the fs inode and without need 
> for keeping two pointers around. This leads to simpler code inside the 
> filesystems once they adapt.

Interesting, it's something I've always wanted to be able to do.  But I
suppose the compiler requirement is a stupport.

> Of course fs which are not adapted would still just work with the fs_i() 
> and fs_sb() macros and/or using two separate pointers.

Yes, the fs_* macros are the really critical part of all this.  I'd like to
get them in early, while we hash out the rest of it.  I think Jeff supports
me in this, possibly Al as well.

--
Daniel
