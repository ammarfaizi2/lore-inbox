Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbRGFF1v>; Fri, 6 Jul 2001 01:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbRGFF1k>; Fri, 6 Jul 2001 01:27:40 -0400
Received: from [63.231.122.81] ([63.231.122.81]:3416 "EHLO
	cthulhu.turbolabs.com") by vger.kernel.org with ESMTP
	id <S264976AbRGFF1X>; Fri, 6 Jul 2001 01:27:23 -0400
Date: Thu, 5 Jul 2001 23:26:55 -0600
From: Andreas Dilger <adilger@turbolabs.com>
Message-Id: <200107060526.XAA11829@cthulhu.turbolabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff writes:
> I've always thought it would be neat to do:
> 
>       cat bzImage initrd.tar.gz > vmlinuz
>       rdev --i-have-a-tarball-piggyback vmlinuz
> 
> Linking into the image is easy for hackers, but why not make it
> scriptable and super-easy for end users?  x86 already has the rdev
> utility to mark a kernel image as having certain flags.  It could even
> be a command line option, "inittgz" or somesuch, telling us that a
> gzip-format tarball immediately follows the end of our ELF image.

This would be especially handy for network booting: you only need to send
the one file to the client, and it boots the kernel and loads the initrd
without any extra requests/parameters/configuration needed.

> I wonder if any bootloader mods would be needed at all to do this... 
> AFAICS you just need to make sure the kernel doesn't trample the
> piggyback'd data.

Probably not - the kernel would handle all of it.  It sounds like Linus
and Al are in favour of this, so it will likely be in 2.5.early.  Having
the tar be extracted into ramfs has the added benefit that you don't need
to 'pre-configure' ramdisk size, make dd initrd images, or waste memory
that is representing empty fs space.  Conversely, if the root is ramfs
you also don't need to worry about the ramdisk fs being too small if you
need to create some temprary files there...  It is a win in all cases.

Cheers, Andreas
-- 
Andreas Dilger                               Turbolinux filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
