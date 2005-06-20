Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVFTWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVFTWid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFTWiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:38:25 -0400
Received: from zamok.crans.org ([138.231.136.6]:43950 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261761AbVFTV6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:58:37 -0400
Message-ID: <42B73C04.1010301@crans.org>
Date: Mon, 20 Jun 2005 23:58:28 +0200
From: =?ISO-8859-15?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-mm1  irq 21: nobody cared with snd_via82xx
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I get this while booting linux 2.6.12-mm1 (+ bridge conntrack fix BTW) 
with a VIA integrated audio ship.

It worked well at least under 2.6.11-mm1.

(Please cc. me)

Thanks!

Jun 20 23:30:15 perenold kernel: via82xx: Assuming DXS channels with 48k 
fixed sample rate.
Jun 20 23:30:15 perenold kernel: Please try dxs_support=1 or 
dxs_support=4 option
Jun 20 23:30:15 perenold kernel: and report if it works on your machine.
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> 
GSI 12 (level, low) -> IRQ 21
Jun 20 23:30:15 perenold kernel: PCI: Via IRQ fixup for 0000:00:11.5, 
from 12 to 5
Jun 20 23:30:15 perenold kernel: PCI: Setting latency timer of device 
0000:00:11.5 to 64
Jun 20 23:30:15 perenold kernel: unable to register OSS PCM device 0:0
Jun 20 23:30:15 perenold kernel: irq 21: nobody cared (try booting with 
the "irqpoll" option.
Jun 20 23:30:15 perenold kernel: [<c01329b4>] __report_bad_irq+0x24/0x80
Jun 20 23:30:15 perenold kernel: [<c0132acb>] note_interrupt+0x8b/0xe0
Jun 20 23:30:15 perenold kernel: [<c0132500>] __do_IRQ+0xe0/0xf0
Jun 20 23:30:15 perenold kernel: [<c0104efe>] do_IRQ+0x3e/0x60
Jun 20 23:30:15 perenold kernel: =======================
Jun 20 23:30:15 perenold kernel: [<c01034d6>] common_interrupt+0x1a/0x20
Jun 20 23:30:15 perenold kernel: handlers:
Jun 20 23:30:15 perenold kernel: [<e0c4f420>] 
(snd_via82xx_interrupt+0x0/0xd0 [snd_via82xx])
Jun 20 23:30:15 perenold kernel: Disabling IRQ #21
Jun 20 23:30:15 perenold kernel: unable to register OSS mixer device 0:0

There might be other IRQ-related mess here as I also found this later in 
  the log:

Jun 20 23:30:40 perenold kernel: uhci_hcd 0000:00:11.3: Unlink after 
no-IRQ?  Controller is probably using the wrong IRQ.


lspci -vvv:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333]
         Subsystem: VIA Technologies, Inc.: Unknown device 0000
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
         Latency: 0
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x2
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: dde00000-dfefffff
         Prefetchable memory behind bridge: d9c00000-ddcfffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
         Subsystem: Pinnacle Systems Inc.: Unknown device 002b
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR+
         Latency: 64 (62000ns min, 62000ns max)
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at dfffbc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:00:06.0 Unknown mass storage controller: Promise Technology, Inc. 
PDC20268 (Ultra100 TX2) (rev 02) (prog-if 85)
         Subsystem: Promise Technology, Inc. Ultra100TX2
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at ec00 [size=8]
         Region 1: I/O ports at e800 [size=4]
         Region 2: I/O ports at e400 [size=8]
         Region 3: I/O ports at e000 [size=4]
         Region 4: I/O ports at dc00 [size=16]
         Region 5: Memory at dfffc000 (32-bit, non-prefetchable) [size=16K]
         Expansion ROM at 20000000 [disabled] [size=16K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Edimax Computer Co.: Unknown device 9503
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at d800 [size=256]
         Region 1: Memory at dfffbb00 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Edimax Computer Co.: Unknown device 9503
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at d400 [size=256]
         Region 1: Memory at dfffba00 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
         Subsystem: VIA Technologies, Inc.: Unknown device 0000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at fc00 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 1b) (prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin D routed to IRQ 20
         Region 4: I/O ports at c400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 1b) (prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin D routed to IRQ 20
         Region 4: I/O ports at c800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 1b) (prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin D routed to IRQ 20
         Region 4: I/O ports at cc00 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 10)
         Subsystem: Avance Logic Inc.: Unknown device 4710
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 21
         Region 0: I/O ports at d000 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA 
TNT2/TNT2 Pro] (rev 11) (prog-if 00 [VGA])
         Subsystem: Diamond Multimedia Systems RIVA TNT2/TNT2 Pro
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at da000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at d9c00000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x2

cat /proc/interrupt:
            CPU0
   0:     229435    IO-APIC-edge  timer
   1:         10    IO-APIC-edge  i8042
   7:          2    IO-APIC-edge  parport0
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  14:      32915    IO-APIC-edge  ide0
  15:      15373    IO-APIC-edge  ide1
  16:       3311   IO-APIC-level  ide3
  17:      43800   IO-APIC-level  saa7134[0], nvidia
  18:      10900   IO-APIC-level  eth0
  19:      10450   IO-APIC-level  eth1
  20:          0   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, 
uhci_hcd:usb3
  21:  153721182   IO-APIC-level  VIA8233
NMI:          0
LOC:     229376
ERR:          0
MIS:          0

.config:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12-mm1
# Mon Jun 20 23:07:55 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_PROCESSOR=m
# CONFIG_ACPI_THERMAL is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y
CONFIG_FORK_CONNECTOR=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=m
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_ITERAID is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=m
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# TCP congestion control
#
# CONFIG_TCP_CONG_BIC is not set
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_SCALABLE is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_CONNMARK=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_CONNMARK=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
# CONFIG_IP_NF_ARPTABLES is not set

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_ULOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=m
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
CONFIG_LLC2=m
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
# CONFIG_HOSTAP is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPP_MPPE=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_CONFIG_TUNER_MULTI_I2C is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
CONFIG_VIDEO_SAA7134=m
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be 
needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_PWC is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_SECURITY is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="utf8"
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_EXPERIMENTAL=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

Full dmesg:
Jun 20 23:30:15 perenold kernel: Linux version 2.6.12-mm1 
(root@perenold) (version gcc 3.4.5 20050605 (prerelease) (Debian 
3.4.4-0)) #1 Mon Jun 20 23:17:10 CEST 2005
Jun 20 23:30:15 perenold kernel: BIOS-provided physical RAM map:
Jun 20 23:30:15 perenold kernel: BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 0000000000100000 - 
000000001fff0000 (usable)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 000000001fff0000 - 
000000001fff8000 (ACPI data)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 000000001fff8000 - 
0000000020000000 (ACPI NVS)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 00000000fec00000 - 
00000000fec01000 (reserved)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 00000000fee00000 - 
00000000fee01000 (reserved)
Jun 20 23:30:15 perenold kernel: BIOS-e820: 00000000fff80000 - 
0000000100000000 (reserved)
Jun 20 23:30:15 perenold kernel: 511MB LOWMEM available.
Jun 20 23:30:15 perenold kernel: found SMP MP-table at 000fb880
Jun 20 23:30:15 perenold kernel: On node 0 totalpages: 131056
Jun 20 23:30:15 perenold kernel: DMA zone: 4096 pages, LIFO batch:1
Jun 20 23:30:15 perenold kernel: Normal zone: 126960 pages, LIFO batch:31
Jun 20 23:30:15 perenold kernel: HighMem zone: 0 pages, LIFO batch:1
Jun 20 23:30:15 perenold kernel: DMI 2.3 present.
Jun 20 23:30:15 perenold kernel: ACPI: RSDP (v000 AMI 
                 ) @ 0x000fa710
Jun 20 23:30:15 perenold kernel: ACPI: RSDT (v001 AMIINT VIA_K7 
0x00000010 MSFT 0x00000097) @ 0x1fff0000
Jun 20 23:30:15 perenold kernel: ACPI: FADT (v001 AMIINT VIA_K7 
0x00000011 MSFT 0x00000097) @ 0x1fff0030
Jun 20 23:30:15 perenold kernel: ACPI: MADT (v001 AMIINT VIA_K7 
0x00000009 MSFT 0x00000097) @ 0x1fff00c0
Jun 20 23:30:15 perenold kernel: ACPI: DSDT (v001    VIA   VIA_K7 
0x00001000 MSFT 0x0100000d) @ 0x00000000
Jun 20 23:30:15 perenold kernel: ACPI: Local APIC address 0xfee00000
Jun 20 23:30:15 perenold kernel: ACPI: LAPIC (acpi_id[0x01] 
lapic_id[0x00] enabled)
Jun 20 23:30:15 perenold kernel: Processor #0 6:6 APIC version 16
Jun 20 23:30:15 perenold kernel: ACPI: IOAPIC (id[0x02] 
address[0xfec00000] gsi_base[0])
Jun 20 23:30:15 perenold kernel: IOAPIC[0]: apic_id 2, version 17, 
address 0xfec00000, GSI 0-23
Jun 20 23:30:15 perenold kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 
global_irq 2 dfl dfl)
Jun 20 23:30:15 perenold kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 
global_irq 9 low level)
Jun 20 23:30:15 perenold kernel: ACPI: IRQ0 used by override.
Jun 20 23:30:15 perenold kernel: ACPI: IRQ2 used by override.
Jun 20 23:30:15 perenold kernel: ACPI: IRQ9 used by override.
Jun 20 23:30:15 perenold kernel: Enabling APIC mode:  Flat.  Using 1 I/O 
APICs
Jun 20 23:30:15 perenold kernel: Using ACPI (MADT) for SMP configuration 
information
Jun 20 23:30:15 perenold kernel: Allocating PCI resources starting at 
20000000 (gap: 20000000:dec00000)
Jun 20 23:30:15 perenold kernel: Built 1 zonelists
Jun 20 23:30:15 perenold kernel: mapped APIC to ffffd000 (fee00000)
Jun 20 23:30:15 perenold kernel: mapped IOAPIC to ffffc000 (fec00000)
Jun 20 23:30:15 perenold kernel: Initializing CPU#0
Jun 20 23:30:15 perenold kernel: Kernel command line: root=/dev/hda5 ro
Jun 20 23:30:15 perenold kernel: CPU 0 irqstacks, hard=c0362000 
soft=c0361000
Jun 20 23:30:15 perenold kernel: PID hash table entries: 2048 (order: 
11, 32768 bytes)
Jun 20 23:30:15 perenold kernel: Detected 1399.508 MHz processor.
Jun 20 23:30:15 perenold kernel: Using tsc for high-res timesource
Jun 20 23:30:15 perenold kernel: Console: colour VGA+ 80x25
Jun 20 23:30:15 perenold kernel: Dentry cache hash table entries: 131072 
(order: 7, 524288 bytes)
Jun 20 23:30:15 perenold kernel: Inode-cache hash table entries: 65536 
(order: 6, 262144 bytes)
Jun 20 23:30:15 perenold kernel: Memory: 516148k/524224k available 
(1569k kernel code, 7524k reserved, 703k data, 136k init, 0k highmem)
Jun 20 23:30:15 perenold kernel: Checking if this processor honours the 
WP bit even in supervisor mode... Ok.
Jun 20 23:30:15 perenold kernel: Calibrating delay using timer specific 
routine.. 2803.82 BogoMIPS (lpj=5607650)
Jun 20 23:30:15 perenold kernel: Mount-cache hash table entries: 512
Jun 20 23:30:15 perenold kernel: CPU: After generic identify, caps: 
0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
Jun 20 23:30:15 perenold kernel: CPU: After vendor identify, caps: 
0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
Jun 20 23:30:15 perenold kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
Jun 20 23:30:15 perenold kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 20 23:30:15 perenold kernel: CPU: After all inits, caps: 0383fbff 
c1cbfbff 00000000 00000020 00000000 00000000 00000000
Jun 20 23:30:15 perenold kernel: Intel machine check architecture supported.
Jun 20 23:30:15 perenold kernel: Intel machine check reporting enabled 
on CPU#0.
Jun 20 23:30:15 perenold kernel: CPU: AMD Athlon(tm) XP 1600+ stepping 02
Jun 20 23:30:15 perenold kernel: Enabling fast FPU save and restore... done.
Jun 20 23:30:15 perenold kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jun 20 23:30:15 perenold kernel: Checking 'hlt' instruction... OK.
Jun 20 23:30:15 perenold kernel: ENABLING IO-APIC IRQs
Jun 20 23:30:15 perenold kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jun 20 23:30:15 perenold kernel: NET: Registered protocol family 16
Jun 20 23:30:15 perenold kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfdb21, last bus=1
Jun 20 23:30:15 perenold kernel: PCI: Using configuration type 1
Jun 20 23:30:15 perenold kernel: mtrr: v2.0 (20020519)
Jun 20 23:30:15 perenold kernel: ACPI: Subsystem revision 20050309
Jun 20 23:30:15 perenold kernel: ACPI: Interpreter enabled
Jun 20 23:30:15 perenold kernel: ACPI: Using IOAPIC for interrupt routing
Jun 20 23:30:15 perenold kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jun 20 23:30:15 perenold kernel: PCI: Probing PCI hardware (bus 00)
Jun 20 23:30:15 perenold kernel: Boot video device is 0000:01:00.0
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Jun 20 23:30:15 perenold kernel: ACPI: Power Resource [URP1] (off)
Jun 20 23:30:15 perenold kernel: ACPI: Power Resource [URP2] (off)
Jun 20 23:30:15 perenold kernel: ACPI: Power Resource [FDDP] (off)
Jun 20 23:30:15 perenold kernel: ACPI: Power Resource [LPTP] (off)
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 
4 5 6 7 10 *11 12 14 15)
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 
4 5 6 7 *10 11 12 14 15)
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 
4 5 6 7 10 11 *12 14 15)
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 
4 *5 6 7 10 11 12 14 15)
Jun 20 23:30:15 perenold kernel: Linux Plug and Play Support v0.97 (c) 
Adam Belay
Jun 20 23:30:15 perenold kernel: pnp: PnP ACPI init
Jun 20 23:30:15 perenold kernel: pnp: PnP ACPI: found 10 devices
Jun 20 23:30:15 perenold kernel: PCI: Using ACPI for IRQ routing
Jun 20 23:30:15 perenold kernel: PCI: If a device doesn't work, try 
"pci=routeirq".  If it helps, post a report
Jun 20 23:30:15 perenold kernel: PCI: Bridge: 0000:00:01.0
Jun 20 23:30:15 perenold kernel: IO window: disabled.
Jun 20 23:30:15 perenold kernel: MEM window: dde00000-dfefffff
Jun 20 23:30:15 perenold kernel: PREFETCH window: d9c00000-ddcfffff
Jun 20 23:30:15 perenold kernel: PCI: Setting latency timer of device 
0000:00:01.0 to 64
Jun 20 23:30:15 perenold kernel: Machine check exception polling timer 
started.
Jun 20 23:30:15 perenold kernel: Total HugeTLB memory allocated, 0
Jun 20 23:30:15 perenold kernel: inotify device minor=63
Jun 20 23:30:15 perenold kernel: Initializing Cryptographic API
Jun 20 23:30:15 perenold kernel: cn_fork is registered
Jun 20 23:30:15 perenold kernel: PNP: PS/2 controller doesn't have AUX 
irq; using default 0xc
Jun 20 23:30:15 perenold kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 
0x60,0x64 irq 1,12
Jun 20 23:30:15 perenold kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 20 23:30:15 perenold kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 20 23:30:15 perenold kernel: io scheduler noop registered
Jun 20 23:30:15 perenold kernel: io scheduler anticipatory registered
Jun 20 23:30:15 perenold kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Jun 20 23:30:15 perenold kernel: ide: Assuming 33MHz system bus speed 
for PIO modes; override with idebus=xx
Jun 20 23:30:15 perenold kernel: PDC20268: IDE controller at PCI slot 
0000:00:06.0
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> 
GSI 17 (level, low) -> IRQ 16
Jun 20 23:30:15 perenold kernel: PDC20268: chipset revision 2
Jun 20 23:30:15 perenold kernel: PDC20268: ROM enabled at 0x20000000
Jun 20 23:30:15 perenold kernel: PDC20268: 100% native mode on irq 16
Jun 20 23:30:15 perenold kernel: ide2: BM-DMA at 0xdc00-0xdc07, BIOS 
settings: hde:pio, hdf:pio
Jun 20 23:30:15 perenold kernel: ide3: BM-DMA at 0xdc08-0xdc0f, BIOS 
settings: hdg:pio, hdh:pio
Jun 20 23:30:15 perenold kernel: Probing IDE interface ide2...
Jun 20 23:30:15 perenold kernel: Probing IDE interface ide3...
Jun 20 23:30:15 perenold kernel: hdg: IC35L040AVVA07-0, ATA DISK drive
Jun 20 23:30:15 perenold kernel: ide3 at 0xe400-0xe407,0xe002 on irq 16
Jun 20 23:30:15 perenold kernel: VP_IDE: IDE controller at PCI slot 
0000:00:11.1
Jun 20 23:30:15 perenold kernel: PCI: Via IRQ fixup for 0000:00:11.1, 
from 255 to 0
Jun 20 23:30:15 perenold kernel: VP_IDE: chipset revision 6
Jun 20 23:30:15 perenold kernel: VP_IDE: not 100% native mode: will 
probe irqs later
Jun 20 23:30:15 perenold kernel: VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 
controller on pci0000:00:11.1
Jun 20 23:30:15 perenold kernel: ide0: BM-DMA at 0xfc00-0xfc07, BIOS 
settings: hda:DMA, hdb:pio
Jun 20 23:30:15 perenold kernel: ide1: BM-DMA at 0xfc08-0xfc0f, BIOS 
settings: hdc:DMA, hdd:DMA
Jun 20 23:30:15 perenold kernel: Probing IDE interface ide0...
Jun 20 23:30:15 perenold kernel: hda: WDC WD400BB-75AUA1, ATA DISK drive
Jun 20 23:30:15 perenold kernel: hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY 
drive
Jun 20 23:30:15 perenold kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 20 23:30:15 perenold kernel: Probing IDE interface ide1...
Jun 20 23:30:15 perenold kernel: hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI 
CD/DVD-ROM drive
Jun 20 23:30:15 perenold kernel: hdd: PLEXTOR CD-R PX-W2410A, ATAPI 
CD/DVD-ROM drive
Jun 20 23:30:15 perenold kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 20 23:30:15 perenold kernel: hdg: max request size: 128KiB
Jun 20 23:30:15 perenold kernel: hdg: 80418240 sectors (41174 MB) 
w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
Jun 20 23:30:15 perenold kernel: hdg: cache flushes supported
Jun 20 23:30:15 perenold kernel: hdg: hdg1
Jun 20 23:30:15 perenold kernel: hda: max request size: 128KiB
Jun 20 23:30:15 perenold kernel: hda: 78165360 sectors (40020 MB) 
w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jun 20 23:30:15 perenold kernel: hda: cache flushes not supported
Jun 20 23:30:15 perenold kernel: hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Jun 20 23:30:15 perenold kernel: mice: PS/2 mouse device common for all mice
Jun 20 23:30:15 perenold kernel: NET: Registered protocol family 2
Jun 20 23:30:15 perenold kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Jun 20 23:30:15 perenold kernel: TCP established hash table entries: 
32768 (order: 6, 262144 bytes)
Jun 20 23:30:15 perenold kernel: TCP bind hash table entries: 32768 
(order: 5, 131072 bytes)
Jun 20 23:30:15 perenold kernel: TCP: Hash tables configured 
(established 32768 bind 32768)
Jun 20 23:30:15 perenold kernel: TCP reno registered
Jun 20 23:30:15 perenold kernel: NET: Registered protocol family 1
Jun 20 23:30:15 perenold kernel: Using IPI Shortcut mode
Jun 20 23:30:15 perenold kernel: ReiserFS: hda5: found reiserfs format 
"3.6" with standard journal
Jun 20 23:30:15 perenold kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Jun 20 23:30:15 perenold kernel: ReiserFS: hda5: using ordered data mode
Jun 20 23:30:15 perenold kernel: ReiserFS: hda5: journal params: device 
hda5, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Jun 20 23:30:15 perenold kernel: ReiserFS: hda5: checking transaction 
log (hda5)
Jun 20 23:30:15 perenold kernel: ReiserFS: hda5: Using r5 hash to sort names
Jun 20 23:30:15 perenold kernel: VFS: Mounted root (reiserfs filesystem) 
readonly.
Jun 20 23:30:15 perenold kernel: Freeing unused kernel memory: 136k freed
Jun 20 23:30:15 perenold kernel: Adding 497972k swap on /dev/hda6. 
Priority:-1 extents:1
Jun 20 23:30:15 perenold kernel: reiserfs: enabling write barrier flush mode
Jun 20 23:30:15 perenold kernel: reiserfs: disabling flush barriers on hda5
Jun 20 23:30:15 perenold kernel: Real Time Clock Driver v1.12
Jun 20 23:30:15 perenold kernel: WDT driver for the Winbond(TM) W83627HF 
Super I/O chip initialising.
Jun 20 23:30:15 perenold kernel: w83627hf WDT: initialized. timeout=60 
sec (nowayout=0)
Jun 20 23:30:15 perenold kernel: CSLIP: code copyright 1989 Regents of 
the University of California
Jun 20 23:30:15 perenold kernel: PPP generic driver version 2.4.2
Jun 20 23:30:15 perenold kernel: ReiserFS: hda7: found reiserfs format 
"3.6" with standard journal
Jun 20 23:30:15 perenold kernel: ReiserFS: hda7: using ordered data mode
Jun 20 23:30:15 perenold kernel: reiserfs: using flush barriers
Jun 20 23:30:15 perenold kernel: ReiserFS: hda7: journal params: device 
hda7, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Jun 20 23:30:15 perenold kernel: ReiserFS: hda7: checking transaction 
log (hda7)
Jun 20 23:30:15 perenold kernel: reiserfs: disabling flush barriers on hda7
Jun 20 23:30:15 perenold kernel: ReiserFS: hda7: Using r5 hash to sort names
Jun 20 23:30:15 perenold kernel: ReiserFS: hda8: found reiserfs format 
"3.6" with standard journal
Jun 20 23:30:15 perenold kernel: ReiserFS: hda8: using ordered data mode
Jun 20 23:30:15 perenold kernel: reiserfs: using flush barriers
Jun 20 23:30:15 perenold kernel: ReiserFS: hda8: journal params: device 
hda8, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Jun 20 23:30:15 perenold kernel: ReiserFS: hda8: checking transaction 
log (hda8)
Jun 20 23:30:15 perenold kernel: reiserfs: disabling flush barriers on hda8
Jun 20 23:30:15 perenold kernel: ReiserFS: hda8: Using r5 hash to sort names
Jun 20 23:30:15 perenold kernel: ReiserFS: hdg1: found reiserfs format 
"3.6" with standard journal
Jun 20 23:30:15 perenold kernel: ReiserFS: hdg1: using ordered data mode
Jun 20 23:30:15 perenold kernel: reiserfs: using flush barriers
Jun 20 23:30:15 perenold kernel: ReiserFS: hdg1: journal params: device 
hdg1, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Jun 20 23:30:15 perenold kernel: ReiserFS: hdg1: checking transaction 
log (hdg1)
Jun 20 23:30:15 perenold kernel: ReiserFS: hdg1: Using r5 hash to sort names
Jun 20 23:30:15 perenold kernel: Linux agpgart interface v0.101 (c) Dave 
Jones
Jun 20 23:30:15 perenold kernel: agpgart: Detected VIA 
KT266/KY266x/KT333 chipset
Jun 20 23:30:15 perenold kernel: agpgart: AGP aperture is 256M @ 0xe0000000
Jun 20 23:30:15 perenold kernel: Linux video capture interface: v1.00
Jun 20 23:30:15 perenold kernel: saa7130/34: v4l2 driver version 0.2.13 
loaded
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:05.0[A] -> 
GSI 16 (level, low) -> IRQ 17
Jun 20 23:30:15 perenold kernel: saa7134[0]: found at 0000:00:05.0, rev: 
1, irq: 17, latency: 64, mmio: 0xdfffbc00
Jun 20 23:30:15 perenold kernel: saa7134[0]: subsystem: 11bd:002b, 
board: Pinnacle PCTV Stereo (saa7134) [card=26,autodetected]
Jun 20 23:30:15 perenold kernel: saa7134[0]: board init: gpio is 0
Jun 20 23:30:15 perenold kernel: saa7134[0]: i2c eeprom 00: bd 11 2b 00 
f8 f8 1c 00 43 43 a9 1c 55 d2 b2 92
Jun 20 23:30:15 perenold kernel: saa7134[0]: i2c eeprom 10: 00 00 19 0e 
ff 20 ff ff ff ff ff ff ff ff ff ff
Jun 20 23:30:15 perenold kernel: saa7134[0]: i2c eeprom 20: 01 40 01 03 
03 ff 03 01 08 ff 00 53 ff ff ff ff
Jun 20 23:30:15 perenold kernel: saa7134[0]: i2c eeprom 30: ff ff ff ff 
ff ff ff ff ff ff ff ff ff ff ff ff
Jun 20 23:30:15 perenold kernel: tuner 1-0060: chip found @ 0xc0 
(saa7134[0])
Jun 20 23:30:15 perenold kernel: tuner 1-0060: microtune: 
companycode=3cbf part=42 rev=11
Jun 20 23:30:15 perenold kernel: tuner 1-0060: microtune MT2050 found, OK
Jun 20 23:30:15 perenold kernel: secam: string doesn't fit in 1 chars.
Jun 20 23:30:15 perenold kernel: tda9887: `'L'' too large for parameter 
`secam'
Jun 20 23:30:15 perenold kernel: saa7134[0]: registered device video0 [v4l2]
Jun 20 23:30:15 perenold kernel: saa7134[0]: registered device vbi0
Jun 20 23:30:15 perenold kernel: saa7134[0]: registered device dsp0
Jun 20 23:30:15 perenold kernel: saa7134[0]: registered device mixer0
Jun 20 23:30:15 perenold kernel: 8139too Fast Ethernet driver 0.9.27
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:07.0[A] -> 
GSI 18 (level, low) -> IRQ 18
Jun 20 23:30:15 perenold kernel: eth0: RealTek RTL8139 at 0xe0b6ab00, 
00:30:4f:28:10:f2, IRQ 18
Jun 20 23:30:15 perenold kernel: eth0:  Identified 8139 chip type 
'RTL-8100B/8139D'
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> 
GSI 19 (level, low) -> IRQ 19
Jun 20 23:30:15 perenold kernel: eth1: RealTek RTL8139 at 0xe0b70a00, 
00:30:4f:27:ee:39, IRQ 19
Jun 20 23:30:15 perenold kernel: eth1:  Identified 8139 chip type 
'RTL-8100B/8139D'
Jun 20 23:30:15 perenold kernel: usbcore: registered new driver usbfs
Jun 20 23:30:15 perenold kernel: usbcore: registered new driver hub
Jun 20 23:30:15 perenold kernel: USB Universal Host Controller Interface 
driver v2.3
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:11.2[D] -> 
GSI 5 (level, low) -> IRQ 20
Jun 20 23:30:15 perenold kernel: PCI: Via IRQ fixup for 0000:00:11.2, 
from 5 to 4
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.2: VIA 
Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.2: new USB bus 
registered, assigned bus number 1
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.2: irq 20, io base 
0x0000c400
Jun 20 23:30:15 perenold kernel: hub 1-0:1.0: USB hub found
Jun 20 23:30:15 perenold kernel: hub 1-0:1.0: 2 ports detected
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:11.3[D] -> 
GSI 5 (level, low) -> IRQ 20
Jun 20 23:30:15 perenold kernel: PCI: Via IRQ fixup for 0000:00:11.3, 
from 5 to 4
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.3: VIA 
Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.3: new USB bus 
registered, assigned bus number 2
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.3: irq 20, io base 
0x0000c800
Jun 20 23:30:15 perenold kernel: hub 2-0:1.0: USB hub found
Jun 20 23:30:15 perenold kernel: hub 2-0:1.0: 2 ports detected
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:11.4[D] -> 
GSI 5 (level, low) -> IRQ 20
Jun 20 23:30:15 perenold kernel: PCI: Via IRQ fixup for 0000:00:11.4, 
from 5 to 4
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.4: VIA 
Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.4: new USB bus 
registered, assigned bus number 3
Jun 20 23:30:15 perenold kernel: uhci_hcd 0000:00:11.4: irq 20, io base 
0x0000cc00
Jun 20 23:30:15 perenold kernel: hub 3-0:1.0: USB hub found
Jun 20 23:30:15 perenold kernel: hub 3-0:1.0: 2 ports detected
Jun 20 23:30:15 perenold kernel: usb 2-1: new full speed USB device 
using uhci_hcd and address 2
Jun 20 23:30:15 perenold kernel: via82xx: Assuming DXS channels with 48k 
fixed sample rate.
Jun 20 23:30:15 perenold kernel: Please try dxs_support=1 or 
dxs_support=4 option
Jun 20 23:30:15 perenold kernel: and report if it works on your machine.
Jun 20 23:30:15 perenold kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> 
GSI 12 (level, low) -> IRQ 21
Jun 20 23:30:15 perenold kernel: PCI: Via IRQ fixup for 0000:00:11.5, 
from 12 to 5
Jun 20 23:30:15 perenold kernel: PCI: Setting latency timer of device 
0000:00:11.5 to 64
Jun 20 23:30:15 perenold kernel: unable to register OSS PCM device 0:0
Jun 20 23:30:15 perenold kernel: irq 21: nobody cared (try booting with 
the "irqpoll" option.
Jun 20 23:30:15 perenold kernel: [<c01329b4>] __report_bad_irq+0x24/0x80
Jun 20 23:30:15 perenold kernel: [<c0132acb>] note_interrupt+0x8b/0xe0
Jun 20 23:30:15 perenold kernel: [<c0132500>] __do_IRQ+0xe0/0xf0
Jun 20 23:30:15 perenold kernel: [<c0104efe>] do_IRQ+0x3e/0x60
Jun 20 23:30:15 perenold kernel: =======================
Jun 20 23:30:15 perenold kernel: [<c01034d6>] common_interrupt+0x1a/0x20
Jun 20 23:30:15 perenold kernel: handlers:
Jun 20 23:30:15 perenold kernel: [<e0c4f420>] 
(snd_via82xx_interrupt+0x0/0xd0 [snd_via82xx])
Jun 20 23:30:15 perenold kernel: Disabling IRQ #21
Jun 20 23:30:15 perenold kernel: unable to register OSS mixer device 0:0
Jun 20 23:30:15 perenold kernel: drivers/usb/class/usblp.c: usblp0: USB 
Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x067B pid 0x2305
Jun 20 23:30:15 perenold kernel: usbcore: registered new driver usblp
Jun 20 23:30:15 perenold kernel: drivers/usb/class/usblp.c: v0.13: USB 
Printer Device Class driver
Jun 20 23:30:15 perenold kernel: Floppy drive(s): fd0 is 1.44M
Jun 20 23:30:15 perenold kernel: FDC 0 is a post-1991 82077
Jun 20 23:30:15 perenold kernel: Serial: 8250/16550 driver $Revision: 
1.90 $ 8 ports, IRQ sharing enabled
Jun 20 23:30:15 perenold kernel: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
Jun 20 23:30:15 perenold kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun 20 23:30:15 perenold kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 20 23:30:15 perenold kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun 20 23:30:15 perenold kernel: parport: PnPBIOS parport detected.
Jun 20 23:30:15 perenold kernel: parport0: PC-style at 0x378 (0x778), 
irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Jun 20 23:30:15 perenold kernel: input: PC Speaker
Jun 20 23:30:15 perenold kernel: ide-floppy driver 0.99.newide
Jun 20 23:30:15 perenold kernel: hdb: No disk in drive
Jun 20 23:30:15 perenold kernel: hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 
512 sector size, 2941 rpm
Jun 20 23:30:15 perenold kernel: hdc: ATAPI 32X DVD-ROM drive, 256kB 
Cache, UDMA(33)
Jun 20 23:30:15 perenold kernel: Uniform CD-ROM driver Revision: 3.20
Jun 20 23:30:15 perenold kernel: hdd: ATAPI 40X CD-ROM CD-R/RW drive, 
4096kB Cache, UDMA(33)
Jun 20 23:30:15 perenold kernel: Bridge firewalling registered
Jun 20 23:30:15 perenold kernel: device eth0 entered promiscuous mode
Jun 20 23:30:15 perenold kernel: eth0: link up, 100Mbps, full-duplex, 
lpa 0x45E1
Jun 20 23:30:15 perenold kernel: eth0: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth0: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth0: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth0: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth0: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: device eth1 entered promiscuous mode
Jun 20 23:30:15 perenold kernel: eth1: link up, 100Mbps, full-duplex, 
lpa 0x45E1
Jun 20 23:30:15 perenold kernel: eth1: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth1: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth1: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth1: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: eth1: Promiscuous mode enabled.
Jun 20 23:30:15 perenold kernel: br0: port 2(eth1) entering learning state
Jun 20 23:30:15 perenold kernel: br0: port 1(eth0) entering learning state
Jun 20 23:30:15 perenold kernel: br0: topology change detected, propagating
Jun 20 23:30:15 perenold kernel: br0: port 2(eth1) entering forwarding state
Jun 20 23:30:15 perenold kernel: br0: topology change detected, propagating
Jun 20 23:30:15 perenold kernel: br0: port 1(eth0) entering forwarding state
Jun 20 23:30:15 perenold kernel: NET: Registered protocol family 17
Jun 20 23:30:15 perenold kernel: ip_conntrack version 2.1 (4095 buckets, 
32760 max) - 248 bytes per conntrack
Jun 20 23:30:15 perenold kernel: Ebtables v2.0 registered
Jun 20 23:30:15 perenold kernel: ip_tables: (C) 2000-2002 Netfilter core 
team
Jun 20 23:30:36 perenold kernel: ACPI: Processor [CPU1] (supports 16 
throttling states)
Jun 20 23:30:36 perenold kernel: ACPI: Power Button (FF) [PWRF]
Jun 20 23:30:36 perenold kernel: ACPI: Sleep Button (CM) [SLPB]
Jun 20 23:30:39 perenold kernel: device br0 entered promiscuous mode
Jun 20 23:30:40 perenold kernel: uhci_hcd 0000:00:11.3: Unlink after 
no-IRQ?  Controller is probably using the wrong IRQ.
Jun 20 23:30:49 perenold kernel: tuner 1-0060: Cmd VIDIOC_S_STD accepted 
to TV
Jun 20 23:30:49 perenold kernel: tuner 1-0060: Cmd VIDIOC_S_STD accepted 
to TV
Jun 20 23:30:49 perenold kernel: tuner 1-0060: Cmd VIDIOC_S_STD accepted 
to TV
Jun 20 23:30:49 perenold kernel: saa7134[0]/irq[10,-51080]: r=0x20 s=0x00 PE
Jun 20 23:30:49 perenold kernel: saa7134[0]/irq: looping -- clearing PE 
(parity error!) enable bit
Jun 20 23:30:49 perenold kernel: tuner 1-0060: Cmd VIDIOC_S_FREQUENCY 
accepted to TV


-- 
Mathieu Bérard

