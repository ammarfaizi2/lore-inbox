Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284557AbRLIWQq>; Sun, 9 Dec 2001 17:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284548AbRLIWQ1>; Sun, 9 Dec 2001 17:16:27 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:50346 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S284545AbRLIWQH>; Sun, 9 Dec 2001 17:16:07 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: "ChristianK."@t-online.de (Christian Koenig)
To: Richard Todd <richardt@vzavenue.net>
Subject: Re: [PATCH] Making vmlinux Multiboot compliant and grub capable of loading modules at boot time. (1 Part)
Date: Sun, 9 Dec 2001 23:17:18 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <16ChzA-1vH6GWC@fwd01.sul.t-online.com> <20011210015114.A1003@localhost.localdomain>
In-Reply-To: <20011210015114.A1003@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org, richardt@vzavenue.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <16DCEp-0PsFKCC@fwd01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 10 December 2001 02:51, Richard Todd wrote:
> On Sat, Dec 08, 2001 at 02:59:18PM +0100, Christian Koenig wrote:
> > The patch is for 2.4.14 Kernel Source, but it should patch well on other
> > Versions (at least the module loader).
>
> It patched 2.5.1-pre8 cleanly, except for a makefile.  I'm running
> 2.5.1-pre8 with this patch right now.
>
> > I know that vmlinux isn't compressed and contains unused elf-sections.
>
> Just 'gzip -9 vmlinux'  Grub will uncompress it for you.
> This actually makes for a smaller file than bzImage (on
> my machine, anyway).
>
> Are the unused sections taking up space at runtime?

No, its only the .note & .comment section.

objcopy -R .note -R .comment  -S vmlinux mImage
gzip -9 mImage

makes a very nice & small Kernel Image.

(This will always be smaller than bzImage, 
because the compression / bsetup and bootsector code isn't inside the Kernel).

> > Tell me what you thing about it.
>
> It's a cool hack!  I like grub's module loading mechanism
> better than the initrd solution.

:-)

>
> Unfortunately, grub doesn't run on all supported platforms.
> And the multiboot specification isn't an accepted standard.
> (grub docs just read like it is.....)

The Module loader isn't really grub specified, 
at least do you know any bootloader who works on every platform 
Linux supports ?

And what's wrong with the multiboot specification ?
OK it is highly i386 Specified, but it defines the minimal things a 
boot-loader should do for the kernel (multiple Kernel Modules, a commandline, 
a memorymap ....). 

The main problem with my patch for the moment is that the code I have copied 
from insmod is really ugly. 
For example obj_load.c allocates memory without freeing it after an error 
(i have fixed this, but i think it's only 1 of 100 memory leaks this code 
have).

This works in an elf-program quiet well, but you can't do that inside the 
Kernel.

Somebody with real god knowledge off elf-object files should take a look at 
this 

MfG, Christian König.

I can not promise you that this patch work, but i can promise you i will 
do my best to make it working. (Sorry for my poor English).
