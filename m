Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285192AbRLFU41>; Thu, 6 Dec 2001 15:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285179AbRLFUzD>; Thu, 6 Dec 2001 15:55:03 -0500
Received: from stine.vestdata.no ([195.204.68.10]:5842 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id <S284248AbRLFUxJ>;
	Thu, 6 Dec 2001 15:53:09 -0500
Date: Thu, 6 Dec 2001 21:52:58 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <nfs@ragnark.vestdata.no>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Steffen Persvold <sp@scali.no>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>,
        nfs list <nfs@lists.sourceforge.net>, ext2-devel@lists.sourceforge.net
Subject: Re: [NFS] Re: [Ext2-devel] Re: 2.4.9 kernel crash
Message-ID: <20011206215258.A30580@vestdata.no>
In-Reply-To: <3C077FF8.AFBD8DB8@scali.no> <3C07E905.DF30E497@zip.com.au> <20011204003350.L2857@redhat.com> <3C0FB84A.76D8C003@scali.no> <20011206185027.O2029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206185027.O2029@redhat.com>; from sct@redhat.com on Thu, Dec 06, 2001 at 06:50:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen.

On Thu, Dec 06, 2001 at 06:50:27PM +0000, Stephen C. Tweedie wrote:
> > So what could this be then ?
>  
> > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> 
> has been reported before, even on much more recent kernels, and even
> without ext3 loaded.  So basically I've no idea what's behind it.

To quote my own post to xfs_devel and lk july 20th, subject 
"Busy inodes after umount":

I've now been able to reproduce:

* make a filesystem
* mount it
* export it (nfs)
* mount on remote machine
* lock file (fcntl)
* unexport
* unmount

Then you get the VFS message about self-destruct. Tested with both ext2
and xfs.

A reply from Neil Brown:
Yep.  It is not filesystem specific.
nfsd does not flush locks when a filesystem is un-exported, only when
a client is removed, and that actually never happens.
In fs/nfsd/lockd.c there is a comment:

/*
 * When removing an NFS client entry, notify lockd that it is gone.
 * FIXME: We should do the same when unexporting an NFS volume.
 */

That FIXME needs to be fixed.  I need to read through some more code
before I am sure how to do it, but it shouldn't be too hard.



I hope that can be of some help?



-- 
Ragnar Kjørstad
Big Storage
