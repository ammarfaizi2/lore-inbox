Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSCaCEy>; Sat, 30 Mar 2002 21:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSCaCEo>; Sat, 30 Mar 2002 21:04:44 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11697 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311211AbSCaCE1>;
	Sat, 30 Mar 2002 21:04:27 -0500
Date: Sat, 30 Mar 2002 21:04:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7 
In-Reply-To: <11499.1017532970@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0203302101190.4431-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Mar 2002, Keith Owens wrote:

> On Sun, 31 Mar 2002 09:48:38 +1000 (EST), 
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >I cannot see the weak aliases being a real fix either.
> >If you compile with NFSD as a module, and with CONFIG_KMOD, then the
> >nfssvc_ctl systemcall is suppose to auto-load nfsd.o.  How can this be
> >achieved with weak aliases?
> 
> System calls cannot be in modules.  Linus forbids it (that way lies
> "extend and embrace") and at least two architectures (ia64, ppc64)
> break when a syscall is in a module.

Yup.  The logics being:

if we have neither CONFIG_NFSD nor CONFIG_NFSD_MODULE
	sys_nfsservctl() is alias for sys_ni_syscall()
else
	sys_nfsservctl() is defined in fs/nfsct.c and does do_kern_mount()
	with type "nfsd", which triggers autoload if nfsd is modular.  Whether
	nfsd is modular or comipled-in, syscall itself is in kernel (and
	is nothing but a wrapper for write()/read()).

