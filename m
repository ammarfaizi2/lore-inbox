Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbTGDB3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265618AbTGDB3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:29:54 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:35589 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265617AbTGDB3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:29:44 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andrew Morton <akpm@digeo.com>
Subject: yenta-socket oops with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
Date: Fri, 4 Jul 2003 09:10:19 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307040056.09270.mflt1@micrologica.com.hk>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7PNB/nCdt1W/d9f"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7PNB/nCdt1W/d9f
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

modprobe yenta-socket produces oops below _only_ after cold boot and _only_ when e100 loaded.
No PCMCIA problems with this system with 2.4 and 2.5 until recent PCMCIA rework.

Reproduced behavior with 2.5.73-mm3, 2.5.74, 2.5.74-mm1

2.5.73-mm2 no oops but hangs about 1 in 10 at
 PCI: Enabling device 0:12.0 (0->2) (PCMCIA). e100 was loaded but not tested wo e100

Conditions:
 Cold-boot - no oops when warm-boot+load after successful load or when unload+load
 e100 loaded

Oops appears 1 in 4 loads and looks similar every time

Setup:
ACPI core enabled, no usb

$ lsmod
pcmcia_core
toshiba_acpi
e100

$ lspci
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)

No serial port, Oops taken from screen 
unable to handle null pointer dereference at 0
oops: 0000 #1
EFLAGS 00010086
EIP is at __wake_up_common+0x13
eax ce09c9c0 ebx 286 ecx 1 edx 0
esi 1 edi 0 ebp ccc67dcc esp ccc67dc0
ds 7b es 7b ss 68
Process modprobe pid 1153 threadinfo ccc66000 task cd68e080
Stack: 286 4000001 0 ccc67de8 c011afa1 ce09c9c0 3 1 
       0 ce09c800 ccc67df0 cf8a3ecf cccc67e04 cf87a7ea ce09c830 80
       cdffec00 ccc67e24 c010d0aa 5 ce09c800 ccc67e50 280 5
Call trace:
__wake_up+0x11
pcmcia_parse_events+0x23
yenta_interrupt+0x26
handle_IRQ_event+0x2a
do_IRQ+0x82
common_interrupt+0x18
setup_irq+0x9b
yenta_interrupt+0x0
request_irq+0x89
yenta_probe+0x137
yenta_interrupt+0x0
pci_device_probe_static+0x20
pci_device_probe+0x21
bus_match+0x38
driver_attach+0x3e
bus_add_driver+0x6e
driver_register+0x36
pci_register_driver+0x6a
yenta_socket_init+0xd
sys_init_module+0xe0
syscall_call+0x7
Code: 8b 3a 8b 45 08 83 c0 04 39 c2 74 23 8b 5a f4 8b 4d 14 51 8b
 <0> Fatal exception in interrupt
In interrupt handler - not syncing

It is now running allright by starting pcmcia ahead of network.

Typical dmesg enclosed as bz2

Regards
Michael
-- 
Powered by linux-2.5.74-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp and ACPI S3 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt










--Boundary-00=_7PNB/nCdt1W/d9f
Content-Type: application/x-bzip2;
  name="dmesg.2.5.74.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.2.5.74.bz2"

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

--Boundary-00=_7PNB/nCdt1W/d9f--


