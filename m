Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSLMRld>; Fri, 13 Dec 2002 12:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSLMRld>; Fri, 13 Dec 2002 12:41:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3463 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262486AbSLMRlb>; Fri, 13 Dec 2002 12:41:31 -0500
Date: Fri, 13 Dec 2002 12:51:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Amos Waterland <apw@us.ibm.com>
cc: Jeff Bailey <jbailey@nisa.net>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Symlink indirection
In-Reply-To: <20021213111515.A26218@kvasir.austin.ibm.com>
Message-ID: <Pine.LNX.3.95.1021213124723.3031A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002, Amos Waterland wrote:

> I think that you and Richard are dicussing a slightly different issue
> than the original poster asked about.  The original question was:
> 
> On Fri, 13 Dec 2002, Andrew Walrond wrote:
> > Is the number of allowed levels of symlink indirection (if that is the 
> > right phrase; I mean symlink -> symlink -> ... -> file) dependant on the 
> > kernel, or libc ? Where is it defined, and can it be changed?
> 
> To which Richard replied:
> 
> > Since a symlink is just a file containing a name, the resulting path
> > length is simply the maximum path length that user-space tools allow.
> > This should be defined as "PATH_MAX". Posix defines this as 255
> > characters but I think posix requires that this be the minimum and all
> > file-name handling buffers must be at least PATH_MAX in length.
> >
> > A hard link is just another directory-entry for the same file. This,
> > therefore follows the same rules. There must be enough space on the
> > device to contain the number of directory entries, as well as enough
> > buffer length in the tools necessary to manipulate these "nested"
> > directories, which are not really "nested" at all. 
> 
> But Richard is not actually completely correct.  There is a limit of 5
> levels of symlink indirection in vanilla 2.4 series Linux kernels.
> 
>   % touch 0
>   % for i in `seq 1 10`; do ln -s `ls | sort | tail -1` $i; done
>   % ls
>   0  1  10  2  3  4  5  6  7  8  9
>   % cat 5
>   % cat 6
>   cat: 6: Too many levels of symbolic links
>   % strace cat 6 2>&1 | grep 'open("6",'
>   open("6", O_RDONLY|O_LARGEFILE) = -1 ELOOP (Too many levels of symbolic links)
> 
> This has been discussed by Al Viro et al. many times on lkml.  I believe
> that it is not a user-space or POSIX issue, but rather a kernel issue.
> Thanks.
> 
> Amos Waterland
> 

Yep. I thought the original poster was talking about following
the links, i.e., "indirection", rather than creating links which
is "definition".

So, the kernel does set a limit on the number of symlinks of the form,

ln -s a b ; ln -s b c ; ln -s c d ; ln -s d e ; # etc.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


