Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTBTWHa>; Thu, 20 Feb 2003 17:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTBTWHa>; Thu, 20 Feb 2003 17:07:30 -0500
Received: from havoc.daloft.com ([64.213.145.173]:54684 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267104AbTBTWH3>;
	Thu, 20 Feb 2003 17:07:29 -0500
Date: Thu, 20 Feb 2003 17:17:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Prasad <prasad_s@students.iiit.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Syscall from Kernel Space
Message-ID: <20030220221730.GS9800@gtf.org>
References: <Pine.LNX.4.44.0302202301350.12696-100000@students.iiit.net> <20030220174043.GI9800@gtf.org> <20030220221027.GA31480@x30.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220221027.GA31480@x30.school.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:10:27PM +0100, Andrea Arcangeli wrote:
> On Thu, Feb 20, 2003 at 12:40:43PM -0500, Jeff Garzik wrote:
> > On Thu, Feb 20, 2003 at 11:04:37PM +0530, Prasad wrote:
> > > 	Is there a way using which i could invoke a syscall in the kernel 
> > > space?  The syscall is to be run disguised as another process.  The actual 
> > 
> > Call sys_<syscall>.  Look at the kernel code for examples.
> > 
> > Note that typically you don't want to do this... and you _really_ don't
> > want to do this if the syscall is not one of the common file I/O
> > syscalls (read/write/open/close, etc.)
> 
> you never want to do this, the only point of a syscall is to enter
> kernel, if you're just in kernel you're wasting time in calling the
> syscall (not to tell about the new non soft interrupt based syscall
> instructions, btw this is also why I rejected the int 0x81 thing on
> x86-64 for 64bit syscalls)

He is talking about directly calling the function behind the syscall,
not actually executing a syscall itself.

The kernel already does this in various places.  sys_read, sys_write,
open_filp, sys_close, and other functions are safe to call from kernel
code -- though this is discouraged.  init/do_mounts.c is a particularly
annoying case, and is a big reason why klibc needs to be merged.
syscalls should be made from userspace, not the kernel.

	Jeff



