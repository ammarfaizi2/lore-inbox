Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262010AbSJDSkV>; Fri, 4 Oct 2002 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbSJDSkV>; Fri, 4 Oct 2002 14:40:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49547 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262010AbSJDSkU>;
	Fri, 4 Oct 2002 14:40:20 -0400
Date: Fri, 4 Oct 2002 14:45:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
In-Reply-To: <1033757193.31839.51.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0210041439500.19491-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 Oct 2002, Alan Cox wrote:

> On Fri, 2002-10-04 at 19:14, Andi Kleen wrote:
> > privateice also needs it. And there is no easy way to fix it like
> > oprofile, unless you moved it completely into the kernel.
> > 
> > And AFS of course too for afssyscall.
> > 
> > (both are free)
> 
> AFS patches a collection of random syscalls in pretty icky ways. Again
> afssyscall wants doing the right way - with a kernel stub like NFS has

Note that even that is not needed - nfsservctl() can be easily removed;
essentially it's a userland code.  mkdir /dev/nfsctl, have nfsd mounted
on it and nfsservctl() is
	open /dev/nfsctl/blah
	write request
	possibly read reply
	close
Kernel code does exactly that, the only difference is that it creates
a temporary vfsmount not attached anywhere.  End of story.  Modular
case is handled automatically - if nfsd is not loaded, mounting (either
explicit or do_kern_mount() called in kernel version) will happily
load the module - as with any other filesystem type.

