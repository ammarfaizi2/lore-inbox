Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSAGP72>; Mon, 7 Jan 2002 10:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289241AbSAGP7X>; Mon, 7 Jan 2002 10:59:23 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:57229 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S289239AbSAGP7L>; Mon, 7 Jan 2002 10:59:11 -0500
Message-Id: <5.1.0.14.2.20020107155722.02e87820@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Jan 2002 16:01:33 +0000
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <E16NbmV-0001R0-00@starship.berlin>
In-Reply-To: <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:33 07/01/02, Daniel Phillips wrote:
>On January 7, 2002 03:13 pm, Anton Altaparmakov wrote:
> > Goodie. Now we need benchmarks for all the approaches... (-;
> >
> > At 13:21 07/01/02, Jeff Garzik wrote:
> > <snip>
> > >patch7: implement ext2 use of s_op->{alloc,destroy}
> > >
> > >         at this point we have what Linus described:
> > >
> > >                 struct ext2_inode_info {
> > >                         ...ext2 stuff...
> > >                         struct inode inode;
> > >                 };
> >
> > If we were to raise compiler requirements to gcc-2.96 or later this could
> > be simplified with an annonymous struct (having elements in struct inode
> > with the same name as elements in ...ext2 stuff... should be a shooting
> > offence IMO):
> >
> >          struct ext2_inode_info {
> >                  ...ext2 stuff...
> >                  struct inode;
> >          };
> >
> > Advantage of this would be that as far as the fs is concerned there is 
> only
> > one inode and each element can just be dereferenced straight away without
> > need to think was that the generic inode or the fs inode and without need
> > for keeping two pointers around. This leads to simpler code inside the
> > filesystems once they adapt.
>
>Interesting, it's something I've always wanted to be able to do.  But I
>suppose the compiler requirement is a stupport.

Yes. I wonder if gcc people can be persuaded to backport annonymous 
structures and unions into gcc-2.95...?

> > Of course fs which are not adapted would still just work with the fs_i()
> > and fs_sb() macros and/or using two separate pointers.
>
>Yes, the fs_* macros are the really critical part of all this.  I'd like to
>get them in early, while we hash out the rest of it.  I think Jeff supports
>me in this, possibly Al as well.

Absolutely. The macros (or inline functions) are essential to give us the 
ability to play with the internal implementation at will. The sooner they 
are merged into the kernels (preferably both 2.4 and 2.5 considering they 
don't actually change how things work) the better.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

