Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273787AbRIXD6C>; Sun, 23 Sep 2001 23:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273788AbRIXD5w>; Sun, 23 Sep 2001 23:57:52 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:33038 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S273787AbRIXD5f>; Sun, 23 Sep 2001 23:57:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5
Date: Sun, 23 Sep 2001 23:57:24 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15l2tb-0004KK-00@wagner> <E15l3Qu-0005YQ-00@schizo.psychosis.com> <20010924100942.0a37db8d.rusty@rustcorp.com.au>
In-Reply-To: <20010924100942.0a37db8d.rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15lMrA-0006ny-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 September 2001 20:09, you wrote:
> On Sun, 23 Sep 2001 03:12:54 -0400
>
> David Cinege <dcinege@psychosis.com> wrote:
> > On Sunday 23 September 2001 2:37, Rusty Russell wrote:
> >
> > Russ,
> >
> > How about implementing MBS? (Bootloader module loading. IE as implmented
> > in GRUB) so we can finally have completely modular kernels?
>
> Hi Dave,
>
> 	Why duplicate the module code in the boot loader?  Surely a tiny initrd
> or equiv is a better option here?

Russ,

No. It's much more restrictive. IMO the JOB of the boot loader is to provide 
minimal lowest level (arch dependant) device access to load and initialise 
the kernel, with enough user control to manipulate how the kernel
is initialised. GRUB does a fantastic job of this on x86. It's the first 
bootloader I've seen 'get it right'.

I don't suggest implementing the complete module loading in the boot loader,
(I'm still not even sure I really like it in the kernel.  ; > )
only loading the modules themselves into memory for the kernel access during 
it's exec. (Like an initrd image is loaded) If a boot loader wants to 
understand and use modules.dep or do on the fly dependency checking, or have 
kernel userland utils to update it's conifg intelligently, that's it's 
business. I only want to see a way modules can be preloaded before kernel 
exec.

This has already been designed and is called the Multi Boot Standard.
You can read the spec in the GRUB source archive.
	http://www.gnu.org/software/grub/
It been around a few years. It's sad only HURD(?) is using it,

Why an initrd solution doesn't even touch on the problem:
You have a kernel.
	It's scsi layer and scsi device drivers are all modules.

You have a system.
	It contains a single scsi drive.
	The kernel and modules reside on that drive.

Now the impossible exercise.
	Get that machine the boot.

All the parts are there but you can't. Your only option is to use an initrd 
that has the required modules *merged* into it. This is just disgusting and 
silly. It's also impossible to make that initrd on that machine without a 
suplementary system. (Yes there are other ways around this by why not just 
KISS???)

We ALREADY have the boot loader and spec designed to allow reloading
modules into memory this way. (GRUB) It should not be very hard to implement 
this from the pre-existing Linux intird code to read the modules out. It's 
also easy for other boot loaders to use their initrd code to implement the 
functionality. (Remember when you think about it's usefulness put it in the 
perspective of bootloaders that can read from a filesystem. IE GRUB and 
Syslinux.)

Please let's do this already...
I look forward to one day reaching the point it's *reasonable* to have a 
completely modular kernel and that any device drivers (even boot devices) can 
be upgraded without having to update the entire kernel.

If you've never played with GRUB yet, you can grab a nice raw floppy image 
from my ftp site.  ftp://ftp.psychosis.com/linux/grub

Dave
