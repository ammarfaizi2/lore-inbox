Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSGOKMA>; Mon, 15 Jul 2002 06:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317416AbSGOKMA>; Mon, 15 Jul 2002 06:12:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56895 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317415AbSGOKL5>; Mon, 15 Jul 2002 06:11:57 -0400
To: Kirk Reiser <kirk@braille.uwo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
References: <E17T2P5-0003DF-00@the-village.bc.nu>
	<x7hej5djbj.fsf@speech.braille.uwo.ca>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jul 2002 04:03:27 -0600
In-Reply-To: <x7hej5djbj.fsf@speech.braille.uwo.ca>
Message-ID: <m1adotpats.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Reiser <kirk@braille.uwo.ca> writes:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > This is how Nicholas stuff works, you can still get the kernel messages
> > by scrolling back. I'm told this meets S508.
> 
> I don't give two shits about S508.  For one thing that is a
> U.S. statute.  It has no relevance here.
> 
> > Actually some of this is true for sighted people. You only get console
> > messages after PCI is initialised, until then they are queued away or
> > only on serial console.
> 
> Even though, pci gets initialized pretty early in the boot sequence
> doesn't it?  Considerably before init?

Some.  Depending on how all of this works, in 2.5.x it should be possible
to get initramfs mounted and running very early on.  But there are definitely
classes of problems that are not solved.
 
> > If you are using a conventional BIOS then the first kernel messages being
> > readable as they occur versus just after seems to have only a little value.
> > If you have a fully accessible LinuxBIOS thats something quite different.
> > In that case can you use a Linuxbios hook for the console speech until
> > user space takes over ?
> 
> I don't really know.  I haven't had time to really get into the BIOS
> accessibility yet.  I know for serial synths we can turn serial on in
> lilo and at least hear what is going on.  Without modifying lilo for
> each synth other than serial we have no way of knowing whether we have
> the full lilo prompt or what.
> 
> If we could modify a linux BIOS and then flash it onto any flashable
> BIOS that would be really useful.

There are some pieces that the LinuxBIOS people could do.

The overall architecture is divided into two pieces
1) LinuxBIOS which simply initializes the hardware.
2) Bootloader (which may be based on Linux, but is usually a hacked
   version of etherboot) which loads the kernel from some hardware
device. 

Rom chips range from 256Kilobytes to 1Megabyte, with 256KB being the
median.  So there isn't room for a lot of unnecessary fluff.  

The bootloader is reusable while the core LinuxBIOS is not, it is just
a matter of selecting the correct firmware.

The current architecture does allows for all BIOS parameters to be set
from Linux so there is an accessibility gain there.

Given the space constraints on the BIOS side, either a very small
standalone speach synthsizer needs to be constructed, or more likely
a set of tones (that can work like post codes) can be introduced
to give a feel where in the boot process the BIOS is.

After that a nice bootloader based on the Linux kernel with a real
user space can be loaded from the hard drive where there is plenty of
room.  Everything that possibly could would need to be built as
modules to decrease the time to user space, and to allow as many
messages to be processed by the speech synthesizer.

People doing serious kernel development would need more extensive
facilities, but this should suffice for basic trouble shooting.  If
there is a standard brail output device,  there may be solutions I am
not familiar with.

Eric
