Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbTILNMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTILNMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 09:12:32 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:22231 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261560AbTILNMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 09:12:17 -0400
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5 (nearly) success story
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Sep 2003 15:04:13 +0200
Message-ID: <m3k78enooi.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just compiled and booted 2.6.0-test5 on my Fujitsu-Siemens notebook
(Liteline LF6, Celeron 600 MHz class, i440BX etc). No modules.

gcc version 3.2.3 20030422 (older rawhide - Red Hat Linux 3.2.3-4)

Problems:
1. with cardbus ethernet (DEC tulip 21143-based D-Link DFE-660TX) inserted,
   boot process stops after printing something like:

Yenta: CardBus bridge found at 0000:00:0a.0 [110a:0015]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0090, PCI irq9
Socket status: 30000020

No caps/scroll/num lock LEDs working, it's dead.

With the ethernet card removed before starting kernel, it completes:

Yenta: CardBus bridge found at 0000:00:0a.0 [110a:0015]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0090, PCI irq9
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0a.1 [110a:0015]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0090, PCI irq11
Socket status: 30000006
mice: PS/2 mouse device common for all mice
...

The ethernet works if I insert it then.



2. The kernel prints:

Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!

Not sure if it's ok - happens with 2.4, too.


3. ACPI - while booting the kernel says:
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery absent)

with both external power and battery connected. It is correct after
boot, though. The same with 2.4.

And:
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S3 S4 S5)

while:
# cat /proc/acpi/processor/CPU0/throttling 
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%

Not sure if it's related.


.config etc follows.


CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
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
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI_HT=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
CONFIG_PCMCIA_PROBE=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_NET_PCI=y
CONFIG_PLIP=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_IRDA=y
CONFIG_IRLAN=y
CONFIG_IRNET=y
CONFIG_IRCOMM=y
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_NSC_FIR=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_I2C=y
CONFIG_I2C_PIIX4=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_W83781D=y
CONFIG_I2C_SENSOR=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_UTF8=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_MAESTRO3=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: f8000000-fbffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcd0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at fce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Siemens Nixdorf AG: Unknown device 0015
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Siemens Nixdorf AG: Unknown device 0015
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
	Subsystem: Siemens Nixdorf AG: Unknown device 1998
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at f800 [size=256]
	Region 1: Memory at fedfe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Communication controller: ESS Technology ES1983S Maestro-3i PCI Modem Accelerator
	Subsystem: Siemens Nixdorf AG: Unknown device 1998
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at f400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev b1) (prog-if 00 [VGA])
	Subsystem: Siemens Nixdorf AG: Unknown device 0720
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x2
		Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x2

02:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1142
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10400000 [disabled] [size=256K]



Linux version 2.6.0-test5 (khc@defiant) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #2 Fri Sep 12 14:11:18 CEST 2003
Video mode to be used for restore is f00
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
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7400
ACPI: RSDT (v001 PTLTD  C3 RSDT  0xf0cf0033  LTP 0x00000000) @ 0x07ffaabe
ACPI: FADT (v001 QUANTA C3 FACP  0xf0cf0033 PTL  0x000f4240) @ 0x07fffb8c
ACPI: DSDT (v001    PTL C3 DSDT  0xf0cf0033 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=L2.6.0test5 root=302 BOOT_FILE=/lib/modules/2.6.0-test5/bzImage
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 597.652 MHz processor.
Console: colour VGA+ 80x25
Memory: 125604k/131008k available (2413k kernel code, 4868k reserved, 809k data, 136k init, 0k highmem)
Calibrating delay loop... 1179.64 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
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
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7450
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa81b, dseg 0x400
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
NET: Registered protocol family 23
pty: 256 Unix98 ptys configured
udf: registering filesystem
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (64 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: AGP aperture is 64M @ 0xf4000000
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
plip: parport0 has no IRQ. Using IRQ-less mode,which is fairly inefficient!
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip0: Parallel port at 0x378, not using IRQ.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
nsc-ircc, Found chip at base=0x398
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Found dongle: Sharp RY5HD01
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJSA-205, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 9767520 sectors (5000 MB) w/384KiB Cache, CHS=10336/15/63, UDMA(33)
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Yenta: CardBus bridge found at 0000:00:0a.0 [110a:0015]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0090, PCI irq9
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0a.1 [110a:0015]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0090, PCI irq11
Socket status: 30000006
mice: PS/2 mouse device common for all mice
input: PC Speaker
Synaptics Touchpad, model: 1
 Firware: 4.6
 Sensor: 19
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-piix4 version 2.7.0 (20021208)
piix4-smbus 0000:00:07.3: Found 0000:00:07.3 device
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
ALSA device list:
  #0: ESS Maestro3 PCI at 0xf800, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
ip_conntrack version 2.1 (1023 buckets, 8184 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:02:00.0 to 64
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #0 config 3000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0x1000, 00:50:BA:70:68:3E, IRQ 9.
EXT3 FS on hda2, internal journal
Adding 120476k swap on /dev/hda3.  Priority:-1 extents:1
eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.
blk: queue c7ec2064, I/O limit 4095Mb (mask 0xffffffff)

-- 
Krzysztof Halasa, B*FH
