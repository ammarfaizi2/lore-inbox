Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSJSRdc>; Sat, 19 Oct 2002 13:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSJSRdc>; Sat, 19 Oct 2002 13:33:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57898 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265636AbSJSRda>; Sat, 19 Oct 2002 13:33:30 -0400
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<20021018173248.E14894@almesberger.net>
	<m1bs5rz1d6.fsf@frodo.biederman.org>
	<20021018231540.C7951@almesberger.net>
	<20021019025309.A24579@almesberger.net>
	<m17kgfyltc.fsf@frodo.biederman.org>
	<20021019040600.D7951@almesberger.net>
	<m13cr2zs99.fsf@frodo.biederman.org>
	<20021019141806.E7951@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Oct 2002 11:37:56 -0600
In-Reply-To: <20021019141806.E7951@almesberger.net>
Message-ID: <m1hefixrbf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Eric W. Biederman wrote:
> > Cool.  What fails with X11.  Fixing it might be as simple as calling
> > int 0x10 early in the new image.
> 
> The graphic engine (i810) simply doesn't switch back to text mode.
> Yes, 0x10 helps. I've attached a little patch that does this in a
> relatively safe way. (Alternative, one could also use set_80x25,
> but I think always forcing mode 3 is slightly more reliable.
> Except for MGA users, of course :-)
> 
> If you get a new boot loader type code from Peter Anvin, this
> should even be good enough for inclusion into the mainstream
> kernel. Alternatively, we could also pick a new loader flag to
> indicate that the firmware didn't initialize the system.

For the most part my preferences is to put the system into a sane state
when we reboot/shutdown.  The device_shutdown call in the kernel can handle
this, on reboot.  The problem with video is mostly that the drivers
are not well integrated.

> > [vmlinux] specifies incorrect physical
> > addresses, and it expects to be passed a whole host of strange values,
> > in weird places.
> 
> I see. Perhaps you could say then that mkelfImage fixes flaws in
> the vmlinux ELF image meta-data, or such:

The primary thing it does is give the kernel a working 32bit entry
point.

> | A kernel reformater is makes images that seem to boot more reliably is at:
> | ftp://ftp.lnxi.com/pub/mkelfImage/mkelfImage-1.17.tar.gz
> 
> This sounds more like "if I kick it here, it usually works,
> but I have no idea why" :-)

The code was built so I could put a kernel, a ramdisk, and a command line
all in a single ELF executable.    With the addition of entering the kernel
at it's unsupported 32bit entry point.  So I perform a different set of BIOS
calls that setup.S does.  Though they are very similar.

But why mkelfImage works occasionally when a bzImage doesn't and you
have a pcbios is a mystery to me.  I know why only mkelfImage works
under LinuxBIOS...

> And yes, if it's not too intrusive, fixing the ELF meta-data
> along with the addition of kexec might be a good idea.

The meta-data is easy, about one line in vmlinux.lds.  Fixing the
actual entry point is more interesting.  I've done it and the result
is maintainable but the patch met some definitions of intrusive.

Eric
