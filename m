Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291383AbSAaWic>; Thu, 31 Jan 2002 17:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291382AbSAaWiW>; Thu, 31 Jan 2002 17:38:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5686 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S291381AbSAaWiP>; Thu, 31 Jan 2002 17:38:15 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <m1r8o7ayo3.fsf@frodo.biederman.org>
	<3C58DD2E.10106@zytor.com> <m1n0yvaucy.fsf@frodo.biederman.org>
	<3C598585.4090004@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Jan 2002 15:34:29 -0700
In-Reply-To: <3C598585.4090004@zytor.com>
Message-ID: <m1it9itaiy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Etherboot requires a specific other driver.  The problem with what you're
> proposing -- and let me get it very clear here, it's a huge problem -- is that
> you have no device-independent access to the boot medium (in this case, the
> network) once you have loaded the initial boot program.  This is an enormous
> drawback.

First it isn't an immediate problem because with an ELF image you
don't need a multistage bootloader.  I can represent everything in one
file.  Essentially a sparse coredump.

If you are writing an intermediate loader it is a problem.  An
intermediate loader needs OS services, and if you don't have those
services you are in trouble.  For this purpose it is fair to call the
x86 BIOS,  EFI, the SRM, and open firmware OS's. 

Personally when I want an OS I would like to use Linux.  So I have
written a patch that allows me too load another OS from Linux, so in
those cases when I am writing an intermediate boot loader I can use
Linux.  I admit I haven't gracefully solved all of the bootstrapping
cases but that is just a matter of time.

> That's the thing with PXE and the BIOS too, for that matter: they might be specs
> done by monkeys, but when it really counts, what you need is really there
> (modulo bugs, but that applies to everything.)

Except PXE isn't always there.  In fact PXE is usually absent.  If it
was always there on x86 this would be a good argument.  For those
cases when I can't get firmware to do my network booting I put the
Linux kernel on a floppy or a cd or whatever the firmware can boot off
of and network boot with that.  

I do agree that having specs even when done by monkeys are good when
they are widely implemented.  

But I see no reason why the open source community shouldn't drive the
specs.  We have as much right as Intel or any other self appointed
commitie.  And open source is a great tool for providing defacto
implementations. 

And I have been doing this for over a year in production on thousands
of machines so I do know that PXE is by no means necessary.  

Eric

