Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291597AbSBAH4b>; Fri, 1 Feb 2002 02:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291598AbSBAH4T>; Fri, 1 Feb 2002 02:56:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43318 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S291597AbSBAH4C>; Fri, 1 Feb 2002 02:56:02 -0500
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
	<3C598585.4090004@zytor.com> <m1it9itaiy.fsf@frodo.biederman.org>
	<3C59CAB0.1020400@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2002 00:52:25 -0700
In-Reply-To: <3C59CAB0.1020400@zytor.com>
Message-ID: <m1vgdhabba.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my ideal world here is how it works.

The firmware bootloader reads an ELF header from the first sector of
the disk.  Looking at the ELF header it knows where everything else is
and loads the rest of the operating system and jumps to it.

There is a problem with that I cannot select among multiple images to
boot.  So I install a different ELF image with the ELF header on the
first sector of my hard drive.  This second image instead of being a
stripped down small and limited piece of code is a distribution of my OS
dedicated to the task of helping my decide which image to boot.  Total
freedom.

And I have this working now without sweating the space in 64K of
firmware.  

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > 
> > First it isn't an immediate problem because with an ELF image you
> > don't need a multistage bootloader.  I can represent everything in one
> > file.  Essentially a sparse coredump.
> 
> 
> For what definition of "everything"?  I'm not being facetious, I think
> it's a fundamentally impossible statement to make, especially if the
> bootloader is interactive.

I know of no case for which a free-standing program or operating
system cannot be represented as an ELF image.  Essentially the
non-interactive case.

For the interactive case you can I agree you can't please everyone.
But if it is trivial to write the interactive bootloader, with size
being the only problem with naive implementations I don't see a
problem.  Though I suspect a bootloader running X will be overkill :)


> > If you are writing an intermediate loader it is a problem.  An
> > intermediate loader needs OS services, and if you don't have those
> > services you are in trouble.  For this purpose it is fair to call the
> > x86 BIOS,  EFI, the SRM, and open firmware OS's. 
> > 
> > Personally when I want an OS I would like to use Linux.  So I have
> > written a patch that allows me too load another OS from Linux, so in
> > those cases when I am writing an intermediate boot loader I can use
> > Linux.  I admit I haven't gracefully solved all of the bootstrapping
> > cases but that is just a matter of time.
> 
> 
> Your intermediate Linux still needs to have all its devices.  

Yep sure does.  

> I was
> working for a while on a project to create an "intermediate Linux" which
> wouldn't claim to own the world but instead callback to the firmware; this
> would be a port of Linux to a sort of pseudo-architecture.  I got a bit
> too busy, but I think it's a valid program.

I agree.  But I also think it is valid to directly drive the devices
if you never plan on having the firmware driving the again.  Or you at
least issue a firmware device reinitialization command before having
the firmware drive the device.

[snip PXE It doesn't matter if we agree]
 
> It's fundamentally about creating pervasive interfaces.  My problem with
> several of your proposals is that they make well-established interfaces
> *less* pervasisve, which is a huge step in the wrong direction.

I agree.  Except many of the pervasive interfaces today, do not
address my needs.  

In particular an x86 BIOS is terrible for clusters.  Where you have
hundreds of thousands of machines that you wish to manage remotely.  I
have tried.  I have worked with board vendors and BIOS manufacturers,
and at their best they can barely manage serial console support.  And
they really don't help with anything beyond that.  I have done a
better job with less code, in less time by rewriting the BIOS from
scratch.

So I am going to push for architecture neutral standards, that have
the potential to be even more pervasive than todays interfaces, because I
already need something different.  And a core part of that for me is
the ELF file format.  As I see it a bootloader saying everything is
ELF is as simplifying  as the unix everything is a file concept.

Eric
