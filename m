Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbTBDMvV>; Tue, 4 Feb 2003 07:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTBDMvR>; Tue, 4 Feb 2003 07:51:17 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:14721 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267246AbTBDMvP>;
	Tue, 4 Feb 2003 07:51:15 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15935.47483.248775.467616@harpo.it.uu.se>
Date: Tue, 4 Feb 2003 14:00:43 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 NFS server keeps local fs live after being stopped
In-Reply-To: <15935.5967.576377.804605@notabene.cse.unsw.edu.au>
References: <15927.56648.966141.528675@harpo.it.uu.se>
	<15928.16811.851512.105997@notabene.cse.unsw.edu.au>
	<15928.20117.266542.506842@harpo.it.uu.se>
	<15929.2764.932711.81506@notabene.cse.unsw.edu.au>
	<15935.5967.576377.804605@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
 > On Thursday January 30, neilb@cse.unsw.edu.au wrote:
 > > On Wednesday January 29, mikpe@csd.uu.se wrote:
 > > > Neil Brown writes:
 > > >  > On Wednesday January 29, mikpe@csd.uu.se wrote:
 > > >  > > Kernel 2.5.59. A local ext2 file system is mounted at $MNTPNT
 > > >  > > and exported through NFS V3. A client mounts and unmounts it,
 > > >  > > w/o any I/O in between. The NFS server is shut down. Nothing in
 > > >  > > user-space refers to $MNTPNT.
 > > >  > > 
 > > >  > > The bug is that $MNTPNT now can't be unmounted. umount fails with
 > > >  > > "device is busy". A forced umount at shutdown fails with "device
 > > >  > > or resource busy" and "illegal seek", and leaves the underlying
 > > >  > > fs marked dirty.
 > ....
 > > 
 > > Ok, it defaintely sounds like a leak.  I'll be back at my desk on
 > > Monday and I will try to reproduce it and explore the situation then.
 > > 
 > > NeilBrown
 > 
 > Found and fixed...  the following patch should make it work for you.

Nope. I still get the same behaviour as before, i.e. unable to umount
the underlying fs after nfsd has been shut down.

/Mikael
