Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275890AbTHOKCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275894AbTHOKCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:02:17 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:255 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S275890AbTHOKCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:02:07 -0400
Message-ID: <0b8801c36314$17890fa0$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60> <1060937593.604.14.camel@teapot.felipe-alfaro.com>
Subject: Re: Trying to run 2.6.0-test3
Date: Fri, 15 Aug 2003 19:00:10 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> replied to me:

> > 1.  Although both yenta and i82365 are compiled in, my 16-bit NE2000 clone
> > isn't recognized.  If I boot kernel 2.4.19 I can use the network, if I
> > boot kernel 2.6.0 I can't find any way to use the network.  Partial output
> > of various commands and files are shown below.
>
> What brand/model? What chipset does the card use? Are your sure it's
> PCMCIA (16-bit) and not CardBus (32-bit)?

I think it's Greenhouse ELP-10T.  But I think it doesn't matter.  Under
2.6.0-test3, "cardctl ident" couldn't even read the card's ID.  If it's
really necessary I can boot 2.4.19 to run "cardctl ident".  I don't know the
chipset but I think it doesn't matter.  As for knowing that it's 16-bit and
not 32-bit, even though I know you're even more of a volunteer than I am,
it's hard to keep civil about this.  Yes I know that it's 16-bit.  But even
if it magically changed to 32-bit, then the yenta driver should take over,
right?  But neither PCMCIA driver recognized the thing under 2.6.0-test3.
Oh, you might notice that "cardctl status" figured out that the thing takes
5 volts.  This is why I posted the outputs of "cardctl ident" and "cardctl
status" and the relevant part of .config.

> > 3.  For 2.6.0-test1, a few people kindly explained and provided a patch
> > to make the keyboard work with a plain text console, to get a pipe symbol
> > when not running under X.  How come 2.6.0-test3 still doesn't incorporate
> > that patch?
>
> Uh? A patch to make the pipe (|) symbol work?

Yes.  Read the archives about Japanese keyboards.  A patch was even POSTED,
in the -test1 days.  How come the patch didn't get into -test3?

> > 5.  Modules seem to work except for module symbols.  This seems to be a
> > result of compiling the new modules packages manually at a time when I
> > could not persuade the rpm --rebuild command to target the correct cpu.
> > Later I persuaded rpm --rebuild to work.  modprobe and lsmod and rmmod
> > work, only kernel symbols think that modules are disabled.
>
> Have you upgraded to latest modutils package? Modules are implemented
> quite differently in 2.6.

"seems to be a result of compiling the new modules packages manually at a
time when I could not persuade the rpm --rebuild command to target the
correct cpu."  Yes, "the new modules packages" meant the new modules
packages.  I did have to ask about this at the beginning of -test1 days.  (I
never had time to try testing a 2.5 kernel but the appearance of 2.6.0-test1
made it look like testing would become valuable.)

> > #
> > # PCI Hotplug Support
> > #
> > CONFIG_HOTPLUG_PCI=m
> > CONFIG_HOTPLUG_PCI_FAKE=m
>
> You don't need that.

I didn't think I needed it, but I didn't think it would hurt.  After all I
was trying to get some PCMCIA cards to work, and someday might try getting a
Cardbus card to work, and PCMCIA wasn't working yet, so I tried it.

> > (/var/log/messages)
> >
> > Aug 14 22:21:37 diamondpana kernel: cs: warning: no high memory space available!
> > Aug 14 22:21:37 diamondpana kernel: cs: unable to map card memory!
> > Aug 14 22:21:37 diamondpana last message repeated 3 times
> > Aug 14 22:22:49 diamondpana last message repeated 7 times
> > Aug 14 22:23:35 diamondpana last message repeated 3 times
> > Aug 14 22:24:40 diamondpana last message repeated 3 times
> > Aug 14 22:29:07 diamondpana kernel: cs: unable to map card memory!
>
> It seems the kernel is having problems assigning resources to your card.
> Plase, edit "/etc/pcmcia/config.opts" and uncomment the following line:
>
> #include port 0x1000-0x17ff

This I will take a look at.  Thank you.  Though it makes me curious why
2.4.19 didn't need this, I will try it.  And I think I will have no problem
remaining civil while discussing it.  Thank you.

> > Kernel command line: acpi=off apm=on root=/dev/hda8
>
> I suggest you to recompile your kernel with ACPI support to see if it
> works correctly. Else, recompile it disabling ACPI support and enabling
> APM support.

Guess why I compiled it without ACPI support and with APM support.  Guess
why my kernel command line has acpi=off apm=on.  (Although the command line
options are redundant with the self-compiled kernel configuration, they are
necessary when booting a generic kernel.  Yes I know that the machine has
just enough ACPI hooks to cause problems when anyone other than Windows 98
tries to use ACPI.  It's not even recommended to force ACPI on when
installing Windows 98 on this machine.  Windows 2000 blue screens if ACPI is
forced on.  Linux doesn't panic when its default ACPI takes over, but it
does prevent APM from working.)

> > No local APIC present or hardware disabled
>
> You can remove APIC support from your config. It's not supported by your
> hardware.

Fine, but I didn't think I had to worry about that, since it looked like
Linux already properly detected the fact.

> > PCI: IRQ 0 for device 0000:00:01.2 doesn't match PIRQ mask - try pci=usepirqmask
> > PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
> > PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
>
> Please, add "pci=usepirqmask" to your kernel command line in GRUB/Lilo.

Oh, that could be it, I just noticed that the second and third occurences
relate to the PCMCIA slots.  May I ask though, what PIRQ mask is it, that is
failing to be matched?  It seems to me that it might be more useful for
2.6.0 to do as good a job as 2.4.19 did in figuring out the IRQs, and I
would like to continue testing this.  (Probably I can only spend about one
day a week on it though.)

