Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289165AbSAGKM4>; Mon, 7 Jan 2002 05:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289164AbSAGKMq>; Mon, 7 Jan 2002 05:12:46 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:6664 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S289162AbSAGKMd>; Mon, 7 Jan 2002 05:12:33 -0500
Message-ID: <3C3974F2.3AEE6768@loewe-komp.de>
Date: Mon, 07 Jan 2002 11:14:10 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Denis RICHARD <Denis.Richard@sxb.bsf.alcatel.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: e2compress on Linux 2.4.16
In-Reply-To: <3C33906D.5799612A@loewe-komp.de> <3C364A68.D586144E@loewe-komp.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler schrieb:
> 
> > Bonjour,
> >
> > I tried your e2compress patches and it didn't work for me at the
> > first run :-( After compression of some larger files (>400KiB)
> > the files couldn't be stat()ed -> the i_blocks field was "negative".
> >
> > in fs/ext2/cpmpress.c::ext2_compress_cluster:2886
> >         inode->i_blocks -= ((u_nblk - c_nblk)
> >                             << (inode->i_sb->s_blocksize_bits - 9));
> >
> > has to be deleted. Otherwise the i_blocks field gets decremented
> > twice. Depending on the glibc version you use, a stat() fails
> > due to some conversion code between lstat64() and userspace
> > returning EOVERFLOW and "negative i_blocks" (viewable with debugfs)
> >
> > ext2_free_blocks() calls DQUOT_FREE_BLOCK() which calls
> > include/linux/fs.h::inode_sub_bytes() regardless if CONFIG_QUOTA
> > is enabled or not.
> > In 2.2 the quota code was different - so there it was correct
> > to substract the free'ed blocks.
> >
> > With this "fix" all seems to work fine. So thanx for your work!
> >

Since I didn't get any reply so far (perhaps you have longer vacation than me:)

I resend my mail and also cc:lkml  - take it as a positive feedback!
