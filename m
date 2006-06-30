Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWF3Sl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWF3Sl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWF3Sl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:41:58 -0400
Received: from mail.electro-mechanical.com ([216.184.71.30]:51282 "EHLO
	mail.electro-mechanical.com") by vger.kernel.org with ESMTP
	id S932163AbWF3Sl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:41:57 -0400
Date: Fri, 30 Jun 2006 14:41:56 -0400
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: SATA in 2.6.17 vs 2.6.15 (x86/ICH6)
Message-ID: <20060630184156.GA8086@electro-mechanical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** I'm not on the list, please always keep me in CC ***

The speed of SATA in 2.6.17 is significantly lower in my test than 2.6.15.

In .15, I would see over 10mb/sec avg writing over 16,000 files (~2.4gb) to a
fat32 partition.

In .17, I see it start at 2-3mb/sec and work it's way down to 500kb/sec
towards the end.  Even the system is not as responsive (The system's / is a
tmpfs which all programs, including /usr, are stored), not even when using
ssh.

I used the same .config in .17 as I did with .15 (make oldconfig)

I'm not sure if the machine itself makes a difference because I noticed this
on both a Dell Precision 470 and a Dell Optiplex 210L.

lspci for the 210L under .17:
0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O Controller (rev 04)
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] #09 [2109]

0000:00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL Express Chipset Family Graphics Controller (rev 04) (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 01c5
        Flags: fast devsel, IRQ 11
        Memory at dff80000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at ecd8 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at dff40000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2

0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at dff3c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dfe00000-dfefffff
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: dfd00000-dfdfffff
        Capabilities: [40] #10 [0041]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at ff80 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at ff60 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at ff40 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at ff20 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, medium devsel, latency 0, IRQ 9
        Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: dfc00000-dfcfffff
        Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 04)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ffa0 [size=16]

0000:00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 5
        I/O ports at fe00 [size=8]
        I/O ports at fe10 [size=4]
        I/O ports at fe20 [size=8]
        I/O ports at fe30 [size=4]
        I/O ports at fea0 [size=16]
        Capabilities: [70] Power Management version 2

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 04)
        Subsystem: Dell: Unknown device 01c5
        Flags: medium devsel, IRQ 10
        I/O ports at ece0 [size=32]

0000:03:08.0 Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ - PRO/100 VE (LOM) Ethernet Controller (rev 04)
        Subsystem: Dell: Unknown device 01c5
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at dfcff000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at dcc0 [size=64]
        Capabilities: [dc] Power Management version 2

lspci -nv|grep -E "^0|Subs" under .17:
0000:00:00.0 0600: 8086:2580 (rev 04)
        Subsystem: 1028:01c5
0000:00:02.0 0300: 8086:2582 (rev 04)
        Subsystem: 1028:01c5
0000:00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 1028:01c5
0000:00:1c.0 0604: 8086:2660 (rev 04)
0000:00:1c.1 0604: 8086:2662 (rev 04)
0000:00:1d.0 0c03: 8086:2658 (rev 04)
        Subsystem: 1028:01c5
0000:00:1d.1 0c03: 8086:2659 (rev 04)
        Subsystem: 1028:01c5
0000:00:1d.2 0c03: 8086:265a (rev 04)
        Subsystem: 1028:01c5
0000:00:1d.3 0c03: 8086:265b (rev 04)
        Subsystem: 1028:01c5
0000:00:1d.7 0c03: 8086:265c (rev 04) (prog-if 20)
        Subsystem: 1028:01c5
0000:00:1e.0 0604: 8086:244e (rev d4) (prog-if 01)
0000:00:1f.0 0601: 8086:2640 (rev 04)
0000:00:1f.1 0101: 8086:266f (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: 1028:01c5
0000:00:1f.2 0101: 8086:2651 (rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: 1028:01c5
0000:00:1f.3 0c05: 8086:266a (rev 04)
        Subsystem: 1028:01c5
0000:03:08.0 0200: 8086:1064 (rev 04)
        Subsystem: 1028:01c5

.config for 2.6.17:
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_SYSCTL=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_EMBEDDED=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_TINY_SHMEM=y
CONFIG_BASE_SMALL=1
CONFIG_SLOB=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_KMOD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_X86_PC=y
CONFIG_M586MMX=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_PREEMPT_NONE=y
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
CONFIG_VMSPLIT_3G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HZ_100=y
CONFIG_HZ=100
CONFIG_PHYSICAL_START=0x100000
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_ISA_DMA_API=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y
CONFIG_YENTA=m
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_PCCARD_NONSTATIC=m
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_FIB_HASH=y
CONFIG_TCP_CONG_BIC=y
CONFIG_IEEE80211=m
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_IEEE80211_SOFTMAC=m
CONFIG_WIRELESS_EXT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=1
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ALI15X3=m
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_ATIIXP=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_ISCSI_TCP=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=100
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=100
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_SATA=m
CONFIG_SCSI_SATA_AHCI=m
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
CONFIG_SCSI_SATA_MV=m
CONFIG_SCSI_SATA_NV=m
CONFIG_SCSI_PDC_ADMA=m
CONFIG_SCSI_SATA_QSTOR=m
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_SX4=m
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIL24=m
CONFIG_SCSI_SATA_SIS=m
CONFIG_SCSI_SATA_ULI=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_BLK_DEV_DM=m
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_NET_TULIP=y
CONFIG_TULIP=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_B44=m
CONFIG_FORCEDETH=m
CONFIG_E100=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
CONFIG_ACENIC=m
CONFIG_DL2K=m
CONFIG_E1000=m
CONFIG_R8169=m
CONFIG_TIGON3=m
CONFIG_BNX2=m
CONFIG_NET_RADIO=y
CONFIG_IPW2100=m
CONFIG_IPW2200=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PCMCIA_WL3501=m
CONFIG_PRISM54=m
CONFIG_BCM43XX=m
CONFIG_BCM43XX_DEBUG=y
CONFIG_BCM43XX_DMA=y
CONFIG_BCM43XX_PIO=y
CONFIG_BCM43XX_DMA_AND_PIO_MODE=y
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_CORE=m
CONFIG_VIDEO_V4L2=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_ZD1201=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_SDHCI=m
CONFIG_MMC_WBSD=m
CONFIG_EXT2_FS=m
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_REISERFS_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_CIFS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_UTF8=m
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_STACK_BACKTRACE_COLS=2
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y
