Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSHYJL5>; Sun, 25 Aug 2002 05:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSHYJL5>; Sun, 25 Aug 2002 05:11:57 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:24502 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S317081AbSHYJLt>; Sun, 25 Aug 2002 05:11:49 -0400
Date: Sun, 25 Aug 2002 11:15:57 +0200
Message-Id: <200208250915.g7P9FvX01623@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <joerg.beyer@email.de>
To: linux-kernel@vger.kernel.org
Subject: <no subject>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see high latencies on a new medion (MD9788) laptop.

I had to use tha acpi patch to get a NIC module
loaded into the kernel. There is a realtec 8139 chip
onboard. I tried both Donald Beckers and the usual
kernel module for that chip - with similar results:

There are a lot lines in /var/log/messages like this:
kernel: eth0: Too much work at interrupt, IntrStatus=0x0040.

The NIC has a lot errors:
eth0      Link encap:Ethernet  HWaddr 00:07:CA:00:AC:A3
          inet addr:10.0.0.30  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:802 errors:5860 dropped:290 overruns:5860 frame:0
          TX packets:802 errors:0 dropped:0 overruns:0 carrier:0
          collisions:3 txqueuelen:100
          RX bytes:1116143 (1.0 Mb)  TX bytes:63846 (62.3 Kb)
          Interrupt:10 Base address:0xf000

Disk access, like untaring a big tar file (e.g. kernel sources)
are really slow.

I see this effect with 2.4.18, 2.4.19, 2.4.20-pre4 kernels (with the
matching acpi patch. without acpi patch the NIC is not usable).

Could anybody tell me why there are such high IRQ latencies?
Or are my assumptions wrong?


For reference, here is a lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:06.0 Communication controller: Ambient Technologies Inc: Unknown device 4000   (rev 02)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40  )
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controlle  r (rev 50)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01)

here is /proc/interrupts:
           CPU0
  0:     175728          XT-PIC  timer
  1:        684          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:          0          XT-PIC  acpi
 10:       1965          XT-PIC  eth0
 14:       4011          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0


I have very limited knowledge about IRQs. Does anybody see how
to fix the high IRQ latencies?

If you need further informations, please drop me a mail.

    TIA
    Joerg

and below is the dmesg:
>pci_link-0183 [0001] [08] acpi_pci_link_get_curr: ----Entry
pci_link-0259 [0001] [08] acpi_pci_link_get_curr: Link at IRQ 10
pci_link-0264 [0001] [08] acpi_pci_link_get_curr: ----Exit- 0000000000000000
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
pci_link-0546 [0001] [07] acpi_pci_link_add     : ----Exit- 0000000000000000
pci_link-0501 [0001] [07] acpi_pci_link_add     : ----Entry
pci_link-0099 [0001] [08] acpi_pci_link_get_poss: ----Entry
pci_link-0164 [0001] [08] acpi_pci_link_get_poss: Found 1 possible IRQs
pci_link-0169 [0001] [08] acpi_pci_link_get_poss: ----Exit- 0000000000000000
pci_link-0183 [0001] [08] acpi_pci_link_get_curr: ----Entry
pci_link-0259 [0001] [08] acpi_pci_link_get_curr: Link at IRQ 10
pci_link-0264 [0001] [08] acpi_pci_link_get_curr: ----Exit- 0000000000000000
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
pci_link-0546 [0001] [07] acpi_pci_link_add     : ----Exit- 0000000000000000
pci_link-0501 [0001] [07] acpi_pci_link_add     : ----Entry
pci_link-0099 [0001] [08] acpi_pci_link_get_poss: ----Entry
pci_link-0164 [0001] [08] acpi_pci_link_get_poss: Found 1 possible IRQs
pci_link-0169 [0001] [08] acpi_pci_link_get_poss: ----Exit- 0000000000000000
pci_link-0183 [0001] [08] acpi_pci_link_get_curr: ----Entry
pci_link-0259 [0001] [08] acpi_pci_link_get_curr: Link at IRQ 5
pci_link-0264 [0001] [08] acpi_pci_link_get_curr: ----Exit- 0000000000000000
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
pci_link-0546 [0001] [07] acpi_pci_link_add     : ----Exit- 0000000000000000
pci_link-0501 [0001] [07] acpi_pci_link_add     : ----Entry
pci_link-0099 [0001] [08] acpi_pci_link_get_poss: ----Entry
pci_link-0164 [0001] [08] acpi_pci_link_get_poss: Found 1 possible IRQs
pci_link-0169 [0001] [08] acpi_pci_link_get_poss: ----Exit- 0000000000000000
pci_link-0183 [0001] [08] acpi_pci_link_get_curr: ----Entry
pci_link-0259 [0001] [08] acpi_pci_link_get_curr: Link at IRQ 5
pci_link-0264 [0001] [08] acpi_pci_link_get_curr: ----Exit- 0000000000000000
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
pci_link-0546 [0001] [07] acpi_pci_link_add     : ----Exit- 0000000000000000
pci_bind-0134 [0001] [05] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [05] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.PPB_]...
pci_bind-0176 [0001] [05] acpi_pci_bind         : ...to 00:00:01.00
pci_bind-0217 [0001] [05] acpi_pci_bind         : Device 00:00:01.00 is a PCI bridge
pci_bind-0260 [0001] [05] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [05] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [05] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.PPB_.VGA_]...
pci_bind-0176 [0001] [05] acpi_pci_bind         : ...to 00:01:00.00
pci_bind-0260 [0001] [05] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [05] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [05] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.USB0]...
pci_bind-0176 [0001] [05] acpi_pci_bind         : ...to 00:00:07.02
pci_bind-0260 [0001] [05] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [05] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [05] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.PM__]...
pci_bind-0176 [0001] [05] acpi_pci_bind         : ...to 00:00:07.04
pci_bind-0260 [0001] [05] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [05] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [05] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.AUDI]...
pci_bind-0176 [0001] [05] acpi_pci_bind         : ...to 00:00:07.05
pci_bind-0260 [0001] [05] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [05] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [05] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.MPC2]...
pci_bind-0176 [0001] [05] acpi_pci_bind         : ...to 00:00:09.00
pci_bind-0260 [0001] [05] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [05] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [05] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.MPCI]...
pci_bind-0176 [0001] [05] acpi_pci_bind         : ...to 00:00:06.00
pci_bind-0260 [0001] [05] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [06] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [06] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.CRD0]...
pci_bind-0176 [0001] [06] acpi_pci_bind         : ...to 00:00:0c.00
pci_bind-0217 [0001] [06] acpi_pci_bind         : Device 00:00:0c.00 is a PCI bridge
pci_bind-0260 [0001] [06] acpi_pci_bind         : ----Exit- 0000000000000000
pci_bind-0134 [0001] [07] acpi_pci_bind         : ----Entry
pci_bind-0146 [0001] [07] acpi_pci_bind         : Binding PCI device [\_SB_.PCI0.CRD1]...
pci_bind-0176 [0001] [07] acpi_pci_bind         : ...to 00:00:0c.01
pci_bind-0217 [0001] [07] acpi_pci_bind         : Device 00:00:0c.01 is a PCI bridge
pci_bind-0260 [0001] [07] acpi_pci_bind         : ----Exit- 0000000000000000
ACPI: Power Resource [PFAN] (on)
PCI: Probing PCI hardware
 pci_irq-0376 [0001] [04] acpi_pci_irq_init     : ----Entry
pci_link-0385 [0001] [05] acpi_pci_link_check   : ----Entry
pci_link-0446 [0001] [05] acpi_pci_link_check   : ----Exit- 0000000000000000
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0318 [0001] [05] acpi_pci_irq_enable   : No interrupt pin configured for device 00:00.0
 pci_irq-0319 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000000
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0318 [0001] [05] acpi_pci_irq_enable   : No interrupt pin configured for device 00:01.0
 pci_irq-0319 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000000
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0001] [06] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [06] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:06[A]
 pci_irq-0066 [0001] [07] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0080 [0001] [07] acpi_pci_irq_find_prt_: ----Exit- c129fac0
pci_link-0459 [0001] [07] acpi_pci_link_get_irq : ----Entry
pci_link-0484 [0001] [07] acpi_pci_link_get_irq : ----Exit- 000000000000000A
 pci_irq-0264 [0001] [06] acpi_pci_irq_lookup   : Found IRQ 10
 pci_irq-0266 [0001] [06] acpi_pci_irq_lookup   : ----Exit- 000000000000000A
 pci_irq-0354 [0001] [05] acpi_pci_irq_enable   : Device 00:06.0 using IRQ 10
 pci_irq-0361 [0001] [05] acpi_pci_irq_enable   : Setting IRQ 10 as level-triggered
 pci_irq-0367 [0001] [05] acpi_pci_irq_enable   : ----Exit- 000000000000000A
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0318 [0001] [05] acpi_pci_irq_enable   : No interrupt pin configured for device 00:07.0
 pci_irq-0319 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000000
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0318 [0001] [05] acpi_pci_irq_enable   : No interrupt pin configured for device 00:07.1
 pci_irq-0319 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000000
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0001] [06] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [06] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:07[D]
 pci_irq-0066 [0001] [07] acpi_pci_irq_find_prt_: ----Entry
pci_irq-0080 [0001] [07] acpi_pci_irq_find_prt_: ----Exit- c129fa80
pci_link-0459 [0001] [07] acpi_pci_link_get_irq : ----Entry
pci_link-0484 [0001] [07] acpi_pci_link_get_irq : ----Exit- 0000000000000005
 pci_irq-0264 [0001] [06] acpi_pci_irq_lookup   : Found IRQ 5
 pci_irq-0266 [0001] [06] acpi_pci_irq_lookup   : ----Exit- 0000000000000005
 pci_irq-0354 [0001] [05] acpi_pci_irq_enable   : Device 00:07.2 using IRQ 5
 pci_irq-0361 [0001] [05] acpi_pci_irq_enable   : Setting IRQ 5 as level-triggered
 pci_irq-0367 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000005
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0318 [0001] [05] acpi_pci_irq_enable   : No interrupt pin configured for device 00:07.4
 pci_irq-0319 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000000
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0001] [06] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [06] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:07[C]
 pci_irq-0066 [0001] [07] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0080 [0001] [07] acpi_pci_irq_find_prt_: ----Exit- c129fa40
pci_link-0459 [0001] [07] acpi_pci_link_get_irq : ----Entry
pci_link-0484 [0001] [07] acpi_pci_link_get_irq : ----Exit- 0000000000000005
 pci_irq-0264 [0001] [06] acpi_pci_irq_lookup   : Found IRQ 5
 pci_irq-0266 [0001] [06] acpi_pci_irq_lookup   : ----Exit- 0000000000000005
 pci_irq-0354 [0001] [05] acpi_pci_irq_enable   : Device 00:07.5 using IRQ 5
 pci_irq-0367 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000005
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0001] [06] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [06] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:09[A]
 pci_irq-0066 [0001] [07] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0080 [0001] [07] acpi_pci_irq_find_prt_: ----Exit- c129fb00
pci_link-0459 [0001] [07] acpi_pci_link_get_irq : ----Entry
pci_link-0484 [0001] [07] acpi_pci_link_get_irq : ----Exit- 000000000000000A
 pci_irq-0264 [0001] [06] acpi_pci_irq_lookup   : Found IRQ 10
 pci_irq-0266 [0001] [06] acpi_pci_irq_lookup   : ----Exit- 000000000000000A
 pci_irq-0354 [0001] [05] acpi_pci_irq_enable   : Device 00:09.0 using IRQ 10
 pci_irq-0367 [0001] [05] acpi_pci_irq_enable   : ----Exit- 000000000000000A
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0001] [06] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [06] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:0c[A]
 pci_irq-0066 [0001] [07] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0080 [0001] [07] acpi_pci_irq_find_prt_: ----Exit- c129fb40
pci_link-0459 [0001] [07] acpi_pci_link_get_irq : ----Entry
pci_link-0484 [0001] [07] acpi_pci_link_get_irq : ----Exit- 000000000000000A
 pci_irq-0264 [0001] [06] acpi_pci_irq_lookup   : Found IRQ 10
 pci_irq-0266 [0001] [06] acpi_pci_irq_lookup   : ----Exit- 000000000000000A
 pci_irq-0354 [0001] [05] acpi_pci_irq_enable   : Device 00:0c.0 using IRQ 10
 pci_irq-0367 [0001] [05] acpi_pci_irq_enable   : ----Exit- 000000000000000A
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0001] [06] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [06] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:0c[B]
 pci_irq-0066 [0001] [07] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0080 [0001] [07] acpi_pci_irq_find_prt_: ----Exit- c129fb80
pci_link-0459 [0001] [07] acpi_pci_link_get_irq : ----Entry
pci_link-0484 [0001] [07] acpi_pci_link_get_irq : ----Exit- 000000000000000A
 pci_irq-0264 [0001] [06] acpi_pci_irq_lookup   : Found IRQ 10
pci_irq-0266 [0001] [06] acpi_pci_irq_lookup   : ----Exit- 000000000000000A
 pci_irq-0354 [0001] [05] acpi_pci_irq_enable   : Device 00:0c.1 using IRQ 10
 pci_irq-0367 [0001] [05] acpi_pci_irq_enable   : ----Exit- 000000000000000A
 pci_irq-0311 [0001] [05] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0001] [06] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [06] acpi_pci_irq_lookup   : Searching for PRT entry for 00:01:00[A]
 pci_irq-0066 [0001] [07] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0084 [0001] [07] acpi_pci_irq_find_prt_: ----Exit- 00000000
 pci_irq-0248 [0001] [06] acpi_pci_irq_lookup   : PRT entry not found
 pci_irq-0249 [0001] [06] acpi_pci_irq_lookup   : ----Exit- 0000000000000000
 pci_irq-0278 [0001] [06] acpi_pci_irq_derive   : ----Entry
 pci_irq-0240 [0001] [07] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0001] [07] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:01[B]
 pci_irq-0066 [0001] [08] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0084 [0001] [08] acpi_pci_irq_find_prt_: ----Exit- 00000000
 pci_irq-0248 [0001] [07] acpi_pci_irq_lookup   : PRT entry not found
 pci_irq-0249 [0001] [07] acpi_pci_irq_lookup   : ----Exit- 0000000000000000
 pci_irq-0293 [0001] [06] acpi_pci_irq_derive   : Unable to derive IRQ for device 01:00.0
 pci_irq-0294 [0001] [06] acpi_pci_irq_derive   : ----Exit- 0000000000000000
PCI: No IRQ known for interrupt pin A of device 01:00.0 - using IRQ 5
 pci_irq-0349 [0001] [05] acpi_pci_irq_enable   : ----Exit- 0000000000000005
 pci_irq-0396 [0001] [04] acpi_pci_irq_init     : ----Exit- 0000000000000000
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: Thermal Zone [THRM] (39 C)
vesafb: framebuffer at 0xf0000000, mapped to 0xcf808000, size 15296k
vesafb: mode is 1024x768x16, linelength=2048, pages=8
vesafb: protected mode interface info at c000:7f20
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: HITACHI_DK23DA-20, ATA DISK drive
hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 240k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 481940k swap-space (priority 42)
8139too Fast Ethernet driver 0.9.25

**** Context Switch from TID 1 to TID 134 ****

 pci_irq-0311 [0134] [04] acpi_pci_irq_enable   : ----Entry
 pci_irq-0240 [0134] [05] acpi_pci_irq_lookup   : ----Entry
 pci_irq-0244 [0134] [05] acpi_pci_irq_lookup   : Searching for PRT entry for 00:00:09[A]
 pci_irq-0066 [0134] [06] acpi_pci_irq_find_prt_: ----Entry
 pci_irq-0080 [0134] [06] acpi_pci_irq_find_prt_: ----Exit- c129fb00
 pci_irq-0264 [0134] [05] acpi_pci_irq_lookup   : Found IRQ 10
 pci_irq-0266 [0134] [05] acpi_pci_irq_lookup   : ----Exit- 000000000000000A
 pci_irq-0354 [0134] [04] acpi_pci_irq_enable   : Device 00:09.0 using IRQ 10
 pci_irq-0367 [0134] [04] acpi_pci_irq_enable   : ----Exit- 000000000000000A
eth0: RealTek RTL8139 Fast Ethernet at 0xd07ef000, 00:07:ca:00:ac:a3, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'


