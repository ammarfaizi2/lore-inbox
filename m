Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbRL3WGP>; Sun, 30 Dec 2001 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRL3WGF>; Sun, 30 Dec 2001 17:06:05 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:49383 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S285093AbRL3WFp>; Sun, 30 Dec 2001 17:05:45 -0500
Message-ID: <3C2F90E1.DADE7F54@didntduck.org>
Date: Sun, 30 Dec 2001 17:10:41 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
In-Reply-To: <20011230110623.A17083@gnu.org> <200112301956.OAA02630@ccure.karaya.com> <20011230190020.A14157@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> 
> On Sun, Dec 30, 2001 at 02:56:21PM -0500, Jeff Dike wrote:
> 
> > buytenh@gnu.org said:
> > > Is there any particular reason we need a global errno in the kernel at
> > > all? (which, by the way, doesn't seem to be subject to any kind of
> > > locking)
> >
> > As far as I've been able to tell, no.
> 
> Historically the reason was to make unistd.h usable from userspace.  Which
> is causing tremendous portability problems so apps better shouldn't think
> about using the syscall interface directly.
> 
> > > It makes life for User Mode Linux somewhat more complicated
> > > than it could be, and it generally just seems a bad idea.
> >
> > Yeah.  In order for -fno-common to not blow up the UML build (because of the
> > clash between libc errno and kernel errno), I had to add -Derrno=kernel_errno
> > to all the kernel file compiles.  It would be nice to get rid of that wart.
> >
> > > Referenced patch deletes all mention of a global errno from the
> > > kernel
> >
> > Awesome.  This definitely needs to happen.  If no one spots any breakage,
> > send it in...
> 
> As user application are trying to use unistd.h and expect errno to get
> set properly unistd.h or at least it's syscallX macros will have to be
> made unusable from userspace or silent breakage of such apps rebuild
> against new headers will occur.

Userspace should be using glibc's unistd.h.  If it's using the kernel's,
it's broken.

--
						Brian Gerst
