Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSLMRIR>; Fri, 13 Dec 2002 12:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSLMRIQ>; Fri, 13 Dec 2002 12:08:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:32648 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265169AbSLMRIQ>; Fri, 13 Dec 2002 12:08:16 -0500
Date: Fri, 13 Dec 2002 11:15:16 -0600
From: Amos Waterland <apw@us.ibm.com>
To: Jeff Bailey <jbailey@nisa.net>
Cc: root@chaos.analogic.com, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Symlink indirection
Message-ID: <20021213111515.A26218@kvasir.austin.ibm.com>
References: <Pine.LNX.3.95.1021213101227.2190A-100000@chaos.analogic.com> <1039798306.921.11.camel@outpost.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039798306.921.11.camel@outpost.dnsalias.org>; from jbailey@nisa.net on Fri, Dec 13, 2002 at 11:51:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that you and Richard are dicussing a slightly different issue
than the original poster asked about.  The original question was:

On Fri, 13 Dec 2002, Andrew Walrond wrote:
> Is the number of allowed levels of symlink indirection (if that is the 
> right phrase; I mean symlink -> symlink -> ... -> file) dependant on the 
> kernel, or libc ? Where is it defined, and can it be changed?

To which Richard replied:

> Since a symlink is just a file containing a name, the resulting path
> length is simply the maximum path length that user-space tools allow.
> This should be defined as "PATH_MAX". Posix defines this as 255
> characters but I think posix requires that this be the minimum and all
> file-name handling buffers must be at least PATH_MAX in length.
>
> A hard link is just another directory-entry for the same file. This,
> therefore follows the same rules. There must be enough space on the
> device to contain the number of directory entries, as well as enough
> buffer length in the tools necessary to manipulate these "nested"
> directories, which are not really "nested" at all. 

But Richard is not actually completely correct.  There is a limit of 5
levels of symlink indirection in vanilla 2.4 series Linux kernels.

  % touch 0
  % for i in `seq 1 10`; do ln -s `ls | sort | tail -1` $i; done
  % ls
  0  1  10  2  3  4  5  6  7  8  9
  % cat 5
  % cat 6
  cat: 6: Too many levels of symbolic links
  % strace cat 6 2>&1 | grep 'open("6",'
  open("6", O_RDONLY|O_LARGEFILE) = -1 ELOOP (Too many levels of symbolic links)

This has been discussed by Al Viro et al. many times on lkml.  I believe
that it is not a user-space or POSIX issue, but rather a kernel issue.
Thanks.

Amos Waterland
