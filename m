Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280394AbRKJSAG>; Sat, 10 Nov 2001 13:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280547AbRKJR75>; Sat, 10 Nov 2001 12:59:57 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:17506 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280394AbRKJR7n>; Sat, 10 Nov 2001 12:59:43 -0500
Date: Sat, 10 Nov 2001 12:58:32 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for kernel.real-root-dev on s390
Message-ID: <20011110125832.A21437@devserv.devel.redhat.com>
In-Reply-To: <200111100248.DAA00341@faui11.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111100248.DAA00341@faui11.informatik.uni-erlangen.de>; from weigand@immd1.informatik.uni-erlangen.de on Sat, Nov 10, 2001 at 03:48:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
> Date: Sat, 10 Nov 2001 03:48:33 +0100 (MET)
> Cc: linux-kernel@vger.kernel.org

> I agree that this looks broken, but I don't see why it 
> would be s390 specific.  The clobber of adjacent memory
> happens on all architectures, and on all big endian systems
> the value read is incorrect even if adjacent memory happens 
> to be 0.

Probably alignment restrictions do not allow anything interesting
to happen. I know now that ppc people complained about it.

> However, I'm not convinced the patch is a proper fix; it
> will cause the MAJOR and MINOR macros to be applied to a
> variable not of type kdev_t, which happens to work now but will 
> break if the definition of kdev_t is changed to a structure
> or pointer type (as it probably will at some point in the 
> future, if I recall the various discussions correctly).
> 
> What about either
>  - adding support for kdev_t values to procfs
> or

I thought that would be the right thing to do when kdev_t is changed.
Currently, I do not know how to change it. Guy Streeter told me
that someone floated an insanely ugly patch that special-cased
shorts into do_proc_dointvec(), and I did not like that approach
too much. Once the structure of new kdev_t is known, the
do_proc_kdev_t may be defined, but I think it makes no sense
to jump the gun now.

>  - keeping two int variables real_root_major and 
>    real_root_minor ?

Who knows if we are going to have majors and minors at all.
Suppose Gooch and Viro give us a decent devfs, or something.

An alternative may be to redo the initrd interface, for instance
have /proc/real-root-path instead of real-root-dev (and no sysctl),
I did not have time to explore all implications of that way.

-- Pete
