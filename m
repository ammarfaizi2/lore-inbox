Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285007AbRL3VBY>; Sun, 30 Dec 2001 16:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRL3VBP>; Sun, 30 Dec 2001 16:01:15 -0500
Received: from oss.sgi.com ([216.32.174.27]:52166 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S285020AbRL3VBA>;
	Sun, 30 Dec 2001 16:01:00 -0500
Date: Sun, 30 Dec 2001 19:00:20 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Lennert Buytenhek <buytenh@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
Message-ID: <20011230190020.A14157@dea.linux-mips.net>
In-Reply-To: <20011230110623.A17083@gnu.org> <200112301956.OAA02630@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112301956.OAA02630@ccure.karaya.com>; from jdike@karaya.com on Sun, Dec 30, 2001 at 02:56:21PM -0500
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 02:56:21PM -0500, Jeff Dike wrote:

> buytenh@gnu.org said:
> > Is there any particular reason we need a global errno in the kernel at
> > all? (which, by the way, doesn't seem to be subject to any kind of
> > locking)  
> 
> As far as I've been able to tell, no.

Historically the reason was to make unistd.h usable from userspace.  Which
is causing tremendous portability problems so apps better shouldn't think
about using the syscall interface directly.

> > It makes life for User Mode Linux somewhat more complicated
> > than it could be, and it generally just seems a bad idea.
> 
> Yeah.  In order for -fno-common to not blow up the UML build (because of the
> clash between libc errno and kernel errno), I had to add -Derrno=kernel_errno
> to all the kernel file compiles.  It would be nice to get rid of that wart.
> 
> > Referenced patch deletes all mention of a global errno from the
> > kernel
> 
> Awesome.  This definitely needs to happen.  If no one spots any breakage,
> send it in...

As user application are trying to use unistd.h and expect errno to get
set properly unistd.h or at least it's syscallX macros will have to be
made unusable from userspace or silent breakage of such apps rebuild
against new headers will occur.

  Ralf
