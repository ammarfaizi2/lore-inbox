Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRHIHxY>; Thu, 9 Aug 2001 03:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269728AbRHIHxP>; Thu, 9 Aug 2001 03:53:15 -0400
Received: from fungus.teststation.com ([212.32.186.211]:30227 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S269726AbRHIHxI>; Thu, 9 Aug 2001 03:53:08 -0400
Date: Thu, 9 Aug 2001 09:52:33 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>, <pdan@spiral.extreme.ro>
Subject: Re: netfs allows multiple identical mounts (was: smb/mount 
In-Reply-To: <32C99E30BA@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0108090921570.3513-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Petr Vandrovec wrote:

> > This is probably something that smbmount could check before mounting.
> > But I'm not sure if that is the best fix.
> 
> For sure it is, as doing
> 
> mount -t smbfs -o username=a //srv/share /mnt/smb
> mount -t smbfs -o username=b //srv/share /mnt/smb
> 
> looks quite legal to me, as both //srv/share can display completely
> different set of files, and nobody except smbfs knows that username=a/
> username=b matters, but fmode=700/fmode=755 does not...

If this was a local block device it would not allow the mount, because the
device is the same. Even if the options differ in a way that makes it
access the files differently (hypothetical ntfs that allows you to
specify the NT-GUID to use for access control? some funky iso9660 option
that force it to read dirs from some alternative list?)

Doing this in smbmount isn't a problem, but I thought this was
inconsistent between local and remote fs and that it could perhaps be
(sort of) solved for all fs at once by doing something clever. Perhaps not.


> ncpfs (mount.ncp) will warn you if //srv/share is listed anywhere in
> /etc/mtab and it is mounted by you. If you'll use '-o multiple', then
> it is assumed that you know what you are doing, and nothing prevents you
> from mounting same thing on same place 255 times.

Most people have other "nodev" fs' so you can't actually mount 255 times
(unless you hack get_unnamed_dev to give you more :)

And yes, I know someone that wanted to.

/Urban

