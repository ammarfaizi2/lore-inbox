Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUKSOOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUKSOOk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUKSOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:13:03 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:65167 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261417AbUKSOLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:11:38 -0500
Date: Fri, 19 Nov 2004 14:11:33 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: tridge@samba.org
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <16797.60034.186288.663343@samba.org>
Message-ID: <Pine.LNX.4.60.0411191352050.8634@hermes-1.csi.cam.ac.uk>
References: <16797.41728.984065.479474@samba.org> <1100865833.6443.17.camel@imp.csi.cam.ac.uk>
 <16797.60034.186288.663343@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tridge,

On Fri, 19 Nov 2004 tridge@samba.org wrote:
>  > Note, that NTFS supports all those things natively on the file system,
>  > so it may be worth keeping in mind when designing your APIs.  It would
>  > be nice if one day when ntfs write support is finished, when running
>  > Samba on an NTFS partition on Linux, Samba can directly access all those
>  > things directly from NTFS. 
> 
> yes, I have certainly thought about this, and at the core of Samba4 is
> a "ntvfs" layer that allows for backends that can take full advantage
> of whatever the filesystem can offer. The ntvfs/posix/ code in Samba4
> is quite small (currently 7k lines of code) and I'm hoping that more
> specialised backends will be written that talk to other types of
> filesystems.

Sounds great!

> To get things started I've also written a "cifs" backend for Samba4,
> that uses another CIFS file server as a storage backend, turning
> Samba4 into a proxy server. That backend uses the full capabilities of
> the ntvfs layer, and implements nearly all of the detailed stuff that
> a NTFS can do.
> 
>  > I guess a good way would be if your interface is sufficiently
>  > abstracted so that it can use xattrs as a backend or a native
>  > backend which NTFS could provide for you or Samba could provide for
>  > NTFS.  For example NTFS stores the 4 different times in NT format
>  > in each inode (base Mft record) so you would not have to take an
>  > xattr performance hit there.
> 
> The big question is what sort of API would you envisage between user
> space and this filesystem? Are you imagining that Samba mmap the raw
> disk and use a libntfs library? That would be possible, but would lose
> one of the big advantages of Samba, which is that the filesystem is
> available to both posix and windows apps.
> 
> Or are you thinking that we add a new syscall interface to, a bit like
> the IRP stuff in the NT IFS? I imagine there would be quite a bit of
> resistance to that in the Linux kernel community :-)
> 
> Realistically, I think that in the vast majority of cases Samba is
> going to be running on top of "mostly posix" filesystems for the
> forseeable future, unless you manage to do something pretty magical
> with the ntfs code. But if you do manage to get ntfs in Linux to the
> stage where its a viable alternative then I'd be delighted to help
> write the Samba4 backend to match.

I don't know.  I have been mulling over in my head for quite a while what 
to do about an interface for "advanced ntfs features" but so far I have 
always pushed this to the back of my mind.  After all no point in 
providing advanced features considering we don't even provide full 
read-write access yet.  I just thought I would mentione NTFS when I saw 
your post.

But to answer your question I definitely would envisage an interface to 
the kernel driver rather than to libntfs.  It is 'just' a matter of 
deciding how that would look...

Partially we will see what happens with Reiser4 as it faces the same or at 
least very simillar interface problems.  Maybe we need a sys_ntfs() or 
maybe we need to hitchhike the ioctl() interface or maybe the VFS can 
start providing all required functionality in some to be determined 
manner that we can use...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
