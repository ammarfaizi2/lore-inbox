Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVGPGfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVGPGfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 02:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVGPGfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 02:35:46 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:2904 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261909AbVGPGfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 02:35:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Haninger <ahaning@gmail.com>
Subject: Re: PS/2 Keyboard is dead after resume.
Date: Sat, 16 Jul 2005 01:35:38 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <105c793f0507141935403fc828@mail.gmail.com> <200507150024.46293.dtor_core@ameritech.net> <105c793f0507150443b1e8359@mail.gmail.com>
In-Reply-To: <105c793f0507150443b1e8359@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507160135.39220.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Suspend2 was removed from CC as it appears to be subscribers-only list.]

On Friday 15 July 2005 06:43, Andrew Haninger wrote:
> On 7/15/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > Could you try doing:
> > 
> >         echo 1 > /sys/modules/i8042/parameters/debug
> > 
> > before suspending and the post your dmesg, please? Maybe we see something
> > there.
> Here you go:
> 
> 12) *0, disabled.

Ok, so you start with IRQ 12 disabled.. You don't have a PS/2 mouse,
do you?

...
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1

You did not select PNP support (but as far as keyboard controller settings
go we don't trust it anyway on i386).

...
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
> PCI: setting IRQ 12 as level-triggered
> ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKA] -> GSI 12 (level,
> low) -> IRQ 12
> PCI: Via IRQ fixup for 0000:00:0f.0, from 255 to 12
> VP_IDE: chipset revision 6
...
> USB Universal Host Controller Interface driver v2.2
> ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 12 (level,
> low) -> IRQ 12
> uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:10.0: irq 12, io base 0x0000d000
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 12 (level,
> low) -> IRQ 12
> uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (#2)
> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:10.1: irq 12, io base 0x0000d400

And here you have a bunch of hardware gets assigned to IRQ 12...
Hmm, I tought ACPI would try not use 12 unless it is absolutely
necessary. What appens if you use "pci=routeirq" boot option?

> drivers/input/serio/i8042.c: 60 -> i8042 (command) [154857]
> drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [154857]
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [154857]
> drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [154857]
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [154857]
> drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [154857]
> drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [154857]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154860]
> drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [154861]
> drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [154862]
> drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [154862]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154865]
> drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [154865]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154867]
> drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [154867]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154870]
> drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [154870]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154873]
> drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [154873]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154876]
> drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [154876]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154879]
> drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [154879]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [154881]

Keyboard seems to be resumed just fine...

> 20%...40%...60%...80%...100%...done.
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [155414]
> drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [155414]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [155414]
> drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [155414]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [155417]
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
> might be trying access hardware directly.
> drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [155418]

But when we try to talk to mouse port we ket response from the keyboard
and something gets confused.

You can try working around this with "i8042.noaux" kernel boot option,
but we should probably teach i8042 driver to not touch AUX port on resume
if it was disabled.

-- 
Dmitry
