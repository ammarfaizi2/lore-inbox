Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286197AbRL0Dt0>; Wed, 26 Dec 2001 22:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286209AbRL0DtP>; Wed, 26 Dec 2001 22:49:15 -0500
Received: from dsl-213-023-038-250.arcor-ip.net ([213.23.38.250]:6663 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286207AbRL0DtK>;
	Wed, 26 Dec 2001 22:49:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Legacy Fishtank <garzik@havoc.gtf.org>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Date: Thu, 27 Dec 2001 04:52:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16JR71-0000cU-00@starship.berlin> <20011226222809.A8233@havoc.gtf.org>
In-Reply-To: <20011226222809.A8233@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16JRb5-0000cg-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 27, 2001 04:28 am, Legacy Fishtank wrote:
> On Thu, Dec 27, 2001 at 04:21:42AM +0100, Daniel Phillips wrote:
> > --- ../2.4.17.clean/include/linux/fs.h	Fri Dec 21 12:42:03 2001
> > +++ ./include/linux/fs.h	Wed Dec 26 23:30:55 2001
> > @@ -478,7 +478,7 @@
> >  	__u32			i_generation;
> >  	union {
> >  		struct minix_inode_info		minix_i;
> > -		struct ext2_inode_info		ext2_i;
> > +		struct ext2_inode_info		ext2_inode_info;
> >  		struct ext3_inode_info		ext3_i;
> >  		struct hpfs_inode_info		hpfs_i;
> >  		struct ntfs_inode_info		ntfs_i;
> 
> Change in principle looks good except IMHO you should go ahead and
> remove the ext2 stuff from the union...  (with the additional changes
> that implies)

Hi Jeff,

Thanks for your confidence, but that would be a considerably bigger patch.  
It's not just a matter of removing the includes - other bits and pieces have 
to be put in place, such as per-filesystem inode slab.  The support for this 
goes outside ext2.

My idea is to just let people have a look and test this minimally intrusive 
change.  Getting rid of the includes for ext2 inodes will be a two-patch 
change:

  1) Abstract away the ext2 .u's (done)
  2) Per-fs inode slab, initially only for ext2 (partly done)

Removing the includes for ext2 superblocks will need another two patches.  By 
the time all filesystems are done, it would be thousands of lines if it was 
all in one patch.  I think it's better to keep it broken up, and do it 
incrementally.

--
Daniel
