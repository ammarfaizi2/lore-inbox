Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSGIOC1>; Tue, 9 Jul 2002 10:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGIOC0>; Tue, 9 Jul 2002 10:02:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:51844 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315358AbSGIOCZ>; Tue, 9 Jul 2002 10:02:25 -0400
Date: Tue, 9 Jul 2002 10:06:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <200207091549.15913.trond.myklebust@fys.uio.no>
Message-ID: <Pine.LNX.3.95.1020709095544.27285A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Trond Myklebust wrote:

> Hi,
> 
>    There was a bug reported on the 'exim' user list a couple of months ago: 
> the Linux NFS client reports -EINVAL if you try to fsync() a directory.
> 
>    The correct response would be to return a dummy '0' for success, since all 
> NFS operations that change the directory are supposed to be performed 
> synchronously on the server anyway...
> 
> Cheers,
>   Trond
> 
> 

Isn't it supposed to return EINVAL if "fd is bound to a file which
doesn't support synchronization..."  That's what POSIX 4 says.

Errors:
EBADF	fildes is not a valid file descriptor.
EINVAL	The file descriptor is valid, but the system doesn't support
	fsync on this particular file.

I think code that opens a directory as a file is broken. We have
opendir() for that and it returns a DIR pointer, not a file descriptor.
If the directory was properly opened, one would never attempt to
fsync() it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

