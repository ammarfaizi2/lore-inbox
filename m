Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268354AbRGWWUu>; Mon, 23 Jul 2001 18:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268351AbRGWWUl>; Mon, 23 Jul 2001 18:20:41 -0400
Received: from [217.28.130.35] ([217.28.130.35]:29446 "EHLO
	mailth4.byworkwise.com") by vger.kernel.org with ESMTP
	id <S268360AbRGWWUW>; Mon, 23 Jul 2001 18:20:22 -0400
Message-ID: <3B5CA338.890F9586@freenet.co.uk>
Date: Mon, 23 Jul 2001 23:20:40 +0100
From: Gordon Lack <gmlack@freenet.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFSv3 pathname problems in 2.4 kernels
In-Reply-To: <3B5B32B2.B96E6BD3@freenet.co.uk> <15195.35313.83387.515099@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Neil Brown wrote:
> 
> This shouldn't be a problem for Solaris 2.6, but definately is for
> Irix.

   Well, there are many 2.6 systems and they all fail in the same aay
as Irix.  So does Solaris 2.7.  (2.8 seems to be Ok).

> > b) if so, do they have a solution?
> 
> 1/ Don't use irix.

   Not an option!

> 2/ Don't use NFSv3

   Not an option - some of the files are multi-GB ones.

> 3/ Get a patch from Irix... I believe an upcoming release of Irix
> fixed the problem, but I don't recall the details.

   Fixed in 6.5.13 (I believe) but that requires fixing it in *many* clients, and doesn't help the
Solaris2.6/2.7 systems.

> Look in fs/nfsd/nfsfh.c, in fh_compose.
> If you change:
>         if (ref_fh &&
>             ref_fh->fh_handle.fh_version == 0xca &&
>             parent->d_inode->i_sb->s_op->dentry_to_fh == NULL) {
> to
>         if (parent->d_inode->i_sb->s_op->dentry_to_fh == NULL) {
> you will probably get what you want, for ext2 at least.

   Thanks, but this is for xfs (I didn't fancy fsck'ing a 470GB file
system!).  I suppose it's suck it and see....

> "Best" option is to complain to SGI and get a patch.

   Not necessarily.  That is certainly a long(ish)-term path, but there
are *far* more clients than servers, so a server-side fix, even if just
a temporary fudge, is must better in practical terms. Change Control procedures
for systems is more accurately described as Change Prevention!


   Many thanks...
