Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSJNVIE>; Mon, 14 Oct 2002 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262252AbSJNVID>; Mon, 14 Oct 2002 17:08:03 -0400
Received: from proxy.hsp-law.de ([62.48.88.110]:5646 "EHLO sc1.hsp-law.de")
	by vger.kernel.org with ESMTP id <S262230AbSJNVHd>;
	Mon, 14 Oct 2002 17:07:33 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.42 ACPI/Suspend with an Acer Travelmate 350
From: Ralf Gerbig <rge@hsp-law.de>
Date: 14 Oct 2002 23:07:57 +0200
Message-ID: <m0fzv8ohjm.fsf-news@hsp-law.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Pavel, lkml

I just poked around with /proc/acpi/sleep without much hope as I was
never able to get this otherwise nice lapdog to sleep _and_ resume
before. The swsusp patches on 2.4.1[89] worked exept the touchpad
would not respond after the resume.

But wow, this time at least the kernel survived!

Most of the following is hand copied, beware the typos

echo 1 > /proc/acpi/sleep
=pdflush: bogus wakeup!
==|
exfldio-0103 [23] Ex_setup_region       : Field [PM05] access width (2 bytes) too large for region [SLP0] (length 1)
exfldio-0114 [23] Ex_setup_region       : Field [PM05] Base+Offset+Width 0+0+2 is beyond end of region [SLP0] (length 1)
dcwexec-0404 [16] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_REGION_LIMIT
Suspending devices
Suspending devices
Shutting down devices
hwsleep-239 [08] Acpi_enter_sleep_state: Entering S1

at this point I can at least switch vt's, sysrq works otherwise it is
stuck.

Same here:

echo 5 > /proc/acpi/sleep

Suspending devices
Shutting down devices
<------------------------------ Ooops starts here
Oops 0002
ipv6 pcnet_cs 8390 crc32 ds yenta_socket pcmcia_core ehci-hcd usbcore
CPU: 0
EIP: 0060:[<c011101f>]  Not tainted
EFLAGS: 00010002
EIP is at acpi_restore_pmd+0xb/0x20
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: 00000005   edi: 00000005   ebp: ca197f54   esp: ca197f18
ds: 0068   es: 0068   ss: 0068
Process bash (pid: 813, threadinfo=ca196000 task=ca817980)
Stack:  c0111055 c01d29a1 00000001 c01d2b2c 00000005 00000005 ca197f60 00000002
        ca197f54 c01d2d06 00000005 00000000 00000000 ca0b7238 ca0b7258 02000000
        c02ce14b c02ce0e9 00000a35 00000000 00000000 c01626c3 ca0b7238 40020000
Call trace:
[<c0111055>] acpi_restre_mem+0x5/0x10
[<c01d29a1>] acpi_system_restore_state+0xd/0x58
[<c01d2b2c>] acpi_suspend+0x6c/0x90
[<c01d2d06>] acpi_system_write_sleep+0xee/0x12c
[<c01626c3>] proc_file_write+0x27/0x34
[<c013fea1>] vfs_write+0xc5/0x15c
[<c013ff9e>] sys_write+0x2a/0x3c
[<c0106fbf>] syscall_call+0x7/0xb

Code: 89 02 0f 20 d8 0f 22 d8 a1 d4 5a 40 c8 31 d2 e8 09 46 02 00
<----------------------------- Oops ends here
<4>eth0: trigger_send() called with the transmitter busy.
eth0: interrupt(s) dropped

Again swiching vt's works, I even get a login prompt.

The boot massages:

Inspecting /boot/System.map-2.5.42
Loaded 20889 symbols from /boot/System.map-2.5.42.
Symbols match kernel version 2.5.42.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.5.42 (ralf@linux) (gcc version 2.95.3 20010315 (SuSE)) #1 Sun Oct 13 17:35:21 CEST 2002
<4>Video mode to be used for restore is f00
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000000b7f0000 (usable)
<4> BIOS-e820: 000000000b7f0000 - 000000000b7f8000 (ACPI data)
<4> BIOS-e820: 000000000b7f8000 - 000000000b800000 (ACPI NVS)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>183MB LOWMEM available.
<7>ACPI: have wakeup address 0xc0001000
<4>On node 0 totalpages: 47088
<4>  DMA zone: 4096 pages
<4>  Normal zone: 42992 pages
<4>  HighMem zone: 0 pages
<6>ACPI: RSDP (v000 Acer                       ) @ 0x000fe030
<6>ACPI: RSDT (v001 Acer   TM350    00000.00001) @ 0x0b7f0000
<6>ACPI: FADT (v001 Acer   TM350    00000.00001) @ 0x0b7f0054
<6>ACPI: BOOT (v001 Acer   TM350    00000.00001) @ 0x0b7f002c
<6>ACPI: DSDT (v001   Acer    TM350 00000.00001) @ 0x00000000
<5>ACPI: BIOS passes blacklist
<4>ACPI: MADT not present
<4>Building zonelist for node : 0
<4>Kernel command line: auto BOOT_IMAGE=linux2542 ro root=304 resume=/dev/hda2 3
<4>Local APIC disabled by BIOS -- reenabling.
<4>Could not enable APIC!
<6>Initializing CPU#0
<4>Detected 797.042 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 1568.76 BogoMIPS
<4>Memory: 182640k/188352k available (1647k kernel code, 5324k reserved, 672k data, 104k init, 0k highmem)
<6>Security Scaffold v1.0.0 initialized
<6>Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<5>CPU serial number disabled.
<7>CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
<7>CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
<4>CPU: Intel Pentium III (Coppermine) stepping 06
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>mtrr: v2.0 (20020519)
<6>PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
<6>PCI: Using configuration type 1
<7>adding '' to cpu class interfaces
<6>ACPI: Subsystem revision 20021002
<4> tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
<4>Parsing Methods:...................................................................................................................................................
<4>Table [DSDT] - 485 Objects with 49 Devices 147 Methods 33 Regions
<4>ACPI Namespace successfully loaded at root c0435bbc
<4>evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
<4>Executing all Device _STA and_INI methods:.................................................
<4>49 Devices found containing: 49 _STA, 0 _INI methods
<4>Completing Region/Field/Buffer/Package initialization:...............................................................................
<4>Initialized 28/33 Regions 19/19 Fields 20/20 Buffers 12/12 Packages (485 nodes)
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: (supports S0 S1 S4 S5)
<4>ACPI: PCI Interrupt Link [PILA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILE] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
<4>ACPI: PCI Interrupt Link [PILF] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
<4>ACPI: PCI Interrupt Link [PILG] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILH] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILI] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<6>ACPI: Embedded Controller [EC0] (gpe 34)
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00f6420
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xfa000:0x0, dseg 0xf0000
<3>PnPBIOS: dev_node_info: Unexpected status 0x82
<3>PnPBIOS: dev_node_info: Unexpected status 0x82
<4>ACPI: PCI Interrupt Link [PILE] enabled at IRQ 5
<4>ACPI: PCI Interrupt Link [PILF] enabled at IRQ 5
<4> pci_irq-0294 [09] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.0
<4>ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 15
<4> pci_irq-0294 [09] acpi_pci_irq_derive   : Unable to derive IRQ for device 01:00.0
<4>ACPI: No IRQ known for interrupt pin A of device 01:00.0 - using IRQ 11
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
<6>SBF: Simple Boot Flag extension found and enabled.
<6>SBF: Setting boot flags 0x1
<4>Starting kswapd
<4>BIO: pool of 256 setup, 15Kb (60 bytes/bio)
<4>biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
<4>biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
<4>biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
<4>biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
<4>biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
<4>biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
<5>aio_setup: sizeof(struct page) = 40
<6>Journalled Block Device driver loaded
<5>udf: registering filesystem
<6>Capability LSM initialized
<6>ACPI: AC Adapter [AC] (on-line)
<6>ACPI: Battery Slot [BAT0] (battery present)
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Sleep Button (CM) [SLPB]
<6>ACPI: Lid Switch [LID]
<6>ACPI: Processor [CPU0] (supports C1 C2 C3)
<6>ACPI: Thermal Zone [THR2] (50 C)
<6>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>pty: 256 Unix98 ptys configured
<6>Real Time Clock Driver v1.11
<4>block request queues:
<4> 128 requests per read queue
<4> 128 requests per write queue
<4> 8 requests per batch
<4> enter congestion at 31
<4> exit congestion at 33
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>ALI15X3: IDE controller at PCI slot 00:10.0
<4> pci_irq-0294 [08] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.0
<4>ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 15
<6>ALI15X3: chipset revision 195
<6>ALI15X3: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0x7050-0x7057, BIOS settings: hda:DMA, hdb:pio
<6>ALI15X3: simplex device: DMA forced
<4>    ide1: BM-DMA at 0x7058-0x705f, BIOS settings: hdc:DMA, hdd:DMA
<4>hda: IBM-DJSA-220, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hda: host protected area => 1
<6>hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2432/255/63, UDMA(33)
<6> hda: hda1 hda2 hda3 hda4
<7>register interface 'mouse' with class 'input
<6>mice: PS/2 mouse device common for all mice
<4>atkbd.c: Unknown key (set 0, scancode 0xfc, on isa0060/serio1) pressed.
<6>input: PS/2 Generic Mouse on isa0060/serio1
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: AT Set 2 keyboard on isa0060/serio0
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>pci_hotplug: PCI Hot Plug PCI Core version: 0.4
<6>Advanced Linux Sound Architecture Driver Version 0.9.0rc3 (Fri Oct 04 13:09:13 2002 UTC).
<3>request_module[snd-card-0]: not ready
<3>request_module[snd-card-1]: not ready
<3>request_module[snd-card-2]: not ready
<3>request_module[snd-card-3]: not ready
<3>request_module[snd-card-4]: not ready
<3>request_module[snd-card-5]: not ready
<3>request_module[snd-card-6]: not ready
<3>request_module[snd-card-7]: not ready
<6>ALSA device list:
<6>  No soundcards found.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP: routing cache hash table of 1024 buckets, 8Kbytes
<6>TCP: Hash tables configured (established 16384 bind 16384)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>Resume Machine: resuming from /dev/hda2
<4>Resuming from device ide0(3,2)
<3>Resume Machine: This is normal swap space
<6>EXT3-fs: INFO: recovery required on readonly filesystem.
<6>EXT3-fs: write access will be enabled during recovery.
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3-fs: ide0(3,4): orphan cleanup on readonly fs
<7>ext3_orphan_cleanup: deleting unreferenced inode 1227932
<7>ext3_orphan_cleanup: deleting unreferenced inode 1227931
<7>ext3_orphan_cleanup: deleting unreferenced inode 1226663
<6>EXT3-fs: ide0(3,4): 3 orphan inodes deleted
<6>EXT3-fs: recovery complete.
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>VFS: Mounted root (ext3 filesystem) readonly.
<4>Freeing unused kernel memory: 104k freed
<6>Adding 369484k swap on /dev/hda2.  Priority:42 extents:1
<6>EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Kernel config:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_X86_SPEEDSTEP=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_HOTPLUG_PCI=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=64
CONFIG_AIC7XXX_RESET_DELAY_MS=2000
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_ARPD=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IPV6=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
CONFIG_VLAN_8021Q=m
CONFIG_BRIDGE=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_E100=y
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_NET_RADIO=y
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_AIRO_CS=m
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_INTEL_RNG=y
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_VIRMIDI=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_ALI5451=m
CONFIG_SND_INTEL8X0=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_LONG_TIMEOUT=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD_ALT=m
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
