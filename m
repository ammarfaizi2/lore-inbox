Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbULVKL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbULVKL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 05:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbULVKL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 05:11:28 -0500
Received: from CPE-139-168-157-43.nsw.bigpond.net.au ([139.168.157.43]:34290
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261958AbULVKKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 05:10:54 -0500
Message-ID: <41C94828.9050001@eyal.emu.id.au>
Date: Wed, 22 Dec 2004 21:10:48 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc3-bk13 oops removing ide-scsi
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000901000903010704030103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901000903010704030103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I executed
	modprobe -r st
	modprobe -r sg
	modprobe -r ide-scsi
when I got an oops and the machine froze up. Attached is the console
as captured serially.

The ide errors relate to an attempt to sccess /dev/hdc which was at the
time taken over by ide-scsi.

Here is the final part:
=======================
Unable to handle kernel NULL pointer dereference at virtual address 0000024c
  printing eip:
f90e1466
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: ide_floppy ide_tape nls_iso8859_1 smbfs tsdev psmouse v4l1_compat dvb_bt8xx dvb_core nxt6000 mt352 dst sp887x i810_audio ac97_codec sr_mod ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod snd_bt87x bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport evdev nls_cp437 msdos fat dm_mod rtc unix
CPU:    0
EIP:    0060:[<f90e1466>]    Not tainted VLI
EFLAGS: 00010012   (2.6.10-rc3-bk13)
EIP is at idescsi_queue+0x119/0x402 [ide_scsi]
eax: 00000000   ebx: f700b480   ecx: f9021aaa   edx: f75fd200
esi: f75fd25e   edi: c04515c0   ebp: f75fd254   esp: f76ecc84
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 11397, threadinfo=f76ec000 task=f6edd520)
Stack: c1920680 00000020 dbc09689 f700b480 00000000 00000246 c0125504 f7a52580
        00000240 c04515c0 f77fd800 00000293 f75fd200 f77fd800 00000000 f902184c
        f75fd200 f9021aaa f9024192 f75fd28c f75fd200 f77fd400 f77fd800 f7c9a02c
Call Trace:
  [<c0125504>] __mod_timer+0xeb/0x12a
  [<f902184c>] scsi_dispatch_cmd+0x184/0x26a [scsi_mod]
  [<f9021aaa>] scsi_done+0x0/0x2f [scsi_mod]
  [<f9024192>] scsi_times_out+0x0/0xb8 [scsi_mod]
  [<f902726b>] scsi_request_fn+0x1fc/0x3be [scsi_mod]
  [<c021a99f>] __elv_add_request+0x78/0xbe
  [<c021d33c>] blk_insert_request+0xac/0xca
  [<f9025f3e>] scsi_insert_special_req+0x3a/0x40 [scsi_mod]
  [<f90261b4>] scsi_wait_req+0x71/0xa3 [scsi_mod]
  [<f90260c4>] scsi_wait_done+0x0/0x7f [scsi_mod]
  [<f915c43b>] sr_do_ioctl+0x8b/0x281 [sr_mod]
  [<f915c10b>] sr_packet+0x25/0x39 [sr_mod]
  [<f916d6c4>] cdrom_get_disc_info+0x61/0xae [cdrom]
  [<f91696e4>] cdrom_mrw_exit+0x1b/0x66 [cdrom]
  [<f9169312>] unregister_cdrom+0x90/0xbe [cdrom]
  [<f915c162>] sr_kref_release+0x43/0x6a [sr_mod]
  [<f915c11f>] sr_kref_release+0x0/0x6a [sr_mod]
  [<c01bf6ac>] kref_put+0x3a/0x92
  [<c01becf1>] kobject_put+0x1e/0x22
  [<f915c1c2>] sr_remove+0x39/0x50 [sr_mod]
  [<f915c11f>] sr_kref_release+0x0/0x6a [sr_mod]
  [<c021732a>] device_release_driver+0x7f/0x81
  [<c0217546>] bus_remove_device+0x65/0xa7
  [<c0216463>] device_del+0x5f/0x9d
  [<f9029ecc>] scsi_remove_device+0x59/0xaf [scsi_mod]
  [<f90291b0>] scsi_forget_host+0x35/0x5a [scsi_mod]
  [<f902236a>] scsi_remove_host+0x13/0x72 [scsi_mod]
  [<f90e1238>] idescsi_cleanup+0x4d/0x59 [ide_scsi]
  [<c022bd76>] ide_unregister_driver+0x71/0xa3
  [<f90e1d06>] exit_idescsi_module+0x0/0x13 [ide_scsi]
  [<f90e1d15>] exit_idescsi_module+0xf/0x13 [ide_scsi]
  [<c0133366>] sys_delete_module+0x14e/0x181
  [<c014bc99>] sys_munmap+0x51/0x76
  [<c0103093>] syscall_call+0x7/0xb
Code: 00 00 8b 54 24 40 8b 42 64 89 53 2c 89 43 14 89 43 0c 8b 4c 24 44 89 4b 30 a1 c0 9b 2f c0 03 42 3c 89 43 38 8b 7c 24 24 8b 47 20 <8b> 80 4c 02 00 00 a8 01 74 06 f0 0f ba 6b 34 02 8b 43 1c 89 44
  <6>note: modprobe[11397] exited with preempt_count 1

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat

--------------000901000903010704030103
Content-Type: text/plain;
 name="bk13.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk13.log"

Restarting system.
Linux version 2.6.10-rc3-bk13 (root@e7) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 SMP Tue Dec 21 10:15:50 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5200
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.10-rc3-bk13 ro root=306 console=ttyS0,38400 console=tty0
Initializing CPU#0
CPU 0 irqstacks, hard=c040c000 soft=c0404000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3014.411 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035104k/1048512k available (1747k kernel code, 12832k reserved, 1024k data, 292k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.67 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (5980.16 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Brought up 1 CPUs
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb500, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200BB-00DWA0, ATA DISK drive
hdb: WDC WD2000JB-55GVA0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ATAPI DVD RW 8XMax, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-115 0122, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p2 p3 p4 < p5 p6 p7 >
hdb: max request size: 1024KiB
hdb: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: p1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 1
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ACPI wakeup devices: 
SLPB PCI0 CSAD HUB0 USB0 USB1 USB2 USB3 USBE 
ACPI: (supports S0 S1 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 292k freed
NET: Registered protocol family 1
Adding 2097140k swap on /dev/hda5.  Priority:1 extents:1
Real Time Clock Driver v1.12
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
parport_pc: Unknown parameter `io'
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xd0000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
uhci_hcd 0000:00:1d.0: irq 16, io base 0xbc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
uhci_hcd 0000:00:1d.1: irq 19, io base 0xb000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: irq 18, io base 0xb400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
uhci_hcd 0000:00:1d.3: irq 16, io base 0xb800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xde100000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
hw_random: RNG not detected
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
Found: SST 49LF004B
ichxrom @fff00000: Found 1 x8 devices at 0x0 in 8-bit bank
using fwh lock/unlock method
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Found: SST 49LF004B
ichxrom @fff80000: Found 1 x8 devices at 0x0 in 8-bit bank
using fwh lock/unlock method
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Intel 810 + AC97 Audio, version 1.01, 10:35:22 Dec 21 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 17
i810: Intel ICH5 mmio at 0xf89aa000 and 0xf8a08000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 21 (level, low) -> IRQ 21
bttv0: Bt848 (rev 18) at 0000:03:01.0, irq: 21, latency: 32, mmio: 0xde000000
bttv0: using: STB, Gateway P/N 6000699 (bt848) [card=3,insmod option]
bttv0: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by insmod option
tuner: The type=<n> insmod option will go away soon.
tuner: Please use the tuner=<n> option provided by
tuner: tv aard core driver (bttv, saa7134, ...) instead.
bttv0: using tuner=2
tuner: type already set to 5, ignoring request for 2
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL can sleep, using XTAL (35468950).
bttv: Bt8xx card found (1).
ACPI: PCI interrupt 0000:03:02.0[A] -> GSI 22 (level, low) -> IRQ 22
bttv1: Bt878 (rev 17) at 0000:03:02.0, irq: 22, latency: 32, mmio: 0xde001000
bttv1: detected: AVermedia DVB-T 771 [card=123], PCI subsystem ID is 1461:0771
bttv1: using: AVerMedia AVerTV DVB-T 771 [card=123,autodetected]
bttv1: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv1: using tuner=4
bttv1: registered device video1
bttv1: registered device vbi1
bttv1: PLL: 28636363 => 35468950 .. ok
bttv1: add subdevice "remote1"
bttv1: add subdevice "dvb1"
bttv: Bt8xx card found (2).
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv2: Bt878 (rev 17) at 0000:03:03.0, irq: 16, latency: 32, mmio: 0xde003000
bttv2: detected: AverMedia AverTV DVB-T [card=124], PCI subsystem ID is 1461:0761
bttv2: using: AverMedia AverTV DVB-T 761 [card=124,autodetected]
bttv2: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv2: using tuner=-1
bttv2: registered device video2
bttv2: registered device vbi2
bttv2: PLL: 28636363 => 35468950 .. ok
bttv2: add subdevice "remote2"
bttv2: add subdevice "dvb2"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:03:02.1[A] -> GSI 22 (level, low) -> IRQ 22
bt878(0): Bt878 (rev 17) at 03:02.1, irq: 22, latency: 32, memory: 0xde002000
bt878: Bt878 AUDIO function found (1).
ACPI: PCI interrupt 0000:03:03.1[A] -> GSI 16 (level, low) -> IRQ 16
bt878(1): Bt878 (rev 17) at 03:03.1, irq: 16, latency: 32, memory: 0xde004000
btaudio: driver version 0.7 loaded [digital+analog]
SCSI subsystem initialized
dc395x: Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 18
dc395x: Used settings: AdapterID=07, Speed=0(20.0MHz), dev_mode=0x57
dc395x:                AdaptMode=0x0f, Tags=4(16), DelayReset=1s
dc395x: Connectors: ext50  Termination: Auto Low High 
dc395x: Performing initial SCSI bus reset
scsi0 : Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 21 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[dd004000-dd0047ff]  Max Packet=[2048]
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ide-cd: ignoring drive hdc
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: ATAPI     Model: DVD RW 8XMax      Rev: 130D
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Intel 810 + AC97 Audio, version 1.01, 10:35:22 Dec 21 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 17
i810: Intel ICH5 mmio at 0xf8a08000 and 0xf8a4e000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
DVB: registering new adapter (bttv1).
DVB: registering frontend 0 (Zarlink MT352 DVB-T)...
DVB: registering new adapter (bttv2).
DVB: registering frontend 1 (Spase SP887x DVB-T)...
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
sp887x: waiting for firmware upload...
i2c_adapter i2c-3: sendbytes: error - bailout.
sp887x_initial_setup: firmware upload... 
Debian GNU/Linux 3.1 e7 ttyS0

e7 login: done.
smbfs: Unrecognized mount option noauto
scsi: unknown opcode 0x1e
scsi: unknown opcode 0x55
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }

ide: failed opcode was: unknown
hdb: DMA disabled
hda: drive not ready for command
ide0: reset: success
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d 
ide-floppy driver 0.99.newide
Unable to handle kernel NULL pointer dereference at virtual address 0000024c
 printing eip:
f90e1466
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: ide_floppy ide_tape nls_iso8859_1 smbfs tsdev psmouse v4l1_compat dvb_bt8xx dvb_core nxt6000 mt352 dst sp887x i810_audio ac97_codec sr_mod ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod snd_bt87x bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport evdev nls_cp437 msdos fat dm_mod rtc unix
CPU:    0
EIP:    0060:[<f90e1466>]    Not tainted VLI
EFLAGS: 00010012   (2.6.10-rc3-bk13) 
EIP is at idescsi_queue+0x119/0x402 [ide_scsi]
eax: 00000000   ebx: f700b480   ecx: f9021aaa   edx: f75fd200
esi: f75fd25e   edi: c04515c0   ebp: f75fd254   esp: f76ecc84
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 11397, threadinfo=f76ec000 task=f6edd520)
Stack: c1920680 00000020 dbc09689 f700b480 00000000 00000246 c0125504 f7a52580 
       00000240 c04515c0 f77fd800 00000293 f75fd200 f77fd800 00000000 f902184c 
       f75fd200 f9021aaa f9024192 f75fd28c f75fd200 f77fd400 f77fd800 f7c9a02c 
Call Trace:
 [<c0125504>] __mod_timer+0xeb/0x12a
 [<f902184c>] scsi_dispatch_cmd+0x184/0x26a [scsi_mod]
 [<f9021aaa>] scsi_done+0x0/0x2f [scsi_mod]
 [<f9024192>] scsi_times_out+0x0/0xb8 [scsi_mod]
 [<f902726b>] scsi_request_fn+0x1fc/0x3be [scsi_mod]
 [<c021a99f>] __elv_add_request+0x78/0xbe
 [<c021d33c>] blk_insert_request+0xac/0xca
 [<f9025f3e>] scsi_insert_special_req+0x3a/0x40 [scsi_mod]
 [<f90261b4>] scsi_wait_req+0x71/0xa3 [scsi_mod]
 [<f90260c4>] scsi_wait_done+0x0/0x7f [scsi_mod]
 [<f915c43b>] sr_do_ioctl+0x8b/0x281 [sr_mod]
 [<f915c10b>] sr_packet+0x25/0x39 [sr_mod]
 [<f916d6c4>] cdrom_get_disc_info+0x61/0xae [cdrom]
 [<f91696e4>] cdrom_mrw_exit+0x1b/0x66 [cdrom]
 [<f9169312>] unregister_cdrom+0x90/0xbe [cdrom]
 [<f915c162>] sr_kref_release+0x43/0x6a [sr_mod]
 [<f915c11f>] sr_kref_release+0x0/0x6a [sr_mod]
 [<c01bf6ac>] kref_put+0x3a/0x92
 [<c01becf1>] kobject_put+0x1e/0x22
 [<f915c1c2>] sr_remove+0x39/0x50 [sr_mod]
 [<f915c11f>] sr_kref_release+0x0/0x6a [sr_mod]
 [<c021732a>] device_release_driver+0x7f/0x81
 [<c0217546>] bus_remove_device+0x65/0xa7
 [<c0216463>] device_del+0x5f/0x9d
 [<f9029ecc>] scsi_remove_device+0x59/0xaf [scsi_mod]
 [<f90291b0>] scsi_forget_host+0x35/0x5a [scsi_mod]
 [<f902236a>] scsi_remove_host+0x13/0x72 [scsi_mod]
 [<f90e1238>] idescsi_cleanup+0x4d/0x59 [ide_scsi]
 [<c022bd76>] ide_unregister_driver+0x71/0xa3
 [<f90e1d06>] exit_idescsi_module+0x0/0x13 [ide_scsi]
 [<f90e1d15>] exit_idescsi_module+0xf/0x13 [ide_scsi]
 [<c0133366>] sys_delete_module+0x14e/0x181
 [<c014bc99>] sys_munmap+0x51/0x76
 [<c0103093>] syscall_call+0x7/0xb
Code: 00 00 8b 54 24 40 8b 42 64 89 53 2c 89 43 14 89 43 0c 8b 4c 24 44 89 4b 30 a1 c0 9b 2f c0 03 42 3c 89 43 38 8b 7c 24 24 8b 47 20 <8b> 80 4c 02 00 00 a8 01 74 06 f0 0f ba 6b 34 02 8b 43 1c 89 44 
 <6>note: modprobe[11397] exited with preempt_count 1

--------------000901000903010704030103--
