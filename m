Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271805AbRIHSz1>; Sat, 8 Sep 2001 14:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271811AbRIHSzS>; Sat, 8 Sep 2001 14:55:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271805AbRIHSzD>; Sat, 8 Sep 2001 14:55:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
Date: 8 Sep 2001 11:55:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ndpi8$64u$1@cesium.transmeta.com>
In-Reply-To: <E15cx6w-00049f-00@the-village.bc.nu> <m1iteth8j8.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1iteth8j8.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
>
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > > So of course I realize this wouldn't happen any time soon, but has any
> > > discussion taken place regarding enhancing the bootloader (grub? Steal
> > > FreeBSD's?) to load modular drivers very early, and possibly abstracting
> > > SMP/UP from the kernel proper? Wouldn't this be a better solution than
> > > initrd?
> > 
> > All the discussion we have has been based on seriously enhancing and
> > expanding the use of the initrd/ramfs layer. Remember we can begin running
> > from ramfs without interrupts, pci bus scans or the like. The things it cant
> > do are - pick a kernel by processor type, pick SMP/non SMP.
> > 
> > As it happens both of those are things that are deeply buried in the whole
> > compile choices and how we generate the code itself - so they do need to
> > be boot loader driven (or user driven)
> > 
> > So the path for ACPI could indeed go
> > 
> > load kernel
> > load initial ramfs
> > Discover we have ACPI
> > load acpi core
> > load acpi irq router
> > load acpi timers
> > [init hardware]
> > load ide disk
> > load ext3
> > mount /
> 
> Sounds about right.  
> 
> If we really need to do weird things like pick a kernel by processor
> type, or pick SMP/non SMP.  You can even do those from an initramfs
> with a linux  booting linux kernel patch.
> 

I discussed something like this before using "Genesis"; the idea
behind it was to make sure we have enough modules to access the
filesystem before the kernel starts (by using pre-initialization code
that can read filesystem using the firmware interface.)  Unfortunately
life got busy on me, but I still think that it is probably the right
way to approach this.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
