Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTI2HxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTI2HxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:53:03 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:1449 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262865AbTI2Hw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:52:59 -0400
Date: Mon, 29 Sep 2003 00:52:50 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@osld.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: effect of nfs blocksize on I/O ?
Message-ID: <20030929005250.A9110@google.com>
References: <20030928234236.A16924@google.com> <16247.56578.861224.328086@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16247.56578.861224.328086@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Sep 29, 2003 at 12:19:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 12:19:30AM -0700, Trond Myklebust wrote:
> >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
> 
>      > 2.6 sets this to nfs_fsinfo.wtmult?nfs_fsinfo.wtmult:512 = 512
>      >     typically.
> 
>      > (My estimation of "typical" may be way off though.)
> 
>      > At a 512 byte blocksize, this overflows struct statfs for fs >
>      > 1TB.  Most of my NFS filesystems (on netapp) are larger than
>      > that.
> 
> Then you should use statfs64()/statvfs64(). Nobody is going to
> guarantee to you that the equivalent 32-bit syscalls will hold for
> arbitrary disk sizes.

I see.

> OTOH, bsize is of informational interest to programs that wish to
> optimize I/O throughput by grouping their data into appropriately
> sized records.

So then isn't the optimal record size 8192 for r/wsize=8192?  Since the
data is going to be grouped into 8192-byte reads and writes over the wire,
shouldn't bsize match that?  Why should I make 16x 512-byte write() syscalls
(if "optimal" I/O size is bsize=512) instead of 1x 8192-byte syscall?

SUSv3 says:

    unsigned long f_bsize    File system block size. 
    unsigned long f_frsize   Fundamental file system block size.

Solaris statvfs(2) says:

    u_long      f_bsize;             /* preferred file system block size */
    u_long      f_frsize;            /* fundamental filesystem block
                                         (size if supported) */

/fc
