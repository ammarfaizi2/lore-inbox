Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRB0TNP>; Tue, 27 Feb 2001 14:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRB0TNG>; Tue, 27 Feb 2001 14:13:06 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:9993 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129344AbRB0TMz>;
	Tue, 27 Feb 2001 14:12:55 -0500
Date: Tue, 27 Feb 2001 20:12:02 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "H . J . Lu" <hjl@valinux.com>, NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Updated patch for the [2.4.x] NFS 'missing directory entry a.k.a. IRIX server' problem...
Message-ID: <20010227201202.B11060@pcep-jamie.cern.ch>
In-Reply-To: <14997.9938.106305.635202@charged.uio.no> <20010226152826.A20653@valinux.com> <15003.20448.999929.948597@charged.uio.no> <20010226230647.A14094@valinux.com> <15003.23067.683600.738764@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15003.23067.683600.738764@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Feb 27, 2001 at 08:41:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> >>>>> " " == H J Lu <hjl@valinux.com> writes:
> 
>      > I much prefer to have a new getdents system call which will
>      > also return d_type so that the 32 bit function in glibc can use
>      > this new getdents instead of getdents64.
> 
> That could also be done, however it seems odd to be adding a new
> 32-bit interface after the point when we're supposed to all have moved
> to 64 bits.

Indeed, getdents64 -> 32 conversion is hardly performance critical
anyway.

> BTW: does anybody anywhere actually use d_type? Certainly the standard
>      utilities such as 'find' or 'ls' don't seem to have been adapted
>      yet: I hacked up a version of NFSv3 that actually filled d_type
>      (by using readdirplus rather than readdir) but I've yet to find
>      any 'off the shelf' software, that uses the extra information.

Look for `treescan' via Google.  It uses a number of heuristics to
optimise a recursive directory search, and one of those is d_type if
available.  Though it dates back to a time before getdents64 (I hacked
getdents to return d_type).

d_type is quite effective for `find' type scans.  I really ought to
release an updated treescan -- the intent was always to replace the
backend of `find' but I got caught up trying to optimise the order of
open/readdir/close sequences and then on to other things.

-- Jamie
