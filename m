Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVAKTvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVAKTvC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVAKTvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:51:01 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:7401 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262407AbVAKTq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:46:58 -0500
Date: Tue, 11 Jan 2005 20:46:44 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: DHollenbeck <dick@softplc.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, magnus.damm@gmail.com
Subject: Re: yenta_socket rapid fires interrupts
In-Reply-To: <41E42691.3060102@softplc.com>
Message-ID: <Pine.LNX.4.60.0501112034500.8024@alpha.polcom.net>
References: <41E2BC77.2090509@softplc.com> <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, DHollenbeck wrote:

> Linus Torvalds wrote:
>
>> On Mon, 10 Jan 2005, DHollenbeck wrote:
>> 
>> 
>>> However, when I have a "CARDBUS to USB 2.0 Hi-Speed Adapter" installed at 
>>> the time of modprobe yenta_socket, I get a problem, shown below. 
>>> 
>>> 
>> 
>> Can you compile the kernel with kallsyms info? That would make the output a 
>> whole lot more readable.
>> 
>> 
>> 
> first, load the following two modules
>
> modprobe ehci_hcd, then
> modprobe yenta_socket
>
> then a dmesg extract, now with kallsyms:
>
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> Linux Kernel Card Services
> options:  [pci] [cardbus]
> PCI: Found IRQ 11 for device 0000:00:0d.0
> PCI: Sharing IRQ 11 with 0000:00:0d.1
> Yenta: CardBus bridge found at 0000:00:0d.0 [0000:0000]
> Yenta: Enabling burst memory read transactions
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:00:0d.0, mfunc 0x00001022, devctl 0x64
> Yenta: ISA IRQ mask 0x00a8, PCI irq 11
> Socket status: 30000006
> PCI: Found IRQ 11 for device 0000:00:0d.1
> PCI: Sharing IRQ 11 with 0000:00:0d.0
> Yenta: CardBus bridge found at 0000:00:0d.1 [0000:0000]
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:00:0d.1, mfunc 0x00001022, devctl 0x64
> Yenta: ISA IRQ mask 0x00a8, PCI irq 11
> Socket status: 30000020
> irq 11: nobody cared (try booting with the "irqpoll" option.
> [<c012b752>] __report_bad_irq+0x22/0x90
> [<c012b868>] note_interrupt+0x78/0xc0
> [<c012b11d>] __do_IRQ+0x13d/0x160
> [<c0104aba>] do_IRQ+0x1a/0x30
> [<c010337a>] common_interrupt+0x1a/0x20
> [<c012007b>] sys_getresgid+0xb/0xa0
> [<c0117750>] __do_softirq+0x30/0xa0
> [<c0120060>] sys_setresgid+0x120/0x130
> [<c01177f5>] do_softirq+0x35/0x40
> [<c012af65>] irq_exit+0x35/0x40
> [<c0104abf>] do_IRQ+0x1f/0x30
> [<c010337a>] common_interrupt+0x1a/0x20
> [<c01005b0>] default_idle+0x0/0x40
> [<c038007b>] ic_setup_if+0xcb/0xd0
> [<c01005d3>] default_idle+0x23/0x40
> [<c010064c>] cpu_idle+0x1c/0x50
> [<c036873c>] start_kernel+0x13c/0x160
> handlers:
> [<c2842930>] (yenta_interrupt+0x0/0x40 [yenta_socket])
> [<c2842930>] (yenta_interrupt+0x0/0x40 [yenta_socket])
> Disabling IRQ #11
> PCI: Enabling device 0000:05:00.3 (0000 -> 0002)
> ehci_hcd 0000:05:00.3: ALi Corporation USB 2.0 Controller
> ehci_hcd 0000:05:00.3: irq 11, pci mem 0x10c01000
> ehci_hcd 0000:05:00.3: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:05:00.3: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
>
>
> root@EMBEDDED[~]# cat /proc/interrupts
>         CPU0
> 0:     263041          XT-PIC  timer
> 2:          0          XT-PIC  cascade
> 4:        163          XT-PIC  serial
> 8:          0          XT-PIC  rtc
> 9:        584          XT-PIC  eth0
> 11:     100000          XT-PIC  yenta, yenta, ehci_hcd
> 14:       8631          XT-PIC  ide0
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
> root@EMBEDDED[~]#

I think that this is not this card problem.

I have laptop (x86_64 - Acer Aspire 1524 WLMI) with yenta and usb 2.0 
(onboard not cardbus). It has yenta and USB on the same IRQ (11 too).
When I try to load USB module (even with yenta removed from /lib/modules) 
I get similar problem.

I hacked it somehow - probably disabling ACPI and maybe APIC, and passing 
tons of strange options to the kernel (and maybe even compiling only usb 
1.1 support in? - I do not remember - I was in hurry to get my mouse 
working before Xmas...)

But I will bet that ACPI has something to this.

I believe I described this problem (offlist) in mail to Greg KH, but I got 
no response (maybe it didn't get there?). I can post this mail to the list 
if you think you need it. There were some details like my logs, my 
configurations etc.

BTW. Does anybody knows why APIC on this laptop sends my (onboard) Realtek 
1000 Mbps network card to IRQ 169 or something like that (of course 
making it unusable until reboot with noapic)???


Thanks,

Grzegorz Kulewski

