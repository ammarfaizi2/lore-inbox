Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUK0RDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUK0RDF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUK0RAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:00:52 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:20865 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261262AbUK0Q6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:58:32 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Kernel oops... driver core / scsi / usb ?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 27 Nov 2004 17:56:26 +0100
Message-ID: <m3sm6v44ed.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

not investigated further yet, probably someone will know what's wrong:
Linux 2.6.10-rc2 (gcc 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #3 Nov 23 21:07:52
(using CVS gate).

Full dmesg and .config is attached below.

usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: modprobe timed out on ep0in
usbcore: registered new driver speedtch
usbcore: deregistering driver speedtch
usb 1-1: USB disconnect, address 2 <<<<<<<<<<< speedtch is a DSL ATM device,
    being removed.

usb_storage: Unknown symbol scsi_report_device_reset
usb_storage: Unknown symbol scsi_remove_host
usb_storage: Unknown symbol scsi_host_put
usb_storage: Unknown symbol scsi_scan_host
usb_storage: Unknown symbol scsi_add_host
usb_storage: Unknown symbol scsi_host_alloc
Not sure why (hotplug/modprobe -related maybe, it shouldn't affect the kernel)

Badness in kref_get at /usr/src/linux-2.6/lib/kref.c:32
 [<c0174df3>] kref_get+0x24/0x2b
 [<c017469f>] kobject_get+0xf/0x13
 [<c01b5916>] get_bus+0xe/0x1e
 [<c01b523c>] __bus_for_each_dev+0x11/0x74
 [<c01b5329>] bus_for_each_dev+0x1c/0x32
...

and then:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
EIP is at __bus_for_each_dev+0x33/0x74
Process updfstab (pid: 3981, threadinfo=c3279000 task=c2e3d0a0)
        ^^^^^^^^
hotplug-spawned I think.

Call Trace:
 [<c01b5329>] bus_for_each_dev+0x1c/0x32
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c889ebb4>] proc_scsi_show+0x21/0x28 [scsi_mod]
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c014d2d9>] seq_read+0xc9/0x220
 [<c0136a5d>] vfs_read+0x9d/0xc9
 [<c0136c57>] sys_read+0x3c/0x62
 [<c0101d39>] sysenter_past_esp+0x52/0x71

Ideas?
-- 
Krzysztof Halasa

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y

CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_REGPARM=y

CONFIG_PM=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y

CONFIG_PCCARD=y
CONFIG_CARDBUS=y

CONFIG_YENTA=y
CONFIG_PCMCIA_PROBE=y

CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_INITRAMFS_SOURCE=""

CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_CFQ=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y

CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

CONFIG_BLK_DEV_SD=m

CONFIG_SCSI_QLA2XXX=m

CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_TCPDIAG=y

CONFIG_NETFILTER=y

CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_NAT_FTP=y

CONFIG_ATM=y

CONFIG_IRDA=m

CONFIG_IRCOMM=m

CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y

CONFIG_NSC_FIR=m
CONFIG_NETDEVICES=y

CONFIG_NET_ETHERNET=y
CONFIG_MII=m

CONFIG_NET_TULIP=y
CONFIG_TULIP=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCI=y

CONFIG_PPP=y
CONFIG_PPP_ASYNC=m
CONFIG_PPPOATM=y

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y

CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_N_HDLC=m

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=1

CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y

CONFIG_RTC=y

CONFIG_HPET=y
CONFIG_HPET_MMAP=y

CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

CONFIG_I2C_ISA=m
CONFIG_I2C_PIIX4=m

CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

CONFIG_SENSORS_EEPROM=m
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y

CONFIG_VIDEO_SELECT=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

CONFIG_SOUND=y

CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m

CONFIG_SND_AC97_CODEC=y
CONFIG_SND_MAESTRO3=y

CONFIG_USB=y

CONFIG_USB_DEVICEFS=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

CONFIG_USB_UHCI_HCD=y

CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_RW_DETECT=y

CONFIG_USB_ATM=y
CONFIG_USB_SPEEDTOUCH=m

CONFIG_EXT2_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_DNOTIFY=y

CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=852
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-2"

CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"

CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y

CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_UTF8=m

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_4KSTACKS=y

CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y

Linux version 2.6.10-rc2 (khc@defiant) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #3 Tue Nov 23 21:07:52 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fffeac00 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7400
ACPI: RSDT (v001 PTLTD  C3 RSDT  0xf0cf0033  LTP 0x00000000) @ 0x07ffaabe
ACPI: FADT (v001 QUANTA C3 FACP  0xf0cf0033 PTL  0x000f4240) @ 0x07fffb8c
ACPI: DSDT (v001    PTL C3 DSDT  0xf0cf0033 MSFT 0x0100000c) @ 0x00000000
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=L2.6.10rc2 root=301 BOOT_FILE=/lib/modules/2.6.10-rc2/bzImage
Initializing CPU#0
CPU 0 irqstacks, hard=c0366000 soft=c0365000
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 597.342 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126608k/131008k available (1403k kernel code, 3884k reserved, 923k data, 100k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1179.64 BogoMIPS (lpj=589824)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0420)
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 0)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (45 C)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 5 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler cfq registered
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N020ATMR04-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 39070080 sectors (20003 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:00:0a.0 [110a:0015]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x012c1222, devctl 0x64
Yenta: ISA IRQ mask 0x08b8, PCI irq 10
Socket status: 30000006
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0a.1[B] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:00:0a.1 [110a:0015]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.1, mfunc 0x012c1222, devctl 0x64
Yenta: ISA IRQ mask 0x08b8, PCI irq 10
Socket status: 30000006
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: irq 10, io base 0xfce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 4.6
 Sensor: 19
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 5 (level, low) -> IRQ 5
ALSA device list:
  #0: ESS Maestro3 PCI at 0xf800, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
ip_conntrack version 2.1 (1023 buckets, 8184 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 100k freed
EXT3 FS on hda1, internal journal
Adding 393584k swap on /dev/hda2.  Priority:-1 extents:1
loop: loaded (max 8 devices)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:02:00.0 to 64
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #0 config 3000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 00014000, 00:50:BA:70:68:3E, IRQ 10.
usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: modprobe timed out on ep0in
usbcore: registered new driver speedtch
usbcore: deregistering driver speedtch
usb 1-1: USB disconnect, address 2
usb_storage: Unknown symbol scsi_report_device_reset
usb_storage: Unknown symbol scsi_remove_host
usb_storage: Unknown symbol scsi_host_put
usb_storage: Unknown symbol scsi_scan_host
usb_storage: Unknown symbol scsi_add_host
usb_storage: Unknown symbol scsi_host_alloc
Badness in kref_get at /usr/src/linux-2.6/lib/kref.c:32
 [<c0174df3>] kref_get+0x24/0x2b
 [<c017469f>] kobject_get+0xf/0x13
 [<c01b5916>] get_bus+0xe/0x1e
 [<c01b523c>] __bus_for_each_dev+0x11/0x74
 [<c01b5329>] bus_for_each_dev+0x1c/0x32
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c889ebb4>] proc_scsi_show+0x21/0x28 [scsi_mod]
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c014d2d9>] seq_read+0xc9/0x220
 [<c0136a5d>] vfs_read+0x9d/0xc9
 [<c0136c57>] sys_read+0x3c/0x62
 [<c0101d39>] sysenter_past_esp+0x52/0x71
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01b525e
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: scsi_mod tulip nls_iso8859_2 isofs nls_base loop
CPU:    0
EIP:    0060:[<c01b525e>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc2) 
EIP is at __bus_for_each_dev+0x33/0x74
eax: c88a6b60   ebx: fffffff8   ecx: c88a6ac4   edx: 00000000
esi: c88a6ac0   edi: 00000000   ebp: c88a6b68   esp: c3279f20
ds: 007b   es: 007b   ss: 0068
Process updfstab (pid: 3981, threadinfo=c3279000 task=c2e3d0a0)
Stack: c2419c20 c88a6ac0 c88a6b0c 00000001 00004000 c01b5329 c889e818 c2419c20 
       c2419c20 c889ebb4 c889e818 c2419c20 c88a074e 00000001 c014d2d9 c4eda000 
       00000000 bfffbb00 c544664c c7fe4f80 00000000 00000000 c88a6e40 c26754c0 
Call Trace:
 [<c01b5329>] bus_for_each_dev+0x1c/0x32
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c889ebb4>] proc_scsi_show+0x21/0x28 [scsi_mod]
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c014d2d9>] seq_read+0xc9/0x220
 [<c0136a5d>] vfs_read+0x9d/0xc9
 [<c0136c57>] sys_read+0x3c/0x62
 [<c0101d39>] sysenter_past_esp+0x52/0x71
Code: d3 89 0c 24 e8 cc 06 00 00 89 c6 85 f6 b8 ea ff ff ff 74 52 8d 86 a0 00 00 00 85 db 8d ae a8 00 00 00 0f 44 d8 8b 53 08 8d 5a f8 <8b> 43 08 0f 18 00 90 39 ea 74 27 89 d8 e8 a7 f7 ff ff 8b 14 24 
 <4>usb_storage: Unknown symbol scsi_report_device_reset
usb_storage: Unknown symbol scsi_remove_host
usb_storage: Unknown symbol scsi_host_put
usb_storage: Unknown symbol scsi_scan_host
usb_storage: Unknown symbol scsi_add_host
usb_storage: Unknown symbol scsi_host_alloc
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01b525e
*pde = 00000000
Oops: 0000 [#2]
Modules linked in: scsi_mod tulip nls_iso8859_2 isofs nls_base loop
CPU:    0
EIP:    0060:[<c01b525e>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc2) 
EIP is at __bus_for_each_dev+0x33/0x74
eax: c88a6b60   ebx: fffffff8   ecx: c88a6ac4   edx: 00000000
esi: c88a6ac0   edi: 00000000   ebp: c88a6b68   esp: c25bcf20
ds: 007b   es: 007b   ss: 0068
Process updfstab (pid: 3983, threadinfo=c25bc000 task=c25b55c0)
Stack: c789c4e0 c88a6ac0 c88a6b0c 00000001 00004000 c01b5329 c889e818 c789c4e0 
       c789c4e0 c889ebb4 c889e818 c789c4e0 c88a074e 00000001 c014d2d9 c4eda000 
       00000000 bfffbb40 c5528d9c c7fe4f80 00000000 00000000 c88a6e40 c567d560 
Call Trace:
 [<c01b5329>] bus_for_each_dev+0x1c/0x32
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c889ebb4>] proc_scsi_show+0x21/0x28 [scsi_mod]
 [<c889e818>] proc_print_scsidevice+0x0/0x165 [scsi_mod]
 [<c014d2d9>] seq_read+0xc9/0x220
 [<c0136a5d>] vfs_read+0x9d/0xc9
 [<c0136c57>] sys_read+0x3c/0x62
 [<c0101d39>] sysenter_past_esp+0x52/0x71
Code: d3 89 0c 24 e8 cc 06 00 00 89 c6 85 f6 b8 ea ff ff ff 74 52 8d 86 a0 00 00 00 85 db 8d ae a8 00 00 00 0f 44 d8 8b 53 08 8d 5a f8 <8b> 43 08 0f 18 00 90 39 ea 74 27 89 d8 e8 a7 f7 ff ff 8b 14 24 
 <5>SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: deregistering driver usb-storage
inserting floppy driver for 2.6.10-rc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
usb 1-1: new full speed USB device using uhci_hcd and address 3
usb 1-1: device descriptor read/64, error -71
usb 1-1: device descriptor read/64, error -71
usb 1-1: new full speed USB device using uhci_hcd and address 4
usb 1-1: device descriptor read/64, error -71
usb 1-1: device descriptor read/64, error -71
