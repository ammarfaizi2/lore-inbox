Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVKTVbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKTVbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKTVbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:31:37 -0500
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:19385
	"EHLO mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org
	with ESMTP id S1750759AbVKTVbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:31:36 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <4380EB33.2060305@eyal.emu.id.au>
Date: Mon, 21 Nov 2005 08:31:31 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14.2: repeated oops in i810 init
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this happen to me about three times, I captured it twice
using serial console [see logs at the bottom].

This is during a boot. I was dealing with SATA crashes. Both boots
followed this situation:
	system booted
	after a short while using the SATA disks the system locked
		up hard
	reset, boot single user
	fsck everything
	reboot normally
	oops during this bootup

You can see that the second boot included the sata_sil when the
first one has only the sata_promise.

I boot with 'irqpoll' which actually does not prevent the SATA
failures.


First oops
==========
Intel 810 + AC97 Audio, version 1.01, 23:38:18 Nov 11 2005
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 20
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 20
Unable to handle kernel NULL pointer dereference at virtual address 00000030
 printing eip:
f8a97c67
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: i810_audio ac97_codec it87 hwmon_vid hwmon eeprom i2c_isa i2c_i801 eth1394 ide_cd cdrom ns558 gameport snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device parport_pc parport ohci_hcd ohci1394 ieee1394 dc39
5x bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom videodev sata_promise e1000 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core ata_piix lib
ata tpm_nsc tpm_infineon tpm_atmel tpm ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_agp agpgart ext3 jbd nls_cp437 msdos fat sd_mod scsi_mod md_mod dm_mod unix
CPU:    0
EIP:    0060:[<f8a97c67>]    Not tainted VLI
EFLAGS: 00010002   (2.6.14.2)
EIP is at i810_interrupt+0x27/0xa0 [i810_audio]
eax: 00000000   ebx: e03383c0   ecx: 00000000   edx: 00000000
esi: dd88fc00   edi: c03a0f1c   ebp: 00000014   esp: c0402f80
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4746, threadinfo=c0402000 task=f75b1a30)
Stack: f757e400 e03383c0 c03a0f00 c013f314 00000014 dd88fc00 dd7b3dec 00000000
       00000000 c03a0500 00000001 00000000 c03a051c c013f4a7 00000000 dd7b3dec
       00000000 00000001 c03a0500 00000000 c013ecf8 00000000 c03a0500 00000001
Call Trace:
 [<c013f314>] misrouted_irq+0x124/0x140
 [<c013f4a7>] note_interrupt+0xb7/0xf0
 [<c013ecf8>] __do_IRQ+0xe8/0xf0
 [<c0105416>] do_IRQ+0x46/0x70
 =======================
 [<f89ee000>] ext3_get_group_desc+0x0/0xc0 [ext3]
 [<c0103b12>] common_interrupt+0x1a/0x20
 [<f89ee000>] ext3_get_group_desc+0x0/0xc0 [ext3]
 [<f89ee000>] ext3_get_group_desc+0x0/0xc0 [ext3]
 [<c01573f2>] __get_vm_area+0x112/0x1f0
 [<c015750b>] get_vm_area+0x3b/0x40
 [<c0116ea2>] __ioremap+0xc2/0x120
 [<c01253e1>] __request_region+0x81/0x90
 [<f8a9b696>] i810_probe+0x546/0x6f0 [i810_audio]
 [<c01df459>] pci_call_probe+0x19/0x20
 [<c01df4c5>] __pci_device_probe+0x65/0x80
 [<c01df50f>] pci_device_probe+0x2f/0x50
 [<c023784b>] driver_probe_device+0x3b/0xb0
 [<c0237940>] __driver_attach+0x0/0x60
 [<c0237990>] __driver_attach+0x50/0x60
 [<c0236d99>] bus_for_each_dev+0x69/0x80
 [<c02379c5>] driver_attach+0x25/0x30
 [<c0237940>] __driver_attach+0x0/0x60
 [<c02372ed>] bus_add_driver+0x8d/0xe0
 [<c01df7e3>] pci_register_driver+0x83/0xa0
 [<f895201b>] i810_init_module+0x1b/0x86 [i810_audio]
 [<c013c672>] sys_init_module+0x162/0x220
 [<c0103145>] syscall_call+0x7/0xb
Code: 32 fc ff ff 83 ec 0c 89 74 24 08 8b 74 24 14 89 5c 24 04 8d 46 08 e8 a9 b7 84 c7 8b 86 08 02 00 00 85 c0 74 6f 8b 86 04 02 00 00 <8b> 40 30 89 c3 81 e3 e7 0c 00 00 74 4c a8 e0 75 3a 8b 86 08 02

Second oops
===========
Intel 810 + AC97 Audio, version 1.01, 23:38:18 Nov 11 2005
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 20
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 20
Unable to handle kernel NULL pointer dereference at virtual address 00000030
 printing eip:
f8a97c67
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: i810_audio ac97_codec it87 hwmon_vid hwmon eeprom i2c_isa i2c_i801 eth1394 ide_cd cdrom ns558 gameport snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device parport_pc parport ohci_hcd ohci1394 ieee1394 dc39
5x bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom videodev sata_promise sata_sil e1000 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core ata
_piix libata tpm_nsc tpm_infineon tpm_atmel tpm ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_agp agpgart ext3 jbd nls_cp437 msdos fat sd_mod scsi_mod md_mod dm_mod unix
CPU:    0
EIP:    0060:[<f8a97c67>]    Not tainted VLI
EFLAGS: 00010002   (2.6.14.2)
EIP is at i810_interrupt+0x27/0xa0 [i810_audio]
eax: 00000000   ebx: f6b9c920   ecx: 00000000   edx: 00000000
esi: f6ba3c00   edi: c03a0f1c   ebp: 00000014   esp: c0402f80
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4919, threadinfo=c0402000 task=f7f04030)
Stack: f7f1fe00 f6b9c920 c03a0f00 c013f314 00000014 f6ba3c00 f72dae28 00000000
       00000000 c03a0500 00000001 00000000 c03a051c c013f4a7 00000000 f72dae28
       00000000 00000001 c03a0500 00000000 c013ecf8 00000000 c03a0500 00000001
Call Trace:
 [<c013f314>] misrouted_irq+0x124/0x140
 [<c013f4a7>] note_interrupt+0xb7/0xf0
 [<c013ecf8>] __do_IRQ+0xe8/0xf0
 [<c0105416>] do_IRQ+0x46/0x70
 =======================
 [<c0103b12>] common_interrupt+0x1a/0x20
 [<c0124edc>] __request_resource+0x4c/0x70
 [<c01253bc>] __request_region+0x5c/0x90
 [<f8a9b668>] i810_probe+0x518/0x6f0 [i810_audio]
 [<c01df459>] pci_call_probe+0x19/0x20
 [<c01df4c5>] __pci_device_probe+0x65/0x80
 [<c01df50f>] pci_device_probe+0x2f/0x50
 [<c023784b>] driver_probe_device+0x3b/0xb0
 [<c0237940>] __driver_attach+0x0/0x60
 [<c0237990>] __driver_attach+0x50/0x60
 [<c0236d99>] bus_for_each_dev+0x69/0x80
 [<c02379c5>] driver_attach+0x25/0x30
 [<c0237940>] __driver_attach+0x0/0x60
 [<c02372ed>] bus_add_driver+0x8d/0xe0
 [<c01df7e3>] pci_register_driver+0x83/0xa0
 [<f895201b>] i810_init_module+0x1b/0x86 [i810_audio]
 [<c013c672>] sys_init_module+0x162/0x220
 [<c0103145>] syscall_call+0x7/0xb
Code: 32 fc ff ff 83 ec 0c 89 74 24 08 8b 74 24 14 89 5c 24 04 8d 46 08 e8 a9 b7 84 c7 8b 86 08 02 00 00 85 c0 74 6f 8b 86 04 02 00 00 <8b> 40 30 89 c3 81 e3 e7 0c 00 00 74 4c a8 e0 75 3a 8b 86 08 02


$ uname -a
Linux e7 2.6.14.2 #1 SMP PREEMPT Fri Nov 11 23:05:09 EST 2005 i686 GNU/Linux


$ cat /proc/interrupts
           CPU0
  0:   50016429    IO-APIC-edge  timer
  1:       9990    IO-APIC-edge  i8042
  4:         29    IO-APIC-edge  serial
  7:          0    IO-APIC-edge  parport0
  9:          0   IO-APIC-level  acpi
 10:          0    IO-APIC-edge  MPU401 UART
 12:     303799    IO-APIC-edge  i8042
 14:     431738    IO-APIC-edge  ide0
 15:      80731    IO-APIC-edge  ide1
 16:    1087373   IO-APIC-level  uhci_hcd:usb3, libata, libata, dc395x, eth0
 17:    1624191   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb4, bttv1, bt878, nvidia
 18:          0   IO-APIC-level  uhci_hcd:usb2
 19:          0   IO-APIC-level  ehci_hcd:usb5
 20:      64348   IO-APIC-level  Intel ICH5
 21:         10   IO-APIC-level  libata, ohci1394
 22:     451174   IO-APIC-level  bttv0, bt878
NMI:          0
LOC:   50022091
ERR:          0
MIS:       7032


$ lspci -v
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: d8000000-d9ffffff
        Prefetchable memory behind bridge: c0000000-cfffffff

0000:00:03.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to CSA Bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: da000000-dbffffff
        Prefetchable memory behind bridge: 50000000-500fffff

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at bc00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at b000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at b400 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at b800 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: bus master, medium devsel, latency 0, IRQ 19
        Memory at de100000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 00008000-00009fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: de000000-de0fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]
        Memory at 50100000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16
        I/O ports at c000 [size=8]
        I/O ports at c400 [size=4]
        I/O ports at c800 [size=8]
        I/O ports at cc00 [size=4]
        I/O ports at d000 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Flags: medium devsel, IRQ 5
        I/O ports at 1400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: Giga-byte Technology: Unknown device a002
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at d800 [size=256]
        I/O ports at dc00 [size=64]
        Memory at de101000 (32-bit, non-prefetchable) [size=512]
        Memory at de102000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 5600XT] (rev a1) (prog-if 00 [VGA])
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 17
        Memory at d8000000 (32-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Expansion ROM at d9000000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
        Subsystem: Giga-byte Technology: Unknown device e000
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16
        Memory at db020000 (32-bit, non-prefetchable) [size=128K]
        Memory at db000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at a000 [size=32]
        Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:03:00.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 16
        I/O ports at 8000 [size=8]
        I/O ports at 8400 [size=4]
        I/O ports at 8800 [size=8]
        I/O ports at 8c00 [size=4]
        I/O ports at 9000 [size=16]
        Memory at dd024000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at de080000 [disabled] [size=512K]
        Capabilities: <available only to root>

0000:03:01.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3d18 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3d18
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 21
        I/O ports at 9400 [size=128]
        I/O ports at 9800 [size=256]
        Memory at dd027000 (32-bit, non-prefetchable) [size=4K]
        Memory at dd000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at de008000 [disabled] [size=32K]
        Capabilities: <available only to root>

0000:03:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Avermedia Technologies Inc: Unknown device 0771
        Flags: bus master, medium devsel, latency 32, IRQ 22
        Memory at de000000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:03:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Avermedia Technologies Inc: Unknown device 0771
        Flags: bus master, medium devsel, latency 32, IRQ 22
        Memory at de001000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:03:03.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Avermedia Technologies Inc: Unknown device 0761
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at de002000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:03:03.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Avermedia Technologies Inc: Unknown device 0761
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at de003000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:03:04.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
        Subsystem: Tekram Technology Co.,Ltd. TRM-S1040
        Flags: bus master, medium devsel, latency 32, IRQ 16
        I/O ports at 9c00 [size=256]
        Memory at dd025000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at de010000 [disabled] [size=64K]
        Capabilities: <available only to root>

0000:03:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology: Unknown device 1000
        Flags: bus master, medium devsel, latency 32, IRQ 21
        Memory at dd026000 (32-bit, non-prefetchable) [size=2K]
        Memory at dd020000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
