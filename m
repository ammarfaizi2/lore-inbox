Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291619AbSBAJHy>; Fri, 1 Feb 2002 04:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291618AbSBAJHo>; Fri, 1 Feb 2002 04:07:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51254 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S291612AbSBAJH3>; Fri, 1 Feb 2002 04:07:29 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2002 02:03:44 -0700
In-Reply-To: <3C59DB56.2070004@zytor.com>
Message-ID: <m1r8o5a80f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > 
> > I already need a new format for LinuxBIOS, because I can't use
> > bzImages.  
> > 
> 
> [...]
> 
> > 
> > Personally I think all of that is just flawed.  The bootloaders should
> > be simple.  They should be able to load the ramdisk at a fixed address
> > (assuming the memory isn't reserved).   And they shouldn't need to be
> > changed every time the kernel has a problem.
> > 
> 
> 
> And your solution is to come up with a new format that is (a) MORE
> complex, (b) DIFFERENT, (c) incompatible?

a) More complex.  Just barely.  
b) Yep.
c) Yep.
d) More flexible and can handle what ever it needs to do tomorrow,
   without mods. 

All firmware has it's own different format.  With LinuxBIOS things are
simple enough that you can add a make target instead of having to
write a specific bootloader to support it.

> Give me a break.  You have just added so much complexity it's not even
> funny.  

The only thing I have seen that is terribly complex is when I wrote a
though shalt paper, my draft specification.  Specing out in
excruciating detail how everything needs to be setup.  That takes a
simple idea and makes it sound terribly complex.  I need to rewrite
that before I get much farther.  I added flexibility not complexity.

In practice all I have added is a 32bit entry point and a for loop.

> I can guarantee you that people *WILL* ask for every single
> existing bootloader out there to support your new format.  It's a support
> nightmare for all of us that write bootloaders, and not just for
> you.

Hmm.  Supporting a format that has needed no changes since it's 1.0
release a decade ago, is going to be a support nightmare?  

I know it is slightly more general than the current x86 home grown
solution so that is a bit harder.  

Having a format that allows a cross platform implementation of rdev is
a support nightmare?

I am in no way promoting using any of the ELF relocation support I
have made that clear right?


> If your complaint is about the lack of a 32-bit entrypoint such can
> probably be added to the existing format (it would require

If adding a 32bit entry point to bzImage is really a more palatable
solution I can probably handle that.  But it will take some
convincing.  

And then I will go out and write a utility to convert that to an ELF
image, for when  want to network boot or load it from LinuxBIOS.  But
in that sense it will be just a bootloader.  So will be less likely to
generate demand that everyone else support the ELF format for booting...

> Oh, and as far as "simple" is concerned, I should let you know that when I
> work on syslinux, I count bytes.  

O.k. for a size comparison.  I just built the LinuxBIOS elf bootloader
with a floppy driver for reading the disk, and a serial driver for
writing output, all 32 bit C code.  With debugging messages compiled
in it was ~= 11K with debugging messages compiled out it was ~= 7K.

That is a very general bootloader that has practically every optional
feature implemented, and there has been no real attempt at space
optimization, and the drivers are direct to hardware drivers.
Admittedly it is a noninteractive bootloader.

Is that simple enough?

> The existing protocol is definitely
> suboptimal in that respect (this is due to some severe mistakes which were
> done in the original initrd implementation), but we're stuck with it.  All
> you're accomplishing is creating two completely incompatible formats,
> *BOTH* of which will need to be supported for the forseeable future.

And on that score I can do deeper work.  Would it be more palatable
if there were utilities to convert from one format to the other
without losing of information?

Eric
