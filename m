Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265491AbTFSIWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTFSIWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:22:19 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:24960 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265491AbTFSIWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:22:16 -0400
Date: Thu, 19 Jun 2003 09:43:46 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306190843.h5J8hksF000540@81-2-122-30.bradfords.org.uk>
To: andre@linux-ide.org, andre@linuxdiskcert.org, despair@adelphia.net,
       linux-kernel@vger.kernel.org, misty-@charter.net
Subject: Re: Problems with IDE on GA-7VAXP motherboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please forgive me if I've sent this to the wrong address, it is the one
> listed in the 2.4.21 sources in the MAINTAINERS file as the IDE
> maintainer.

> Okay, I've spent a LONG time (>48 hrs) trying to fix this problem on my own, and I
> have no idea what is causing this totally weird behavior.

> I just recently replaced a broken system with a new gigabyte GA-7VAXP
> motherboard and an athlon XP 2600 cpu. The Gigabyte motherboard has the
> Via VT82C586/B/686A/B (according to lspci -v) chipset on ide0, which is
> being used for the WDC WD102AA hard disk (according to
> /proc/ide/ide0/hda/model)

I have two Gigabyte GA-7VA based machines here with Athlon XP 2200+
cpus.  This board also uses the VT82C586B chipset for IDE. 

They works fine here, except for mis-detection of a 40-way cable as
80-way, (and the devices on the 40-way cable only support a maximum of
33.3MB/s anyway, so it's not a big problem at the moment). 

> I have disabled everything I possibly could in the bios without making
> it impossible to boot the system. I have tried using the original cables
> from the old machine, as well as the new cables that came with the
> motherboard. I have tried the hard disk in both master and cable select modes.
> I have both enabled and disabled ACPI, to see if that would make it
> work. I have tried moving the hard disk to a different ide channel. I
> have removed all other hard disks from the system. (All are experiencing
> the problems, not just this one) I have asked everyone I know that knows
> anything about computers what could be wrong - most of their replies were
> variants of the above.

The default BIOS settings worked fine for me.  I notice you've got the
IO-APIC enabled - I've left it disabled, basically because I don't
need the functionality yet, and it avoids any bugs in the kernel
IO-APIC code.

> The problem I'm seeing is, even with literally every single setting
> disabled in hdparm, the system is VERY VERY SLOW, and I'm often seeing
> 'hda: lost interrupt' in console when I try to read/write a large amount
> of data.

Hmmm, try disabling IO-APIC.

> It's so bad I'm actually having to compile my kernels on a separate
> pentium 1 133 because it's compiling them *faster* than my computer can.

Heh, must take about an hour :-).  My rarely-used MMX-200 compiles
recent 2.4 trees in about 30-40 minutes.

> I am currently using the 2.4.21 kernel, although I started trying this
> on the 2.4.20 kernel. Both exhibit the same problem unfortunately.

I've used 2.4.21-RC1 and 2.4.21-RC2 on these boxes without problems,
but I've been too busy to try more recent trees.  I did boot a recent
2.5 tree on one of them, and it booted successfully, but I didn't do
much testing, (due to lack of time).  I installed KDE, and noticed
that it was much slower to start under 2.5, but I've not investigated
that.

> I am familiar with patching kernels, and am able to fix cosmetic to
> minor problems in source, so sending me a patch and saying 'try this'
> isn't a problem.

> I *am* willing to experiment and try using 2.5.whatever but *only* if
> the ide maintainer or someone familiar with the ide subsystem tells me
> that it's safe to use in a certain configuration. I don't want to lose
> the data on my hard disk, it doesn't have a backup. (long story short, I
> was about to do a backup on the machine when the motherboard blewup.
> Seriously!)

If you don't enable exotic options like IO-APIC and ACPI, I seriously
doubt you'll get massive file corruption.  The only reasons I'm not
using 2.5 as a deault on most of my production boxes, are time and
security fixes not having gone in yet.

> If someone gives me a patch which makes the machine stable and able to
> work even if it's *slow* I'll be happy. I don't want the thing to lose
> data, and the message the kernel is giving me could be really really bad
> IIRC if it's trying to write when it loses the interrupt. :(

Try booting a 2.5 kernel, and mount the root filesystem read-only if
you're really worried about corruption.

> I currently am limited to using a keyboard only, and I'm stuck in
> console as I am unable to use X windows due to problems I was attempting
> to fix before the original system blewup. So... it's hard for me to copy
> and paste anything - I have to type it in manually. I would fix X, but
> considering doing 'make dep' on a 2.4.21 kernel currently takes longer
> on my XP 2600 system than it does to compile the *entire kernel* on a P1
> 133 (I'm stone cold serious.) ... ... ... No. Until I can get this fixed, I can't fix X.

> I have attached output from lspci -v, /proc/interrupts, my kernel
> .config and /proc/ioports in the hopes it is useful to you.
> (You'll likely notice I've thrown the kitchen sink at it. *shrugs*)

> If you can think of *anything* I can send you that might clear up this
> problem, ask for it.

Compile a minimal kernel without things like IO-APIC and ACPI
enabled.

Oh, I don't use modules by the way, so any issues with things being
compiled as modules won't be apparent to me :-).  So, you might want
to try compiling everything in.

John.
