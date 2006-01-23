Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWAWVE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWAWVE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWAWVE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:04:56 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8100 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S964941AbWAWVE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:04:56 -0500
Date: Mon, 23 Jan 2006 13:04:43 -0800
From: Greg KH <gregkh@suse.de>
To: David Brownell <david-b@pacbell.net>, ak@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: EHCI + APIC errors = no usb goodness
Message-ID: <20060123210443.GA20944@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a laptop here that has had some "issues" in the past (time
running double speed, XFree doesn't work, etc.)

Now I'm down to the last problem, USB doesn't work, which is a bit of a
pain for me :)

Anyway, below is the kernel log from 2.6.16-rc1-mm2 (contains the latest
acpi tree, which I thought might help out.)  This log is when I modprobe
ehci-hcd.  The interesting thing is the APIC error, and then the fact
that the interrupt screams off into oblivion.  I can provide early
kernel boot info too, if you think that might help out.

Any thoughts?

I _think_ a real old 2.6 kernel used to work on this box, so I'll do a
bit of searching to see if I can find one and then try bisecting from
there...

Andi, I know you have been doing some apic rework for x86-64 (which this
processor is, but I'm still running it in 32bit mode.)  Do you happen to
have any patch that I could test out?

thanks,

greg k-h


[   87.324320] ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
[   87.324356] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 16
[   87.324371] ehci_hcd 0000:00:13.2: EHCI Host Controller
[   87.324379] ehci_hcd 0000:00:13.2: reset hcs_params 0x2408 dbg=0 cc=2 pcc=4 ordered !ppc ports=8
[   87.324385] ehci_hcd 0000:00:13.2: reset hcc_params a012 thresh 1 uframes 256/512/1024
[   87.324426] ehci_hcd 0000:00:13.2: capability 0001 at a0
[   87.324436] ehci_hcd 0000:00:13.2: MWI active
[   87.324589] drivers/usb/core/inode.c: creating file 'devices'
[   87.324594] drivers/usb/core/inode.c: creating file '001'
[   87.324598] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
[   87.324613] ehci_hcd 0000:00:13.2: irq 16, io mem 0xfbdff000
[   87.324623] ehci_hcd 0000:00:13.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[   87.324633] ehci_hcd 0000:00:13.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
[   87.324643] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   87.324682] usb usb1: default language 0x0409
[   87.324695] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[   87.324700] usb usb1: Product: EHCI Host Controller
[   87.324704] usb usb1: Manufacturer: Linux 2.6.16-rc1-mm2 ehci_hcd
[   87.324709] usb usb1: SerialNumber: 0000:00:13.2
[   87.324727] usb usb1: uevent
[   87.324764] usb usb1: device is self-powered
[   87.324769] usb usb1: configuration #1 chosen from 1 choice
[   87.324781] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[   87.324793] usb 1-0:1.0: uevent
[   87.324818] hub 1-0:1.0: usb_probe_interface
[   87.324822] hub 1-0:1.0: usb_probe_interface - got id
[   87.324827] hub 1-0:1.0: USB hub found
[   87.324841] hub 1-0:1.0: 8 ports detected
[   87.324845] hub 1-0:1.0: standalone hub
[   87.324849] hub 1-0:1.0: no power switching (usb 1.0)
[   87.324854] hub 1-0:1.0: individual port over-current protection
[   87.324858] hub 1-0:1.0: Single TT
[   87.324863] hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
[   87.324867] hub 1-0:1.0: power on to power good time: 20ms
[   87.324876] hub 1-0:1.0: local power source is good
[   87.406180] APIC error on CPU0: 00(40)
[   87.426282] drivers/usb/core/inode.c: creating file '001'
[   87.426333] hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
[   87.712002] APIC error on CPU0: 40(40)
[   87.774743] irq 16: nobody cared (try booting with the "irqpoll" option)
[   87.774748]  <c013e14a> __report_bad_irq+0x2a/0x90   <c013dae9> handle_IRQ_event+0x39/0x70
[   87.774759]  <c013e270> note_interrupt+0xa0/0x100   <c013dbd4> __do_IRQ+0xb4/0xc0
[   87.774767]  <c0105709> do_IRQ+0x19/0x30   <c0103a46> common_interrupt+0x1a/0x20
[   87.774775] handlers:
[   87.774777] [<dc83bc40>] (usb_hcd_irq+0x0/0x70 [usbcore])
[   87.774796] Disabling IRQ #16
