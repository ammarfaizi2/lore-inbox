Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDJRxW>; Tue, 10 Apr 2001 13:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRDJRxC>; Tue, 10 Apr 2001 13:53:02 -0400
Received: from [204.163.170.2] ([204.163.170.2]:34790 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S130507AbRDJRxA>;
	Tue, 10 Apr 2001 13:53:00 -0400
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C1A1@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Axel Thimm'" <Axel.Thimm@physik.fu-berlin.de>,
        "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Still IRQ routing problems with VIA
Date: Tue, 10 Apr 2001 10:52:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Thimm said...
> On Tue, Apr 10, 2001 at 09:51:18AM -0700, Manuel A. McLure wrote:
> > I have the same motherboard with the same lspci output 
> (i.e. I get the "pin
> > ?" part), but I don't see any problems running 2.4.3 or 
> 2.4.3-ac[23]. I am
> > only using a trackball on my USB port - what problems are 
> you seeing?
> 
> Well, a part of the attached dmesg output yields:
> 
> > PCI: Found IRQ 11 for device 00:07.2
> > IRQ routing conflict in pirq table for device 00:07.2
> > IRQ routing conflict in pirq table for device 00:07.3
> > PCI: The same IRQ used for device 00:0e.0
> > uhci.c: USB UHCI at I/O 0x9400, IRQ 5
> 
> and later:
> 
> > uhci: host controller process error. something bad happened
> > uhci: host controller halted. very bad
> 
> 0.7.[2,3] are the usb devices. BIOS (and 2.2 kernels) had 
> them at IRQ 5. 2.4
> somehow picks the irq of the ethernet adapter, iqr 11, instead.
> 
> At least usb is then unusable.
> 
> As you say that you have the same board, what is the output 
> of dump_pirq - are
> your link values in the set of {1,2,3,5} or are they 
> continuous 1-4? Maybe you
> are lucky - or better say, I am having bad luck :(
> -- 
> Axel.Thimm@physik.fu-berlin.de
> 

I am getting IRQ routing conflict messages:

Apr  8 21:32:47 ulthar kernel: usb.c: registered new driver usbdevfs
Apr  8 21:32:47 ulthar kernel: usb.c: registered new driver hub
Apr  8 21:32:47 ulthar kernel: usb-uhci.c: $Revision: 1.251 $ time 18:28:42
Apr
  6 2001
Apr  8 21:32:47 ulthar kernel: usb-uhci.c: High bandwidth mode enabled
Apr  8 21:32:47 ulthar kernel: PCI: Found IRQ 11 for device 00:07.2
Apr  8 21:32:47 ulthar kernel: IRQ routing conflict in pirq table for device
00
:07.2
Apr  8 21:32:47 ulthar kernel: IRQ routing conflict in pirq table for device
00
:07.3
Apr  8 21:32:47 ulthar kernel: PCI: The same IRQ used for device 00:0a.0
Apr  8 21:32:47 ulthar kernel: PCI: The same IRQ used for device 00:0e.0
Apr  8 21:32:47 ulthar kernel: usb-uhci.c: USB UHCI at I/O 0xa400, IRQ 9
Apr  8 21:32:47 ulthar kernel: usb-uhci.c: Detected 2 ports
Apr  8 21:32:47 ulthar kernel: usb.c: new USB bus registered, assigned bus
numb
er 1
Apr  8 21:32:47 ulthar kernel: hub.c: USB hub found
Apr  8 21:32:47 ulthar kernel: hub.c: 2 ports detected
Apr  8 21:32:47 ulthar kernel: PCI: Found IRQ 11 for device 00:07.3
Apr  8 21:32:47 ulthar kernel: IRQ routing conflict in pirq table for device
00
:07.2
Apr  8 21:32:47 ulthar kernel: IRQ routing conflict in pirq table for device
00
:07.3
Apr  8 21:32:47 ulthar kernel: PCI: The same IRQ used for device 00:0a.0
Apr  8 21:32:47 ulthar kernel: PCI: The same IRQ used for device 00:0e.0
Apr  8 21:32:47 ulthar kernel: usb-uhci.c: USB UHCI at I/O 0xa800, IRQ 9
Apr  8 21:32:47 ulthar kernel: usb-uhci.c: Detected 2 ports
Apr  8 21:32:47 ulthar kernel: usb.c: new USB bus registered, assigned bus
numb
er 2
Apr  8 21:32:47 ulthar kernel: hub.c: USB hub found
Apr  8 21:32:47 ulthar kernel: hub.c: 2 ports detected

However I am not seeing any problems caused by this (however I do not use
USB very much, as I mentioned - only for a trackball). I also got the same
messages on my K7T Pro which used the KT133 chipset, however, so I don't
think this is a KT133/KT133A issue.
I can't seem to find dump_pirq on my system (Red Hat 7) - I can run it if I
find it...

Jeff Garzik said:
>Changing '#undef DEBUG' to '#define DEBUG 1' in
>arch/i386/kernel/pci-i386.h is also very helpful.  Can you guys do so,
>and post the 'dmesg -s 16384' results to lkml?  This includes the same
>information as dump_pirq, as well as some additional information.

I'll do that and get back to you - I'll have to physically be at my machine
to reset the BIOS to "PNP: Yes" so it won't be until I get home from work.

>Note that turning "Plug-n-Play OS" off in BIOS setup typically fixes
>many interrupt routing problems -- but Linux 2.4 should now have support
>for PNP OS:Yes.  Clearly there appear to be problems with that support
>on some Via hardware.
>
>Note that you should have "Plug-n-Play OS: Yes" when generated the
>requested 'dmesg' output.

This may be the difference - I always set "Plug-n-Play OS: No" on all my
machines. Linux works fine and it doesn't seem to hurt Windows 98 any.

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."
