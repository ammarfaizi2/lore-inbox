Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290932AbSAaFT1>; Thu, 31 Jan 2002 00:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290933AbSAaFTS>; Thu, 31 Jan 2002 00:19:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60980 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S290932AbSAaFTM>; Thu, 31 Jan 2002 00:19:12 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2002 22:15:40 -0700
In-Reply-To: <3C58CAE0.4040102@zytor.com>
Message-ID: <m1r8o7ayo3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > I am reluctant to go with a bootimg like interface because having a
> > standard format encourages people to standardize.  Though a good
> > argument can persuade me.  I don't loose any flexibility in comparison
> > to bootimg because composing files on the fly is not significantly
> > harder than composing a bootable image in ram. Please tell me if I haven't
> > clearly answered your concerns about
> > being locked into a single image.
> >
> 
> 
> I have to think about it.  I'm not convinced that this particular flavour of
> standardization is a step in the right direction -- in fact, it is *guaranteed*
> to provide significant additional complexity for bootloaders, and bzImage
> support is still going to have to be provided for the forseeable
> future.  

It is not my intention to deprecate bzImage at this time.  But instead
to provide an alternative.  

> Since
> you express that it will basically be necessary to stitch the ELF file together
> on the fly I don't see much point, quite frankly; it seems like extra complexity
> for no good reason.

This part is only for people using the kernel as a bootloader.  My
apologies if I didn't make it clear. 


Let me clarify a little with usage.  I have three cases I am targeting.
1) LinuxBIOS.  
    I need a kernel format that doesn't unconditionally do 16bit BIOS
    queries, as there is no 16bit code in LinuxBIOS.  bzImage doesn't
    work.

2) Portability.  
   For this I have with some simple bootstrap program that loads the
   kernel.  And then I have the kernel driving devices and acting a
   super bootloader.  Something like Grub but with the full power
   linux can bring to bear on the issue.  This is all I need to
   standardize the user booting experience on multiple platforms.

3) Network Booting.
   There is not much chance to change bootroms once they are flashed
   so they like LinuxBIOS need a general purpose interface, so that can
   handle whatever they need to boot.

On the dynamic stitching/initramfs side, the code should really be no
more complex than the current bzImage loading with ramdisks.  And if
bootloaders want to keep it simple can drop any optional ELF features,
which should be much simpler than todays bzImage.

Now I will shut up and let you digest this.

Eric
