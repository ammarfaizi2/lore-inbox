Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWFRS05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWFRS05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWFRS05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:26:57 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:19815 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751203AbWFRS04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:26:56 -0400
From: David Brownell <david-b@pacbell.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [linux-usb-devel] 2.6.17: dmesg flooded with "ohci_hcd 0000:00:02.0: wakeup"
Date: Sun, 18 Jun 2006 11:16:19 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200606181919.51126.arvidjaar@mail.ru> <200606180929.23119.david-b@pacbell.net> <200606182129.15712.arvidjaar@mail.ru>
In-Reply-To: <200606182129.15712.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181116.20815.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 10:29 am, Andrey Borzenkov wrote:
> On Sunday 18 June 2006 20:29, David Brownell wrote:
> 
> > An alternative (but post-boot) workaround _should_ be
> >
> >     echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup

Did that work?


> This is Tohiba Portege 4000 notebook. So far I did not have any USB related
> issues at least since 2.6.12. And true, I do not have any devices plugged in.

It's the usual case of fixing one bug triggering another, in your case
because the fix ran into a previously unseen hardware bug.  One other
way to work around that bug would be disabling CONFIG_PM, but I suspect
you don't want to go that route...


> Here you are. I am still puzzled where all these "suspends" come from - I did
> not try any suspend in the meantime ...

It's the driver putting the controller into a low power state.  Your
hardware seems to have a bug whereby that doesn't work correctly,
making it immediately leave that state.  (And the driver messaging is
fine for what should be an uncommon event; plus it highlighted your
hardware bug.)  Notice the "initreset quirk" message -- another bug
in that hardware.  Workarounds in both cases are simple.

When I get a moment, I'll have a patch for you to try.  Meanwhile,
either workaround I showed above should prevent the attempt to enter
that low power mode.

- Dave



> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ohci_hcd: block sizes: ed 64 td 64
> ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) ->
> IRQ 11
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> /home/bor/src/linux-git/drivers/usb/core/inode.c: creating file 'devices'
> /home/bor/src/linux-git/drivers/usb/core/inode.c: creating file '001'
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
> ohci_hcd 0000:00:02.0: created debug files
> ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
> ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x0
> ohci_hcd 0000:00:02.0: enabling initreset quirk
> ohci_hcd 0000:00:02.0: OHCI controller state
> ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
> ohci_hcd 0000:00:02.0: control 0x083 HCFS=operational CBSR=3
> ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
> ohci_hcd 0000:00:02.0: intrstatus 0x00000044 RHSC SF
> ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
> ohci_hcd 0000:00:02.0: hcca frame #0003
> ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3(3)
> ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
> ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
> ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
> ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
> ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
> usb usb1: default language 0x0409
> usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: OHCI Host Controller
> usb usb1: Manufacturer: Linux 2.6.17-2avb ohci_hcd
> usb usb1: SerialNumber: 0000:00:02.0
> usb usb1: uevent
> usb usb1: configuration #1 chosen from 1 choice
> usb usb1: adding 1-0:1.0 (config #1, interface 0)
> usb 1-0:1.0: uevent
> hub 1-0:1.0: usb_probe_interface
> hub 1-0:1.0: usb_probe_interface - got id
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> hub 1-0:1.0: standalone hub
> hub 1-0:1.0: no power switching (usb 1.0)
> hub 1-0:1.0: global over-current protection
> hub 1-0:1.0: power on to power good time: 2ms
> hub 1-0:1.0: local power source is good
> hub 1-0:1.0: no over-current condition exists
> hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> /home/bor/src/linux-git/drivers/usb/core/inode.c: creating file '001'
> ohci_hcd 0000:00:02.0: suspend root hub
> hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
> hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> ohci_hcd 0000:00:02.0: suspend root hub
> hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
> hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> ohci_hcd 0000:00:02.0: suspend root hub
> hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
> hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> ohci_hcd 0000:00:02.0: suspend root hub

... etc
