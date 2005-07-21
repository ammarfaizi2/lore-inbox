Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVGUSHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVGUSHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGUSHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 14:07:14 -0400
Received: from mail.charite.de ([160.45.207.131]:19412 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261826AbVGUSGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 14:06:24 -0400
Date: Thu, 21 Jul 2005 20:06:21 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: ALSA, snd_intel8x0m and kexec() don't work together (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
Message-ID: <20050721180621.GA25829@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I use kexec() to reboot into a new kernel, sound doesn't work
properly. KDE doesn't display a mixer.

All modules seem to be loaded, though - and after a reboot using
"reboot" instead of "kexec", sound works flawlessly with the same setup.

/etc/init.d/alsa restart doesn't change things, either.

The one message strinking me as odd during the boot-process is:
Jul 21 19:50:01 kasbah kernel: AC'97 warm reset still in progress? [0xffffffff]

# lsmod
Module                  Size  Used by
pcmcia                 32232  4 
firmware_class          7872  1 pcmcia
thermal                10504  0 
fan                     3204  0 
button                  2944  0 
ac                      3332  0 
battery                 7556  0 
mousedev               10016  1 
tsdev                   5888  0 
evdev                   7488  0 
psmouse                32388  0 
rtc                    10936  0 
yenta_socket           22668  4 
rsrc_nonstatic         11968  1 yenta_socket
pcmcia_core            35920  3 pcmcia,yenta_socket,rsrc_nonstatic
8250_pci               17472  0 
8250                   22820  1 8250_pci
serial_core            19904  1 8250
snd_intel8x0m          15428  0 
usbhid                 34464  0 
snd_intel8x0           29440  0 
snd_ac97_codec         82556  2 snd_intel8x0m,snd_intel8x0
ehci_hcd               32200  0 
ohci_hcd               19844  0 
vfat                   11072  0 
fat                    46492  1 vfat
nls_base                6400  2 vfat,fat
i2c_nforce2             5760  0 
i2c_core               17424  1 i2c_nforce2
ndiswrapper           129204  0 
usbcore               110972  5 usbhid,ehci_hcd,ohci_hcd,ndiswrapper
snd_pcm_oss            49440  0 
snd_pcm                83400  4
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              22276  1 snd_pcm
snd_page_alloc          8392  3 snd_intel8x0m,snd_intel8x0,snd_pcm
snd_mixer_oss          17408  1 snd_pcm_oss
snd                    47204  7
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               7520  1 snd
ide_cd                 37956  0 
cdrom                  37792  1 ide_cd
cpufreq_userspace       3420  0 
powernow_k8            11144  0 
freq_table              3460  1 powernow_k8
processor              18684  2 thermal,powernow_k8
unix                   23856  590 

# lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev
a4)
0000:00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
0000:00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
0000:00:06.1 Modem: nVidia Corporation: Unknown device 00d9 (rev a2)
0000:00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5)
0000:00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2)
0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go 32M] (rev a3)
0000:02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:02.0 Network controller: Broadcom Corporation BCM4301 802.11b (rev 02)
0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201 (rev 01)

The log of a reboot using kexec():

Jul 21 19:50:01 kasbah kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Jul 21 19:50:01 kasbah kernel: Inspecting /boot/System.map-2.6.13-rc3-git4
Jul 21 19:50:01 kasbah kernel: Loaded 26210 symbols from /boot/System.map-2.6.13-rc3-git4.
Jul 21 19:50:01 kasbah kernel: Symbols match kernel version 2.6.13.
Jul 21 19:50:01 kasbah kernel: No module symbols loaded - kernel modules not enabled.
Jul 21 19:50:01 kasbah kernel: Linux version 2.6.13-rc3-git4 (root@kasbah) (gcc version 3.4.5 20050706 (prerelease) (Debian 3.4.4-5)) #1 Thu Jul 21 19:31:46 CEST 2005
Jul 21 19:50:01 kasbah kernel: BIOS-provided physical RAM map:
Jul 21 19:50:01 kasbah kernel:  BIOS-e820: 0000000000000100 - 000000000009f800 (usable)
Jul 21 19:50:01 kasbah kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jul 21 19:50:01 kasbah kernel:  BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
Jul 21 19:50:01 kasbah kernel:  BIOS-e820: 000000001ff70000 - 000000001ff7f000 (ACPI data)
Jul 21 19:50:01 kasbah kernel:  BIOS-e820: 000000001ff7f000 - 000000001ff80000 (ACPI NVS)
Jul 21 19:50:01 kasbah kernel:  BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
Jul 21 19:50:01 kasbah kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Jul 21 19:50:01 kasbah kernel: 511MB LOWMEM available.
Jul 21 19:50:01 kasbah kernel: On node 0 totalpages: 130928
Jul 21 19:50:01 kasbah kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul 21 19:50:01 kasbah kernel:   Normal zone: 126832 pages, LIFO batch:31
Jul 21 19:50:01 kasbah kernel:   HighMem zone: 0 pages, LIFO batch:1
Jul 21 19:50:01 kasbah kernel: DMI present.
Jul 21 19:50:01 kasbah kernel: ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f72a0
Jul 21 19:50:01 kasbah kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1ff7a9b2
Jul 21 19:50:01 kasbah kernel: ACPI: FADT (v001 NVIDIA CK8      0x06040000 PTL_ 0x000f4240) @ 0x1ff7ee13
Jul 21 19:50:01 kasbah kernel: ACPI: MADT (v001 NVIDIA NV_APIC_ 0x06040000  LTP 0x00000000) @ 0x1ff7ee87
Jul 21 19:50:01 kasbah kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff7eee1
Jul 21 19:50:01 kasbah kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1ff7ef09
Jul 21 19:50:01 kasbah kernel: ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 0x00000000
Jul 21 19:50:01 kasbah kernel: ACPI: PM-Timer IO Port: 0x8008
Jul 21 19:50:01 kasbah kernel: ACPI: Local APIC address 0xfee00000
Jul 21 19:50:01 kasbah kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jul 21 19:50:01 kasbah kernel: Processor #0 15:4 APIC version 16
Jul 21 19:50:01 kasbah kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Jul 21 19:50:01 kasbah kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jul 21 19:50:01 kasbah kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
Jul 21 19:50:01 kasbah kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jul 21 19:50:01 kasbah kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul 21 19:50:01 kasbah kernel: ACPI: BIOS IRQ0 pin2 override ignored.
Jul 21 19:50:01 kasbah kernel: ACPI: IRQ9 used by override.
Jul 21 19:50:01 kasbah kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jul 21 19:50:01 kasbah kernel: Using ACPI (MADT) for SMP configuration information
Jul 21 19:50:01 kasbah kernel: Allocating PCI resources starting at 20000000 (gap: 20000000:dff80000)
Jul 21 19:50:01 kasbah kernel: Built 1 zonelists
Jul 21 19:50:01 kasbah kernel: Kernel command line: boot=/dev/hda root=/dev/hda3
Jul 21 19:50:01 kasbah kernel: mapped APIC to ffffd000 (fee00000)
Jul 21 19:50:01 kasbah kernel: mapped IOAPIC to ffffc000 (fec00000)
Jul 21 19:50:01 kasbah kernel: Initializing CPU#0
Jul 21 19:50:01 kasbah kernel: CPU 0 irqstacks, hard=c03bf000 soft=c03be000
Jul 21 19:50:01 kasbah kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Jul 21 19:50:01 kasbah kernel: Detected 1596.060 MHz processor.
Jul 21 19:50:01 kasbah kernel: Using pmtmr for high-res timesource
Jul 21 19:50:01 kasbah kernel: Console: colour VGA+ 80x25
Jul 21 19:50:01 kasbah kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jul 21 19:50:01 kasbah kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 21 19:50:01 kasbah kernel: Memory: 515244k/523712k available (1854k kernel code, 7908k reserved, 750k data, 176k init, 0k highmem)
Jul 21 19:50:01 kasbah kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jul 21 19:50:01 kasbah kernel: Calibrating delay using timer specific routine.. 3195.35 BogoMIPS (lpj=6390713)
Jul 21 19:50:01 kasbah kernel: Mount-cache hash table entries: 512
Jul 21 19:50:01 kasbah kernel: CPU: After generic identify, caps: 078bfbff c1d3fbff 00000000 00000000 00000000 00000000 00000000
Jul 21 19:50:01 kasbah kernel: CPU: After vendor identify, caps: 078bfbff c1d3fbff 00000000 00000000 00000000 00000000 00000000
Jul 21 19:50:01 kasbah kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 21 19:50:01 kasbah kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jul 21 19:50:01 kasbah kernel: CPU: After all inits, caps: 078bfbff c1d3fbff 00000000 00000010 00000000 00000000 00000000
Jul 21 19:50:01 kasbah kernel: Intel machine check architecture supported.
Jul 21 19:50:01 kasbah kernel: Intel machine check reporting enabled on CPU#0.
Jul 21 19:50:01 kasbah kernel: mtrr: v2.0 (20020519)
Jul 21 19:50:01 kasbah kernel: CPU: AMD Athlon(tm) XP Processor 3000+ stepping 08
Jul 21 19:50:01 kasbah kernel: Enabling fast FPU save and restore... done.
Jul 21 19:50:01 kasbah kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 21 19:50:01 kasbah kernel: Checking 'hlt' instruction... OK.
Jul 21 19:50:01 kasbah kernel: ENABLING IO-APIC IRQs
Jul 21 19:50:01 kasbah kernel: ..TIMER: vector=0x31 pin1=0 pin2=-1
Jul 21 19:50:01 kasbah kernel: NET: Registered protocol family 16
Jul 21 19:50:01 kasbah kernel: ACPI: bus type pci registered
Jul 21 19:50:01 kasbah kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8bc, last bus=2
Jul 21 19:50:01 kasbah kernel: PCI: Using configuration type 1
Jul 21 19:50:01 kasbah kernel: ACPI: Subsystem revision 20050408
Jul 21 19:50:01 kasbah kernel: ACPI: Interpreter enabled
Jul 21 19:50:01 kasbah kernel: ACPI: Using IOAPIC for interrupt routing
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jul 21 19:50:01 kasbah kernel: PCI: Probing PCI hardware (bus 00)
Jul 21 19:50:01 kasbah kernel: ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Jul 21 19:50:01 kasbah kernel: Boot video device is 0000:01:00.0
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jul 21 19:50:01 kasbah kernel: ACPI: Embedded Controller [EC0] (gpe 33)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 16 18 *19)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 16 *18 19)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs *17)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 16 18 19) *0, disabled.
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 16 18 19) *0, disabled.
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22) *0, disabled.
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 *22)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LUS1] (IRQs 20 *21 22)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LUS2] (IRQs *20 21 22)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22) *0, disabled.
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 *22)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 20 *21 22)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22) *0, disabled.
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
Jul 21 19:50:01 kasbah kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul 21 19:50:01 kasbah kernel: pnp: PnP ACPI init
Jul 21 19:50:01 kasbah kernel: pnp: PnP ACPI: found 12 devices
Jul 21 19:50:01 kasbah kernel: PCI: Using ACPI for IRQ routing
Jul 21 19:50:01 kasbah kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jul 21 19:50:01 kasbah kernel: PCI: Bus 3, cardbus bridge: 0000:02:04.0
Jul 21 19:50:01 kasbah kernel:   IO window: 00003000-00003fff
Jul 21 19:50:01 kasbah kernel:   IO window: 00004000-00004fff
Jul 21 19:50:01 kasbah kernel:   PREFETCH window: 20000000-21ffffff
Jul 21 19:50:01 kasbah kernel: PCI: Bus 7, cardbus bridge: 0000:02:04.1
Jul 21 19:50:01 kasbah kernel:   IO window: 00005000-00005fff
Jul 21 19:50:01 kasbah kernel:   IO window: 00006000-00006fff
Jul 21 19:50:01 kasbah kernel:   PREFETCH window: 22000000-23ffffff
Jul 21 19:50:01 kasbah kernel: PCI: Bridge: 0000:00:0a.0
Jul 21 19:50:01 kasbah kernel:   IO window: 3000-7fff
Jul 21 19:50:01 kasbah kernel:   MEM window: e8100000-e97fffff
Jul 21 19:50:01 kasbah kernel:   PREFETCH window: 20000000-23ffffff
Jul 21 19:50:01 kasbah kernel: PCI: Bridge: 0000:00:0b.0
Jul 21 19:50:01 kasbah kernel:   IO window: disabled.
Jul 21 19:50:01 kasbah kernel:   MEM window: ea000000-eaffffff
Jul 21 19:50:01 kasbah kernel:   PREFETCH window: f8000000-fc0fffff
Jul 21 19:50:01 kasbah kernel: PCI: Setting latency timer of device 0000:00:0a.0 to 64
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 19
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNK1] -> GSI 19 (level, low) -> IRQ 16
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 18
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNK2] -> GSI 18 (level, low) -> IRQ 17
Jul 21 19:50:01 kasbah kernel: TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x8000-0x807f could not be reserved
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x8080-0x80ff has been reserved
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x8400-0x847f has been reserved
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x8480-0x84ff could not be reserved
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x8800-0x887f has been reserved
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x8880-0x88ff has been reserved
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x2040-0x207f has been reserved
Jul 21 19:50:01 kasbah kernel: pnp: 00:00: ioport range 0x2000-0x203f has been reserved
Jul 21 19:50:01 kasbah kernel: Simple Boot Flag at 0x36 set to 0x1
Jul 21 19:50:01 kasbah kernel: Initializing Cryptographic API
Jul 21 19:50:01 kasbah kernel: lp: driver loaded but no devices found
Jul 21 19:50:01 kasbah kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jul 21 19:50:01 kasbah kernel: [drm] Initialized drm 1.0.0 20040925
Jul 21 19:50:01 kasbah kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Jul 21 19:50:01 kasbah kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
Jul 21 19:50:01 kasbah kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Jul 21 19:50:01 kasbah kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Jul 21 19:50:01 kasbah kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Jul 21 19:50:01 kasbah kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Jul 21 19:50:01 kasbah kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 21 19:50:01 kasbah kernel: parport: PnPBIOS parport detected.
Jul 21 19:50:01 kasbah kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Jul 21 19:50:01 kasbah kernel: parport0: Printer, HEWLETT-PACKARD DESKJET 670C
Jul 21 19:50:01 kasbah kernel: lp0: using parport0 (interrupt-driven).
Jul 21 19:50:01 kasbah kernel: io scheduler noop registered
Jul 21 19:50:01 kasbah kernel: io scheduler anticipatory registered
Jul 21 19:50:01 kasbah kernel: io scheduler deadline registered
Jul 21 19:50:01 kasbah kernel: io scheduler cfq registered
Jul 21 19:50:01 kasbah kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Jul 21 19:50:01 kasbah kernel: NET: Registered protocol family 24
Jul 21 19:50:01 kasbah kernel: 8139too Fast Ethernet driver 0.9.27
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNK2] -> GSI 18 (level, low) -> IRQ 17
Jul 21 19:50:01 kasbah kernel: eth0: RealTek RTL8139 at 0x7000, 00:02:3f:22:c0:9d, IRQ 17
Jul 21 19:50:01 kasbah kernel: eth0:  Identified 8139 chip type 'RTL-8101'
Jul 21 19:50:01 kasbah kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 21 19:50:01 kasbah kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 21 19:50:01 kasbah kernel: NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
Jul 21 19:50:01 kasbah kernel: NFORCE3-150: chipset revision 165
Jul 21 19:50:01 kasbah kernel: NFORCE3-150: not 100%% native mode: will probe irqs later
Jul 21 19:50:01 kasbah kernel: NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
Jul 21 19:50:01 kasbah kernel: NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
Jul 21 19:50:01 kasbah kernel:     ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
Jul 21 19:50:01 kasbah kernel:     ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio
Jul 21 19:50:01 kasbah kernel: Probing IDE interface ide0...
Jul 21 19:50:01 kasbah kernel: hda: ST94019A, ATA DISK drive
Jul 21 19:50:01 kasbah kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 21 19:50:01 kasbah kernel: Probing IDE interface ide1...
Jul 21 19:50:01 kasbah kernel: hdc: SD-R6252, ATAPI CD/DVD-ROM drive
Jul 21 19:50:01 kasbah kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 21 19:50:01 kasbah kernel: hda: max request size: 1024KiB
Jul 21 19:50:01 kasbah kernel: hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
Jul 21 19:50:01 kasbah kernel: hda: cache flushes supported
Jul 21 19:50:01 kasbah kernel:  hda: hda1 hda2 hda3
Jul 21 19:50:01 kasbah kernel: NET: Registered protocol family 2
Jul 21 19:50:01 kasbah kernel: IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
Jul 21 19:50:01 kasbah kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes)
Jul 21 19:50:01 kasbah kernel: TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
Jul 21 19:50:01 kasbah kernel: TCP: Hash tables configured (established 32768 bind 32768)
Jul 21 19:50:01 kasbah kernel: TCP reno registered
Jul 21 19:50:01 kasbah kernel: Using IPI Shortcut mode
Jul 21 19:50:01 kasbah kernel: ACPI wakeup devices:
Jul 21 19:50:01 kasbah kernel: USB0 USB1 USB2 MAC0
Jul 21 19:50:01 kasbah kernel: ACPI: (supports S0 S3 S4 S5)
Jul 21 19:50:01 kasbah kernel: input: AT Raw Set 2 keyboard on isa0060/serio0
Jul 21 19:50:01 kasbah kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 21 19:50:01 kasbah kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jul 21 19:50:01 kasbah kernel: Freeing unused kernel memory: 176k freed
Jul 21 19:50:01 kasbah kernel: kjournald starting.  Commit interval 5 seconds
Jul 21 19:50:01 kasbah kernel: NET: Registered protocol family 1
Jul 21 19:50:01 kasbah kernel: Adding 996020k swap on /dev/hda2.  Priority:-1 extents:1
Jul 21 19:50:01 kasbah kernel: EXT3 FS on hda3, internal journal
Jul 21 19:50:01 kasbah kernel: ACPI: CPU0 (power states: C1[C1])
Jul 21 19:50:01 kasbah kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
Jul 21 19:50:01 kasbah kernel: powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
Jul 21 19:50:01 kasbah kernel: powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x18 (950 mV)
Jul 21 19:50:01 kasbah kernel: cpu_init done, current fid 0x8, vid 0x6
Jul 21 19:50:01 kasbah kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Jul 21 19:50:01 kasbah kernel: Uniform CD-ROM driver Revision: 3.20
Jul 21 19:50:01 kasbah kernel: usbcore: registered new driver usbfs
Jul 21 19:50:01 kasbah kernel: usbcore: registered new driver hub
Jul 21 19:50:01 kasbah kernel: ndiswrapper version 1.1 loaded (preempt=yes,smp=no)
Jul 21 19:50:01 kasbah kernel: ndiswrapper: driver bcmwl5a (ASUS,07/17/2003, 3.30.15.0) loaded
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 17
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNK3] -> GSI 17 (level, low) -> IRQ 18
Jul 21 19:50:01 kasbah kernel: ndiswrapper: using irq 18
Jul 21 19:50:01 kasbah kernel: wlan0: ndiswrapper ethernet device 00:90:4b:57:40:c9 using driver bcmwl5a, configuration file 14E4:4301.5.conf
Jul 21 19:50:01 kasbah kernel: wlan0: encryption modes supported: WEP, WPA with TKIP
Jul 21 19:50:01 kasbah kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x2040
Jul 21 19:50:01 kasbah kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
Jul 21 19:50:01 kasbah kernel: kjournald starting.  Commit interval 5 seconds
Jul 21 19:50:01 kasbah kernel: EXT3 FS on hda1, internal journal
Jul 21 19:50:01 kasbah kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 21 19:50:01 kasbah kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 22
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 22 (level, low) -> IRQ 19
Jul 21 19:50:01 kasbah kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
Jul 21 19:50:01 kasbah kernel: ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
Jul 21 19:50:01 kasbah kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Jul 21 19:50:01 kasbah kernel: ohci_hcd 0000:00:02.0: irq 19, io mem 0xe8000000
Jul 21 19:50:01 kasbah kernel: hub 1-0:1.0: USB hub found
Jul 21 19:50:01 kasbah kernel: hub 1-0:1.0: 3 ports detected
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 21
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 21 (level, low) -> IRQ 20
Jul 21 19:50:01 kasbah kernel: PCI: Setting latency timer of device 0000:00:02.1 to 64
Jul 21 19:50:01 kasbah kernel: ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
Jul 21 19:50:01 kasbah kernel: ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
Jul 21 19:50:01 kasbah kernel: ohci_hcd 0000:00:02.1: irq 20, io mem 0xe8001000
Jul 21 19:50:01 kasbah kernel: hub 2-0:1.0: USB hub found
Jul 21 19:50:01 kasbah kernel: hub 2-0:1.0: 3 ports detected
Jul 21 19:50:01 kasbah kernel: usb 1-2: new low speed USB device using ohci_hcd and address 2
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 20 (level, low) -> IRQ 21
Jul 21 19:50:01 kasbah kernel: PCI: Setting latency timer of device 0000:00:02.2 to 64
Jul 21 19:50:01 kasbah kernel: ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
Jul 21 19:50:01 kasbah kernel: ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
Jul 21 19:50:01 kasbah kernel: ehci_hcd 0000:00:02.2: irq 21, io mem 0xe8004000
Jul 21 19:50:01 kasbah kernel: PCI: cache line size of 64 is not supported by device 0000:00:02.2
Jul 21 19:50:01 kasbah kernel: ehci_hcd 0000:00:02.2: park 0
Jul 21 19:50:01 kasbah kernel: ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Jul 21 19:50:01 kasbah kernel: hub 3-0:1.0: USB hub found
Jul 21 19:50:01 kasbah kernel: hub 3-0:1.0: 6 ports detected
Jul 21 19:50:01 kasbah kernel: usb 1-2: device descriptor read/all, error -110
Jul 21 19:50:01 kasbah kernel: usb 1-2: new low speed USB device using ohci_hcd and address 4
Jul 21 19:50:01 kasbah kernel: PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LACI] enabled at IRQ 22
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low) -> IRQ 19
Jul 21 19:50:01 kasbah kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
Jul 21 19:50:01 kasbah kernel: usbcore: registered new driver hiddev
Jul 21 19:50:01 kasbah kernel: input: USB HID v1.10 Mouse [Genius NetScroll + Mini Traveler] on usb-0000:00:02.0-2
Jul 21 19:50:01 kasbah kernel: usbcore: registered new driver usbhid
Jul 21 19:50:01 kasbah kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver

Jul 21 19:50:01 kasbah kernel: AC'97 warm reset still in progress? [0xffffffff]

Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 21
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LMCI] -> GSI 21 (level, low) -> IRQ 20
Jul 21 19:50:01 kasbah kernel: PCI: Setting latency timer of device 0000:00:06.1 to 64
Jul 21 19:50:01 kasbah kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNK1] -> GSI 19 (level, low) -> IRQ 16
Jul 21 19:50:01 kasbah kernel: Yenta: CardBus bridge found at 0000:02:04.0 [103c:006d]
Jul 21 19:50:01 kasbah kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Jul 21 19:50:01 kasbah kernel: Yenta: Routing CardBus interrupts to PCI
Jul 21 19:50:01 kasbah kernel: Yenta TI: socket 0000:02:04.0, mfunc 0x01111d22, devctl 0x64
Jul 21 19:50:01 kasbah kernel: Yenta: ISA IRQ mask 0x0c78, PCI irq 16
Jul 21 19:50:01 kasbah kernel: Socket status: 30000086
Jul 21 19:50:01 kasbah kernel: pcmcia: parent PCI bridge I/O window: 0x3000 - 0x7fff
Jul 21 19:50:01 kasbah kernel: cs: IO port probe 0x3000-0x7fff: clean.
Jul 21 19:50:01 kasbah kernel: pcmcia: parent PCI bridge Memory window: 0xe8100000 - 0xe97fffff
Jul 21 19:50:01 kasbah kernel: pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x23ffffff
Jul 21 19:50:01 kasbah kernel: ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNK2] -> GSI 18 (level, low) -> IRQ 17
Jul 21 19:50:01 kasbah kernel: Yenta: CardBus bridge found at 0000:02:04.1 [103c:006d]
Jul 21 19:50:01 kasbah kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Jul 21 19:50:01 kasbah kernel: Yenta: Routing CardBus interrupts to PCI
Jul 21 19:50:01 kasbah kernel: Yenta TI: socket 0000:02:04.1, mfunc 0x01111d22, devctl 0x64
Jul 21 19:50:01 kasbah kernel: Yenta: ISA IRQ mask 0x0c78, PCI irq 17
Jul 21 19:50:01 kasbah kernel: Socket status: 30000086
Jul 21 19:50:01 kasbah kernel: pcmcia: parent PCI bridge I/O window: 0x3000 - 0x7fff
Jul 21 19:50:01 kasbah kernel: cs: IO port probe 0x3000-0x7fff: clean.
Jul 21 19:50:01 kasbah kernel: pcmcia: parent PCI bridge Memory window: 0xe8100000 - 0xe97fffff
Jul 21 19:50:01 kasbah kernel: pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x23ffffff
Jul 21 19:50:01 kasbah kernel: Real Time Clock Driver v1.12
Jul 21 19:50:01 kasbah kernel: alps.c: Enabling hardware tapping
Jul 21 19:50:01 kasbah kernel: input: PS/2 Mouse on isa0060/serio4
Jul 21 19:50:01 kasbah kernel: input: AlpsPS/2 ALPS GlidePoint on isa0060/serio4
Jul 21 19:50:01 kasbah kernel: ts: Compaq touchscreen protocol output
Jul 21 19:50:01 kasbah kernel: mice: PS/2 mouse device common for all mice
Jul 21 19:50:01 kasbah kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Jul 21 19:50:01 kasbah kernel: ACPI: Battery Slot [BAT1] (battery present)
Jul 21 19:50:01 kasbah kernel: ACPI: AC Adapter [ACAD] (on-line)
Jul 21 19:50:01 kasbah kernel: ACPI: Power Button (FF) [PWRF]
Jul 21 19:50:01 kasbah kernel: ACPI: Power Button (CM) [PWRB]
Jul 21 19:50:01 kasbah kernel: ACPI: Lid Switch [LID]
Jul 21 19:50:02 kasbah kernel: ACPI: Thermal Zone [THRM] (53 C)
Jul 21 19:50:03 kasbah kernel: lp0: ECP mode
Jul 21 19:50:06 kasbah /usr/sbin/gpm[4783]: Detected EXPS/2 protocol mouse.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
