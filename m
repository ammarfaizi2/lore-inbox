Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVIXOMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVIXOMk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVIXOMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 10:12:40 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:10637 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750753AbVIXOMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 10:12:39 -0400
Message-ID: <23431147.1127571157771.JavaMail.ngmail@webmail-05.arcor-online.net>
Date: Sat, 24 Sep 2005 16:12:37 +0200 (CEST)
From: thomas.mey3r@arcor.de
To: vda@ilport.com.ua
Subject: Aw: Re: 2.6.14-rc2-ge484585e: kexec into same kernel: irq 11 nobody
 cared; but ehci_hcd should
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509241530.42284.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200509241530.42284.vda@ilport.com.ua> <32750612.1127563007089.JavaMail.ngmail@webmail-09.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 84.58.162.159
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct.
The interrupt happens before the interrupt is enabled by the ehci driver. the question is why is the interrupt already enabled? or: who forgot to disable the interrupt?

See: 
[17179591.828000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[17179591.828000] PCI: setting IRQ 11 as level-triggered
[17179591.828000] ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[17179591.828000] ehci_hcd 0000:00:10.3: EHCI Host Controller
[17179591.840000] ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[17179592.648000] irq 11: nobody cared (try booting with the "irqpoll" option)
[17179592.648000]  [<c0103f9e>] dump_stack+0x1e/0x20
[17179592.648000]  [<c013dc9b>] __report_bad_irq+0x2b/0x90
[17179592.648000]  [<c013ddc0>] note_interrupt+0x90/0xf0
[17179592.648000]  [<c013d6ca>] __do_IRQ+0xca/0xe0
[17179592.648000]  [<c010530c>] do_IRQ+0x1c/0x30
[17179592.648000]  [<c0103b26>] common_interrupt+0x1a/0x20
[17179592.648000]  [<c0120ffa>] do_softirq+0x2a/0x30
[17179592.648000]  [<c01210a5>] irq_exit+0x35/0x40
[17179592.648000]  [<c0105311>] do_IRQ+0x21/0x30
[17179592.648000]  [<c0103b26>] common_interrupt+0x1a/0x20
[17179592.648000]  [<c013d961>] setup_irq+0xb1/0x110
[17179592.648000]  [<c013db16>] request_irq+0x86/0xb0
[17179592.648000]  [<ec99c344>] usb_add_hcd+0x234/0x3a0 [usbcore]
[17179592.648000]  [<ec9a3a59>] usb_hcd_pci_probe+0x269/0x390 [usbcore]
[17179592.648000]  [<c01da2c9>] pci_call_probe+0x19/0x20
[17179592.648000]  [<c01da327>] __pci_device_probe+0x57/0x70
[17179592.648000]  [<c01da36f>] pci_device_probe+0x2f/0x60
[17179592.648000]  [<c021fad9>] driver_probe_device+0x39/0xc0
[17179592.648000]  [<c021fc3f>] __driver_attach+0x4f/0x60
[17179592.648000]  [<c021f014>] bus_for_each_dev+0x54/0x80
[17179592.648000]  [<c021fc78>] driver_attach+0x28/0x30
[17179592.648000]  [<c021f52d>] bus_add_driver+0x7d/0xe0
[17179592.648000]  [<c0220128>] driver_register+0x78/0x80
[17179592.648000]  [<c01da660>] pci_register_driver+0xb0/0xd0
[17179592.648000]  [<eca3d020>] init+0x20/0x26 [ehci_hcd]
[17179592.648000]  [<c0137e54>] sys_init_module+0x144/0x1c0
[17179592.648000]  [<c01030ff>] sysenter_past_esp+0x54/0x75
[17179592.648000] handlers:
[17179592.648000] [<ec99bf20>] (usb_hcd_irq+0x0/0x70 [usbcore])
[17179592.648000] Disabling IRQ #11
[17179592.648000] ehci_hcd 0000:00:10.3: irq 11, io mem 0xd0004800
[17179592.648000] ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004

[17179592.648000] setting ehci->regs->intr_enable to 37

[17179592.652000] hub 4-0:1.0: USB hub found
[17179592.652000] hub 4-0:1.0: 6 ports detected


----- Original Nachricht ----
Von:     Denis Vlasenko <vda@ilport.com.ua>
An:      thomas.mey3r@arcor.de
Datum:   24.09.2005 14:30
Betreff: Re: 2.6.14-rc2-ge484585e: kexec into same kernel: irq 11 nobody cared; but ehci_hcd should

> On Saturday 24 September 2005 14:56, thomas.mey3r@arcor.de wrote:
> > Hi.
> > 
> > I played a bit with the new kexec function:
> > 
> > when i kexec into the same kernel i get this error message:
> > 
> > [17179593.108000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> > [17179593.108000] PCI: setting IRQ 11 as level-triggered
> > [17179593.108000] ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] ->
> GSI 11 (level, low) -> IRQ 11
> > [17179593.108000] ehci_hcd 0000:00:10.3: EHCI Host Controller
> > [17179593.124000] ehci_hcd 0000:00:10.3: new USB bus registered, assigned
> bus number 4
> > [17179593.936000] irq 11: nobody cared (try booting with the "irqpoll"
> option)
> > [17179593.936000]  [<c0103f9e>] dump_stack+0x1e/0x20
> > [17179593.936000]  [<c013dc6b>] __report_bad_irq+0x2b/0x90
> > [17179593.936000]  [<c013dd90>] note_interrupt+0x90/0xf0
> > [17179593.936000]  [<c013d69a>] __do_IRQ+0xca/0xe0
> > [17179593.936000]  [<c010530c>] do_IRQ+0x1c/0x30
> > [17179593.936000]  [<c0103b26>] common_interrupt+0x1a/0x20
> > [17179593.936000]  [<c0120ffa>] do_softirq+0x2a/0x30
> > [17179593.936000]  [<c01210a5>] irq_exit+0x35/0x40
> > [17179593.936000]  [<c0105311>] do_IRQ+0x21/0x30
> > [17179593.936000]  [<c0103b26>] common_interrupt+0x1a/0x20
> > [17179593.936000]  [<c013d931>] setup_irq+0xb1/0x110
> > [17179593.936000]  [<c013dae6>] request_irq+0x86/0xb0
> > [17179593.936000]  [<ec99c344>] usb_add_hcd+0x234/0x3a0 [usbcore]
> > [17179593.936000]  [<ec9a3a59>] usb_hcd_pci_probe+0x269/0x390 [usbcore]
> > [17179593.936000]  [<c01da239>] pci_call_probe+0x19/0x20
> > [17179593.936000]  [<c01da297>] __pci_device_probe+0x57/0x70
> > [17179593.936000]  [<c01da2df>] pci_device_probe+0x2f/0x60
> > [17179593.936000]  [<c021fa49>] driver_probe_device+0x39/0xc0
> > [17179593.936000]  [<c021fbaf>] __driver_attach+0x4f/0x60
> > [17179593.936000]  [<c021ef84>] bus_for_each_dev+0x54/0x80
> > [17179593.936000]  [<c021fbe8>] driver_attach+0x28/0x30
> > [17179593.936000]  [<c021f49d>] bus_add_driver+0x7d/0xe0
> > [17179593.936000]  [<c0220098>] driver_register+0x78/0x80
> > [17179593.936000]  [<c01da5d0>] pci_register_driver+0xb0/0xd0
> > [17179593.936000]  [<eca3d020>] init+0x20/0x26 [ehci_hcd]
> > [17179593.936000]  [<c0137e24>] sys_init_module+0x144/0x1c0
> > [17179593.936000]  [<c01030ff>] sysenter_past_esp+0x54/0x75
> > [17179593.936000] handlers:
> > [17179593.936000] [<ec99bf20>] (usb_hcd_irq+0x0/0x70 [usbcore])
> > [17179593.936000] Disabling IRQ #11
> > [17179593.972000] ehci_hcd 0000:00:10.3: irq 11, io mem 0xd0004800
> > [17179593.972000] ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00,
> driver 10 Dec 2004
> > [17179593.976000] hub 4-0:1.0: USB hub found
> > [17179593.976000] hub 4-0:1.0: 6 ports detected
> > 
> >            CPU0
> >   0:     245067          XT-PIC  timer
> >   1:       2877          XT-PIC  i8042
> >   2:          0          XT-PIC  cascade
> >   4:      37766          XT-PIC  uhci_hcd:usb1, eth0,
> via@pci:0000:01:00.0
> >   5:        296          XT-PIC  yenta, ohci1394, uhci_hcd:usb2
> >   7:          2          XT-PIC  parport0
> >   8:          2          XT-PIC  rtc
> >   9:      51497          XT-PIC  uhci_hcd:usb3, VIA8233
> >  10:          9          XT-PIC  acpi
> >  11:     100000          XT-PIC  ehci_hcd:usb4
> >  12:      86427          XT-PIC  i8042
> >  14:      10409          XT-PIC  ide0
> >  15:      19973          XT-PIC  ide1
> > NMI:          0
> > LOC:          0
> > ERR:          0
> > MIS:          0
> > 
> > any ideas? 
> 
> I suspect that interrupt happens before intr mast is written
> ot corresponding register.
> 
> Add two printks, one before this writel:
> 
> printk("setting ehci->regs->intr_enable to %x\n", INTR_MASK);
>         writel (INTR_MASK, &ehci->regs->intr_enable); /* Turn On Interrupts
> */
> 
> and one here:
> 
>         status &= INTR_MASK;
>         if (!status) {                  /* irq sharing? */
> static int ratelimit = 20;
> if(ratelimit) ratelimit--, printk("ehci_irq: IRQ_NONE\n");
>                 spin_unlock(&ehci->lock);
>                 return IRQ_NONE;
>         }
> 
> and see whether first printk happens before second.
> --
> vda
> 
