Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbTA2Vt2>; Wed, 29 Jan 2003 16:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTA2Vt2>; Wed, 29 Jan 2003 16:49:28 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:56209 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267350AbTA2Vt1>;
	Wed, 29 Jan 2003 16:49:27 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15928.20117.266542.506842@harpo.it.uu.se>
Date: Wed, 29 Jan 2003 22:58:45 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: 2.5.59 NFS server keeps local fs live after being stopped
In-Reply-To: <15928.16811.851512.105997@notabene.cse.unsw.edu.au>
References: <15927.56648.966141.528675@harpo.it.uu.se>
	<15928.16811.851512.105997@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
 > On Wednesday January 29, mikpe@csd.uu.se wrote:
 > > Kernel 2.5.59. A local ext2 file system is mounted at $MNTPNT
 > > and exported through NFS V3. A client mounts and unmounts it,
 > > w/o any I/O in between. The NFS server is shut down. Nothing in
 > > user-space refers to $MNTPNT.
 > > 
 > > The bug is that $MNTPNT now can't be unmounted. umount fails with
 > > "device is busy". A forced umount at shutdown fails with "device
 > > or resource busy" and "illegal seek", and leaves the underlying
 > > fs marked dirty.
 > > 
 > > I can't say exactly when this began, but the problem is present
 > > in 2.5.59 and 2.5.55. 2.4.21-pre4 does not have this problem.
 > 
 > How do you shut down the nfs server?

/etc/rc.d/init.d/nfs stop
which basically does a kill on rpc.mountd, nfsd, and rpc.quotad
(standard RH8.0 user-space)

I've checked that all *nfs* processes are gone.

 > Is anything in /proc/fs/nfs/export after the shutdown?

Except for the two header lines, it's empty.

/Mikael
