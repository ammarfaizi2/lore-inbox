Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRCMXGL>; Tue, 13 Mar 2001 18:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCMXF7>; Tue, 13 Mar 2001 18:05:59 -0500
Received: from monza.monza.org ([209.102.105.34]:4616 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131224AbRCMXFh>;
	Tue, 13 Mar 2001 18:05:37 -0500
Date: Tue, 13 Mar 2001 15:04:20 -0800
From: Tim Wright <timw@splhi.com>
To: Hartmut Holz <hholz@mediabild.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x: Netfinity 4500 SMP freezes without any trace
Message-ID: <20010313150420.B2524@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Hartmut Holz <hholz@mediabild.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AAE7844.B607ACB5@zweitwerk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AAE7844.B607ACB5@zweitwerk.com>; from hholz@mediabild.com on Tue, Mar 13, 2001 at 08:43:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reboot with 'nmi_watchdog=0'. That will "fix" it for now.
Still chasing this. I'll announce when I find out root cause.

Tim

On Tue, Mar 13, 2001 at 08:43:01PM +0100, Hartmut Holz wrote:
> 
> Hello,
> 
> our Netfinity 4500 SMP seems to be running ok on the 2.2.x series, but
> on the 2.4-x series it freezes
> after sometime. A real nice freeze - The Console looks like it is
> running, but its completely dead.
> 
> The system freezes when its idle after a day.   Some how I suspected
> the  Adaptec
> SCSI controller.  I wrote 16G, 8G and 4G  files on the disc - The
> Netfinity  had
> runtimes from a half hour to about  two hours.
> 
> In our first Configuration we included the SYM53C8XX SCSI support (by
> accident)
> the runtime was a half hour.
> 
> I tested 2.4.2 and 2.4.3pre4 - No difference.
> 
> I watched the SCSI debug messages - No hint.
> 
> With or without IBM SCSI raid - No diference.
> 
> Anyway our Configuration:
> 
> lspci:
> -----
> 00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
> 00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
> 00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
> 00:02.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
> LANCE] (rev 44)
> 00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f)
> 00:0f.1 IDE interface: Relience Computer: Unknown device 0211
> 00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04)
> 01:03.0 SCSI storage controller: Adaptec 7899P (rev 01)
> 01:03.1 SCSI storage controller: Adaptec 7899P (rev 01)
> 
> 
> 
> dmesg:
> ------
> Waiting for send to finish...
> +#startup loops: 2.
> Sending STARTUP #1.
> After apic_write.
> Initializing CPU#1
> CPU#1 (phys ID: 0) waiting for CALLOUT
> Startup point 1.
> Waiting for send to finish...
> +Sending STARTUP #2.
> After apic_write.
> Startup point 1.
> Waiting for send to finish...
> +After Startup.
> Before Callout 1.
> After Callout 1.
> CALLIN, before setup_local_APIC().
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 1854.66 BogoMIPS
> Stack at about cfff5fbc
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check reporting enabled on CPU#1.
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU: Common caps: 0383fbff 00000000 00000000 00000000
> OK.
> CPU1: Intel Pentium III (Coppermine) stepping 03
> CPU has booted.
> Before bogomips.
> Total of 2 processors activated (3709.33 BogoMIPS).
> Before bogocount - setting activated=1.
> Boot done.
> ENABLING IO-APIC IRQs
> ...changing IO-APIC physical APIC ID to 14 ... ok.
> BIOS bug, IO-APIC#1 ID is 15 in the MPC table!...
> ... fixing up to 15. (tell your hw vendor)
> ...changing IO-APIC physical APIC ID to 15 ... ok.
> Synchronizing Arb IDs.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 14-0, 14-5, 15-0, 15-1, 15-2, 15-3, 15-4, 15-5,
> 15-6, 15-7, 15-8, 15-9, 15-14, 15-15 not connected.
> ..TIMER: vector=49 pin1=2 pin2=0
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...
> ..... (found pin 0) ...works.
> number of MP IRQ sources: 19.
> number of IO-APIC #14 registers: 16.
> number of IO-APIC #15 registers: 16.
> testing the IO APIC.......................
> 
> IO APIC #14......
> .... register #00: 0E000000
> .......    : physical APIC id: 0E
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 003 03  0    0    0   0   0    1    1    31
>  01 003 03  0    0    0   0   0    1    1    39
>  02 000 00  1    0    0   0   0    0    0    00
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 000 00  1    0    0   0   0    0    0    00
>  06 003 03  0    0    0   0   0    1    1    51
>  07 003 03  0    0    0   0   0    1    1    59
>  08 003 03  0    0    0   0   0    1    1    61
>  09 003 03  1    1    0   1   0    1    1    69
>  0a 003 03  0    0    0   0   0    1    1    71
>  0b 003 03  0    0    0   0   0    1    1    79
>  0c 003 03  0    0    0   0   0    1    1    81
>  0d 003 03  0    0    0   0   0    1    1    89
>  0e 003 03  0    0    0   0   0    1    1    91
>  0f 003 03  0    0    0   0   0    1    1    99
> 
> IO APIC #15......
> .... register #00: 0F000000
> .......    : physical APIC id: 0F
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : IO APIC version: 0011
> .... register #02: 0A000000
> .......     : arbitration: 0A
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 000 00  1    0    0   0   0    0    0    00
>  02 000 00  1    0    0   0   0    0    0    00
>  03 000 00  1    0    0   0   0    0    0    00
>  04 000 00  1    0    0   0   0    0    0    00
>  05 000 00  1    0    0   0   0    0    0    00
>  06 000 00  1    0    0   0   0    0    0    00
>  07 000 00  1    0    0   0   0    0    0    00
>  08 000 00  1    0    0   0   0    0    0    00
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 003 03  1    1    0   1   0    1    1    A1
>  0b 003 03  1    1    0   1   0    1    1    A9
>  0c 003 03  1    1    0   1   0    1    1    B1
>  0d 003 03  1    1    0   1   0    1    1    B9
>  0e 000 00  1    0    0   0   0    0    0    00
>  0f 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 2
> IRQ1 -> 1
> IRQ3 -> 3
> IRQ4 -> 4
> IRQ5 -> 10
> IRQ6 -> 6
> IRQ7 -> 7
> IRQ8 -> 8
> IRQ9 -> 9
> IRQ10 -> 10
> IRQ11 -> 11
> IRQ12 -> 12
> IRQ13 -> 13
> IRQ14 -> 14
> IRQ15 -> 15
> IRQ27 -> 11
> IRQ28 -> 12
> IRQ29 -> 13
> .................................... done.
> calibrating APIC timer ...
> ..... CPU clock speed is 930.2699 MHz.
> ..... host bus clock speed is 132.8955 MHz.
> cpu: 0, clocks: 1328955, slice: 442985
> CPU0<T0:1328944,T1:885952,D:7,S:442985,C:1328955>
> cpu: 1, clocks: 1328955, slice: 442985
> CPU1<T0:1328944,T1:442960,D:14,S:442985,C:1328955>
> checking TSC synchronization across CPUs: passed.
> Setting commenced=1, go go go
> mtrr: your CPUs had inconsistent fixed MTRR settings
> mtrr: probably your BIOS does not setup all CPUs
> PCI: PCI BIOS revision 2.10 entry at 0xfd2fc, last bus=4
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Discovered peer bus 01
> PCI->APIC IRQ transform: (B0,I2,P0) -> 27
> PCI->APIC IRQ transform: (B0,I15,P0) -> 9
> PCI->APIC IRQ transform: (B1,I3,P0) -> 28
> PCI->APIC IRQ transform: (B1,I3,P1) -> 29
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> pty: 256 Unix98 ptys configured
> block: queued sectors max/low 169525kB/56508kB, 512 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
> ServerWorks OSB4: chipset revision 0
> ServerWorks OSB4: not 100% native mode: will probe irqs later
> hda: CRN-8241B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 24X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.12
> Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> pcnet32_probe_pci: found device 0x001022.0x002000
>     ioaddr=0x002000  resource_flags=0x000101
> eth0: PCnet/FAST III 79C975 at 0x2000, 00 02 55 58 42 40
> pcnet32: pcnet32_private lp=cff3e000 lp_dma_addr=0xff3e000 assigned IRQ
> 27.
> pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de
> SCSI subsystem driver Revision: 1.00
> request_module[scsi_hostadapter]: Root fs not mounted
> request_module[scsi_hostadapter]: Root fs not mounted
> request_module[scsi_hostadapter]: Root fs not mounted
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
>         <Adaptec aic7899 Ultra160 SCSI adapter>
>         aic7899: Wide Channel A, SCSI Id=7, 32/255 SCBs
> 
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
>         <Adaptec aic7899 Ultra160 SCSI adapter>
>         aic7899: Wide Channel B, SCSI Id=7, 32/255 SCBs
> 
>   Vendor: IBM-PSG   Model: DDYS-T36950M  M   Rev: S9AA
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
> (scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
>   Vendor: IBM       Model: YGLv3 S2          Rev: 0
>   Type:   Processor                          ANSI SCSI revision: 02
> Detected scsi generic sg1 at scsi1, channel 0, id 8, lun 0, type 3
> scsi1:0:0:0: Tagged Queuing enabled.  Depth 8
> SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
> Partition check:
>  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 192k freed
> 
> config:
> #
> # Automatically generated by make menuconfig: don't edit
> #
> CONFIG_X86=y
> CONFIG_ISA=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_HAVE_DEC_LOCK=y
> 
> #
> # General setup
> #
> CONFIG_NET=y
> # CONFIG_VISWS is not set
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
> # CONFIG_PCMCIA is not set
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_PM is not set
> # CONFIG_ACPI is not set
> # CONFIG_APM is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play configuration
> #
> # CONFIG_PNP is not set
> # CONFIG_ISAPNP is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=m
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> # CONFIG_BLK_DEV_MD is not set
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID5 is not set
> # CONFIG_BLK_DEV_LVM is not set
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> # CONFIG_NETLINK is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_IPV6 is not set
> # CONFIG_KHTTPD is not set
> # CONFIG_ATM is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> # CONFIG_PHONE_IXJ is not set
> 
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
> # CONFIG_BLK_DEV_IDEDISK_IBM is not set
> # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
> # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
> # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
> # CONFIG_BLK_DEV_IDEDISK_WD is not set
> # CONFIG_BLK_DEV_COMMERIAL is not set
> # CONFIG_BLK_DEV_TIVO is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> # CONFIG_BLK_DEV_ISAPNP is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_IDEPCI_SHARE_IRQ is not set
> # CONFIG_BLK_DEV_IDEDMA_PCI is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_IDEDMA_PCI_AUTO is not set
> # CONFIG_BLK_DEV_IDEDMA is not set
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_AEC62XX_TUNING is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_WDC_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD7409 is not set
> # CONFIG_AMD7409_OVERRIDE is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_HPT34X_AUTODMA is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_PIIX_TUNING is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX is not set
> # CONFIG_PDC202XX_BURST is not set
> # CONFIG_BLK_DEV_OSB4 is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> # CONFIG_IDEDMA_AUTO is not set
> # CONFIG_DMA_NONPCI is not set
> # CONFIG_BLK_DEV_IDE_MODES is not set
> 
> #
> # SCSI support
> #
> CONFIG_SCSI=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_CHR_DEV_ST=y
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> CONFIG_AIC7XXX_PROC_STATS=y
> CONFIG_AIC7XXX_RESET_DELAY=5
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> CONFIG_SCSI_IPS=y
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> # CONFIG_I2O_PCI is not set
> # CONFIG_I2O_BLOCK is not set
> # CONFIG_I2O_LAN is not set
> # CONFIG_I2O_SCSI is not set
> # CONFIG_I2O_PROC is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_NET_SB1000 is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> CONFIG_PCNET32=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_TULIP is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_DGRS is not set
> # CONFIG_DM9102 is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_EEPRO100_PM is not set
> # CONFIG_LNE390 is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_NE3210 is not set
> # CONFIG_ES3210 is not set
> # CONFIG_8139TOO is not set
> # CONFIG_RTL8129 is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Input core support
> #
> # CONFIG_INPUT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_SERIAL_CONSOLE=y
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> CONFIG_82C710_MOUSE=y
> # CONFIG_PC110_PAD is not set
> 
> #
> # Joysticks
> #
> # CONFIG_JOYSTICK is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_INTEL_RNG is not set
> # CONFIG_NVRAM is not set
> # CONFIG_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_ADFS_FS_RW is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BFS_FS is not set
> CONFIG_FAT_FS=m
> # CONFIG_MSDOS_FS is not set
> # CONFIG_UMSDOS_FS is not set
> CONFIG_VFAT_FS=m
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_RAMFS is not set
> CONFIG_ISO9660_FS=y
> # CONFIG_JOLIET is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX4FS_RW is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_SYSV_FS_WRITE is not set
> # CONFIG_UDF_FS is not set
> # CONFIG_UDF_RW is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_UFS_FS_WRITE is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_ROOT_NFS is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> # CONFIG_SMB_FS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_NCPFS_PACKET_SIGNING is not set
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> # CONFIG_NCPFS_STRONG is not set
> # CONFIG_NCPFS_NFS_NS is not set
> # CONFIG_NCPFS_OS2_NS is not set
> # CONFIG_NCPFS_SMALLDOS is not set
> # CONFIG_NCPFS_NLS is not set
> # CONFIG_NCPFS_EXTRAS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_SMB_NLS is not set
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="cp437"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=m
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VIDEO_SELECT is not set
> # CONFIG_MDA_CONSOLE is not set
> 
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_MAGIC_SYSRQ is not set
> [root@www src]# cat config.24
> #
> # Automatically generated by make menuconfig: don't edit
> #
> CONFIG_X86=y
> CONFIG_ISA=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_HAVE_DEC_LOCK=y
> 
> #
> # General setup
> #
> CONFIG_NET=y
> # CONFIG_VISWS is not set
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
> # CONFIG_PCMCIA is not set
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_PM is not set
> # CONFIG_ACPI is not set
> # CONFIG_APM is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play configuration
> #
> # CONFIG_PNP is not set
> # CONFIG_ISAPNP is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=m
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> # CONFIG_BLK_DEV_MD is not set
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID5 is not set
> # CONFIG_BLK_DEV_LVM is not set
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> # CONFIG_NETLINK is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_IPV6 is not set
> # CONFIG_KHTTPD is not set
> # CONFIG_ATM is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> # CONFIG_PHONE_IXJ is not set
> 
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
> # CONFIG_BLK_DEV_IDEDISK_IBM is not set
> # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
> # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
> # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
> # CONFIG_BLK_DEV_IDEDISK_WD is not set
> # CONFIG_BLK_DEV_COMMERIAL is not set
> # CONFIG_BLK_DEV_TIVO is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> # CONFIG_BLK_DEV_ISAPNP is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_IDEPCI_SHARE_IRQ is not set
> # CONFIG_BLK_DEV_IDEDMA_PCI is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_IDEDMA_PCI_AUTO is not set
> # CONFIG_BLK_DEV_IDEDMA is not set
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_AEC62XX_TUNING is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_WDC_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD7409 is not set
> # CONFIG_AMD7409_OVERRIDE is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_HPT34X_AUTODMA is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_PIIX_TUNING is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX is not set
> # CONFIG_PDC202XX_BURST is not set
> # CONFIG_BLK_DEV_OSB4 is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> # CONFIG_IDEDMA_AUTO is not set
> # CONFIG_DMA_NONPCI is not set
> # CONFIG_BLK_DEV_IDE_MODES is not set
> 
> #
> # SCSI support
> #
> CONFIG_SCSI=y
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_CHR_DEV_ST=y
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> CONFIG_AIC7XXX_PROC_STATS=y
> CONFIG_AIC7XXX_RESET_DELAY=5
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> CONFIG_SCSI_IPS=y
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> # CONFIG_I2O_PCI is not set
> # CONFIG_I2O_BLOCK is not set
> # CONFIG_I2O_LAN is not set
> # CONFIG_I2O_SCSI is not set
> # CONFIG_I2O_PROC is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_NET_SB1000 is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> CONFIG_PCNET32=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_TULIP is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_DGRS is not set
> # CONFIG_DM9102 is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_EEPRO100_PM is not set
> # CONFIG_LNE390 is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_NE3210 is not set
> # CONFIG_ES3210 is not set
> # CONFIG_8139TOO is not set
> # CONFIG_RTL8129 is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Input core support
> #
> # CONFIG_INPUT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_SERIAL_CONSOLE=y
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> CONFIG_82C710_MOUSE=y
> # CONFIG_PC110_PAD is not set
> 
> #
> # Joysticks
> #
> # CONFIG_JOYSTICK is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_INTEL_RNG is not set
> # CONFIG_NVRAM is not set
> # CONFIG_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_ADFS_FS_RW is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BFS_FS is not set
> CONFIG_FAT_FS=m
> # CONFIG_MSDOS_FS is not set
> # CONFIG_UMSDOS_FS is not set
> CONFIG_VFAT_FS=m
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_RAMFS is not set
> CONFIG_ISO9660_FS=y
> # CONFIG_JOLIET is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX4FS_RW is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_SYSV_FS_WRITE is not set
> # CONFIG_UDF_FS is not set
> # CONFIG_UDF_RW is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_UFS_FS_WRITE is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_ROOT_NFS is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> # CONFIG_SMB_FS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_NCPFS_PACKET_SIGNING is not set
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> # CONFIG_NCPFS_STRONG is not set
> # CONFIG_NCPFS_NFS_NS is not set
> # CONFIG_NCPFS_OS2_NS is not set
> # CONFIG_NCPFS_SMALLDOS is not set
> # CONFIG_NCPFS_NLS is not set
> # CONFIG_NCPFS_EXTRAS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_SMB_NLS is not set
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="cp437"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=m
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VIDEO_SELECT is not set
> # CONFIG_MDA_CONSOLE is not set
> 
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_MAGIC_SYSRQ is not set
> 
> 
> 
> Regards
> 
> Hartmut
> 
> --
> Hartmut Holz
> zweitwerk GmbH - ein Unternehmen der Media Bild Imaging AG
> Stahltwiete 16
> 22761 Hamburg
> 
> Tel: 040 / 853756-14
> Fax: 040 / 853756-50
> email: holz@zweitwerk.com
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
