Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266313AbTGEJyE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 05:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbTGEJyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 05:54:04 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:46601 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S266313AbTGEJx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 05:53:59 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: yenta-socket oops with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
Date: Sat, 5 Jul 2003 18:05:31 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307040056.09270.mflt1@micrologica.com.hk>
In-Reply-To: <200307040056.09270.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307051805.34056.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 July 2003 09:10, Michael Frank wrote:
> modprobe yenta-socket produces oops below _only_ after cold boot and _only_
> when e100 loaded. No PCMCIA problems with this system with 2.4 and 2.5
> until recent PCMCIA rework.
>
> Reproduced behavior with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
>
> 2.5.73-mm2 no oops but hangs about 1 in 10 at
>  PCI: Enabling device 0:12.0 (0->2) (PCMCIA). e100 was loaded but not
> tested wo e100
>
> Conditions:
>  Cold-boot - no oops when warm-boot+load after successful load or when
> unload+load e100 loaded
>
> Oops appears 1 in 4 loads and looks similar every time
>
> Setup:
> ACPI core enabled, no usb
>
> $ lsmod
> pcmcia_core
> toshiba_acpi
> e100
>
> $ lspci
> 00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
> 00:00.1 RAM memory: Transmeta Corporation SDRAM controller
> 00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
> 00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13)
> 00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
> Controller Audio Device (rev 01) 00:07.0 ISA bridge: ALi Corporation M1533
> PCI to ISA Bridge [Aladdin IV] 00:0e.0 Ethernet controller: Intel Corp.
> 82557/8/9 [Ethernet Pro 100] (rev 08) 00:10.0 IDE interface: ALi
> Corporation M5229 IDE (rev c3)
> 00:11.0 Bridge: ALi Corporation M7101 PMU
> 00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus
> Bridge with ZV Support (rev 32) 00:14.0 USB Controller: ALi Corporation USB
> 1.1 Controller (rev 03)
>
> No serial port, Oops taken from screen
> unable to handle null pointer dereference at 0
> oops: 0000 #1
> EFLAGS 00010086
> EIP is at __wake_up_common+0x13
> eax ce09c9c0 ebx 286 ecx 1 edx 0
> esi 1 edi 0 ebp ccc67dcc esp ccc67dc0
> ds 7b es 7b ss 68
> Process modprobe pid 1153 threadinfo ccc66000 task cd68e080
> Stack: 286 4000001 0 ccc67de8 c011afa1 ce09c9c0 3 1
>        0 ce09c800 ccc67df0 cf8a3ecf cccc67e04 cf87a7ea ce09c830 80
>        cdffec00 ccc67e24 c010d0aa 5 ce09c800 ccc67e50 280 5
> Call trace:
> __wake_up+0x11
> pcmcia_parse_events+0x23
> yenta_interrupt+0x26
> handle_IRQ_event+0x2a
> do_IRQ+0x82
> common_interrupt+0x18
> setup_irq+0x9b
> yenta_interrupt+0x0
> request_irq+0x89
> yenta_probe+0x137
> yenta_interrupt+0x0
> pci_device_probe_static+0x20
> pci_device_probe+0x21
> bus_match+0x38
> driver_attach+0x3e
> bus_add_driver+0x6e
> driver_register+0x36
> pci_register_driver+0x6a
> yenta_socket_init+0xd
> sys_init_module+0xe0
> syscall_call+0x7
> Code: 8b 3a 8b 45 08 83 c0 04 39 c2 74 23 8b 5a f4 8b 4d 14 51 8b
>  <0> Fatal exception in interrupt
> In interrupt handler - not syncing
>
> It is now running allright by starting pcmcia ahead of network.
>

Just got the same oops with 2.5.74-mm1 on cold boot without e100 loaded.

With e100 probability is > 1 in 4
Without e100 probability is <1 in 10

Regards
Michael

-- 
Powered by linux-2.5.74-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp and ACPI S3
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt

