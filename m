Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSFQSir>; Mon, 17 Jun 2002 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSFQSir>; Mon, 17 Jun 2002 14:38:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4105 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316919AbSFQSiq>;
	Mon, 17 Jun 2002 14:38:46 -0400
Message-ID: <3D0E2DAB.B3D0EA@zip.com.au>
Date: Mon, 17 Jun 2002 11:42:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 10/19] direct-to-BIO I/O for swapcache pages
References: <3D0D873A.405ED0BB@zip.com.au> <20020617161718.GD22427@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jun 16, 2002  23:52 -0700, Andrew Morton wrote:
> > This patch changes the swap I/O handling.  The objectives are:
> >
> > At swapon time (for an S_ISBLK swapfile), we install a single swap extent
> > which describes the entire device.
> >
> > +     inode = sis->swap_file->f_dentry->d_inode;
> > +     if (S_ISBLK(inode->i_mode)) {
> > +             ret = add_swap_extent(sis, 0, sis->max, 0);
> > +             goto done;
> > +     }
> 
> I believe it is possible to have blocks marked bad in the swap header,
> even for a block device, so this will try to use those bad blocks.

Well, this establishes the page index -> sector mapping for those
blocks.  But the actual block allocator will not hand out the
SWP_MAP_BAD blocks in the first place.
