Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312612AbSDFRRz>; Sat, 6 Apr 2002 12:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312616AbSDFRRy>; Sat, 6 Apr 2002 12:17:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58520 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312612AbSDFRRx>;
	Sat, 6 Apr 2002 12:17:53 -0500
Date: Sat, 6 Apr 2002 12:17:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [WTF] ->setattr() locking changes
In-Reply-To: <Pine.GSO.4.21.0204061131040.632-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204061213490.632-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Apr 2002, Alexander Viro wrote:

> 	Looking at that stuff, I'd suggest to
> a) kill that branch in hpfs_unlink().
> b) remove fh_lock()/fh_unlock() in nfsd/vfs.c::nfsd_setattr() (Trond?)
> c) add ATTR_SXID that would do s[ug]id removal - under ->i_sem and switch
>    the callers to it.
> 
> Comments?  If you don't see any problems with this variant I'll do it.

OTOH, we might be better off taking ->i_sem in all callers of notify_change().
There's only 10 of them, so it's not too much work and that would have a
benefit of allowing to do things like suid removal on write(2) in a right way.

Hmm...  While we are at it, why don't we remove suid/sgid on truncate(2)?

