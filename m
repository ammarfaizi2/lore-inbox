Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262830AbSJEXom>; Sat, 5 Oct 2002 19:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262831AbSJEXog>; Sat, 5 Oct 2002 19:44:36 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:40437 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262830AbSJEXoe>; Sat, 5 Oct 2002 19:44:34 -0400
Date: Sat, 5 Oct 2002 22:36:34 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: trond.myklebust@fys.uio.no, Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 NFS file perms
Message-ID: <20021005223634.A1205@linux-m68k.org>
References: <20021005122115.A1338@linux-m68k.org> <15775.2654.502424.712655@charged.uio.no> <1033834053.4103.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033834053.4103.4.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Oct 05, 2002 at 05:07:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 05:07:33PM +0100, Alan Cox wrote:
> On Sat, 2002-10-05 at 16:50, Trond Myklebust wrote:
> > >>>>> " " == Richard Zidlicky <rz@linux-m68k.org> writes:
> > 
> >      > Hi, on an NFS mounted fs, executing as root I see this:
> > 
> >      > read(4, 0xefffe4cb, 1) = -1 EIO (Input/output error)
> > 
> >      > glibc crashes in fgets because it doesn't expect the problem
> >      > after the file has been successfully opened and mapped.. who is
> >      > at fault here?
> > 
> > The 'soft' mount option perhaps?

no, automount entry is
nfsr            -rw,noatime                     rz:/usr/m68kroot

> If glibc crashes because of an unmap you are I suspect running a gcc 2.3
> snapshot with the buggy and bogus mmap stdio option. If so turn it off
> before it does any more harm.

thanks, this seems to be one part of the solution - it is a glibc snapshot 
from rawhide, somewhat aged in the meantime.
I am still surprised that NFS returns such strange error instead of
EACCESS but that is probably bad interaction with the old NFS server.

Richard
.

