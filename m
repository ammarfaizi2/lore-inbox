Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269102AbRGaARK>; Mon, 30 Jul 2001 20:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269104AbRGaAQ6>; Mon, 30 Jul 2001 20:16:58 -0400
Received: from stine.vestdata.no ([195.204.68.10]:43787 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S269102AbRGaAQy>; Mon, 30 Jul 2001 20:16:54 -0400
Date: Tue, 31 Jul 2001 02:15:47 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
To: Tad Dolphay <tbd@sgi.com>
Cc: mjacob@feral.com, Christian Chip <chip.christian@storageapps.com>,
        linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: Busy inodes after umount
Message-ID: <20010731021546.A7750@vestdata.no>
In-Reply-To: <20010719165758.D50024-100000@wonky.feral.com> <200107200038.TAA40153@fsgi158.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <200107200038.TAA40153@fsgi158.americas.sgi.com>; from Tad Dolphay on Thu, Jul 19, 2001 at 07:38:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 07:38:15PM -0500, Tad Dolphay wrote:
> > > I've now been able to reproduce:
> > >
> > > * make a filesystem
> > > * mount it
> > > * export it (nfs)
> > > * mount on remote machine
> > > * lock file (fcntl)
> > > * unexport
> > > * unmount
> > >
> > > Then you get the VFS message about self-destruct. Tested with both ext2
> > > and xfs.
> > >
> > > The lock is still present in /proc/locks after the umount.
> > >
> > > With ext2 I can remount the filesystem successfully, but with XFS I get
> > > the message about duplicate UUIDs and the mount failes. I believe this is a totally
> > > different problem from the one you were experiencing. (and blockdev doesn't help for me)
> > >
> > > I suppose this is a generic kernel bug?
>
> I know there was a fix for a "Busy inodes after unmount" problem in
> 2.4.6-pre3. Here's an excerpt from a posting to the NFS mailing list
> from Neil Brown:
> 
> -------------Included message-----------------------
>   Previously anonymous dentries were hashed (though with no name, the
>   hash was pretty meaningless).  This meant that they would hang around
>   after the last reference was dropped.  This was actually fairly
>   pointless as they would never get referenced again, and caused a real
>   problem as umount wouldn't discard them and so you got the message
>                 printk("VFS: Busy inodes after unmount. "
>                         "Self-destruct in 5 seconds.  Have a nice day...\n");
> 
>   In 2.4.6-pre3 I stopped hashing those dentries so now when the last
>   reference is dropped, the dentry is freed.  So now there will never be
>   more anonymous dentries than there are active nfsd threads.
> ---------------end included message-------------------

I just tested with 2.4.7, and the problem remains.


-- 
Ragnar Kjorstad
Big Storage
