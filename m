Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271185AbRHZAoo>; Sat, 25 Aug 2001 20:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271186AbRHZAof>; Sat, 25 Aug 2001 20:44:35 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:48864 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S271185AbRHZAo1>; Sat, 25 Aug 2001 20:44:27 -0400
Date: Sat, 25 Aug 2001 17:41:24 -0700
To: Andre Hedrick <andre@aslab.com>
Cc: Ross Boylan <RossBoylan@stanfordalumni.org>, sfr@canb.auug.org.au,
        Andre Hedrick <andre@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE drive won't come back after power down
Message-ID: <20010825174124.B949@wheat.boylan.org>
In-Reply-To: <20010825154508.A949@wheat.boylan.org> <Pine.LNX.4.10.10108251714480.10127-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10108251714480.10127-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.20i
From: Ross Boylan <RossBoylan@stanfordalumni.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the diagnosis.  My system is a tower, not a laptop, but I
think it does have ACPI.  I infer this from the kernel MS W2K picked
out and the recency of the motherboard; I don't see it mentioned in
the M/B docs.  Should any ACPI system have the problem, or only
laptops?

It sounds as if the easiest thing might be to disable the spin down of
the disk.  Is there a way to do that?

I'm not versed enough in the details to understand the work-arounds
you propose below.  If I had the TASKFILE code, what would I do with
it? 

Is the noisy reset option a way to spin the disk up before there's
trouble?  Perhaps I could stash it on a RAM disk.

Thanks.

P.S. I'm right across the bay in SF.

On Sat, Aug 25, 2001 at 05:24:07PM -0700, Andre Hedrick wrote:
> 
> Greetings Ross,
> 
> The problem is that the requirements of ACPI is to have a
> "taskfile register access", but that will not be accepted until 2.5.
> Therefore, the short nice answer is that you and everyone else with a
> laptop of system using ACPI are "HOSED".
> 
> I will be happy to provide you the TASKFILE code, however ACPI does not
> yet have a method to call the kernel direct access.
> 
> Maybe when there are enough people screaming and raise general hell over
> the issue it may happen earlier.
> 
> You can attempt the noisy reset additions to some versions of hdparm, and
> then issuing the the checkpower commands until staus is reported as ready,
> but that is very messy and you have to have that app in an accessible
> location and that is not usable.  The obvious reason is that the app is on
> the disk that is spundown.
> 
> This is not the answer you wanted, but it is the cold bloody truth.
> 
> Regards,
> 
> Andre Hedrick
> CTO ASL, Inc.
> Linux ATA Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Tel: (510) 857-0055 x103
> 38875 Cherry Street                           Fax: (510) 857-0010
> Newark, CA 94560                              Web: www.aslab.com
> 
> 
> On Sat, 25 Aug 2001, Ross Boylan wrote:
> 
> > Most times when I go away from my system for an extended period and
> > come back, my hard disk hangs up and I must power down the system to
> > get it back (hardware reset is insufficient).  It seems the attempt to
> > power the disk back up doesn't quite work.  
> > 
> > I sent a note to Andre Hedrick awhile ago, but haven't heard anything
> > back.  Because of that, and because it seems the problem has something
> > to do with power management, and because it's getting worse, I'm
> > writing to you.  I'll also try a few other addresses for Andre!
> > 
> > The problem repeats often, but I can't quite get it at will.  I tried
> > going away for half an hour to see if the system would hang and it did
> > not.  I don't know if this is because half an hour is too little, or the
> > system needs more total uptime to misbehave (I did the test first
> > thing in the morning), or it needs to get hotter, or something else.
> > 
> > I do not see this problem when running other OS's on the same
> > hardware.
> > 
> > This problem is making it difficult to use the system, and disaster
> > recovery is taking an increasing amount of time, so I'd really like to
> > isolate it and fix it.
> > 
> > Here, with some possible transcription errors, is the console log from
> > a recent incident:
> > hda irq timeout: status 0xd0  { Busy }
> > ide 0: reset success
> > end_request: I/O error dev 03:06 (hda)
> > 		 sector 13976
> > hda: status timeout: status = 0xd0 { Busy }
> > hda: drive_not_ready for command
> > Ext-fs error: (device ?? 16772
> >        device ide0(3,6))
> >        ext: write_inode:
> >        unable to read inode 3384 block 8369
> >   [more like that]
> > remount fs read only
> > 
> > When I hit hardware reset the BIOS start sequence appears and then I
> > get Pri Master HDD Error.
> > 
> > Power off, wait, power on, all's well (except, of course, that it
> > fsck's the disks on restart).
> > 
> > 
> > Can anyone suggest a diagnosis or cure?  Could enabling the AMD Viper
> > chipset support be causing trouble?
> > 
> > Thanks.
> > 
> > Details:
> > 
> > Kernel 2.4.7 under Debian woody, built from source.  The problem has
> > been occuring for several generations of 2.4 kernels.
> > 
> > /hda6 is my root partition, on an ATA2 Maxtor drive.  /hdb is another
> > Maxtor drive, ATA4.  /hdc is a Sony ATA CD-Writer, CDU 928E.  I have
> > the ide-scsi driver loaded so I can write to it.  /hdd non-existent.
> > 
> > Gigabyte GA-71XE4 motherboard with an AMD 750 Chipset, including AMD
> > 756 ISA controller.  This is said to provide PIO and Bus Master
> > (Ultra DMA33/ATA 66) operations.  It has power management.
> > 
> > I experience the problem with the BIOS setting for power management on
> > or off.
> > 
> > AMD Athlon 800Mhz CPU.  384Mg Ram.
> > 
> > Here are excerpts of the kernel build options:
> > 
> > /bin/sh scripts/Configure -d arch/i386/config.in
> > #
> > # Using defaults found in .config
> > #
> > *
> > * Code maturity level options
> > *
> > Prompt for development and/or incomplete code/drivers (CONFIG_EXPERIMENTAL) [N/y/?] 
> > *
> > * Loadable module support
> > *
> > Enable loadable module support (CONFIG_MODULES) [Y/n/?] 
> >   Set version information on all module symbols (CONFIG_MODVERSIONS) [Y/n/?] 
> >   Kernel module loader (CONFIG_KMOD) [Y/n/?] 
> > *
> > * Processor type and features
> > *
> > Processor family (386, 486, 586/K5/5x86/6x86/6x86MX, Pentium-Classic, Pentium-MMX, Pentium-Pro/Celeron/Pentium-II, Pentium-III/Celeron(Coppermine), Pentium-4, K6/K6-II/K6-III, Athlon/Duron/K7, Crusoe, Winchip-C6, Winchip-2, Winchip-2A/Winchip-3, CyrixIII/C3) [Athlon/Duron/K7] 
> >   defined CONFIG_MK7
> > Toshiba Laptop support (CONFIG_TOSHIBA) [N/y/m/?] 
> > /dev/cpu/microcode - Intel IA32 CPU microcode support (CONFIG_MICROCODE) [N/y/m/?] 
> > /dev/cpu/*/msr - Model-specific register support (CONFIG_X86_MSR) [N/y/m/?] 
> > /dev/cpu/*/cpuid - CPU information support (CONFIG_X86_CPUID) [N/y/m/?] 
> > High Memory Support (off, 4GB, 64GB) [off] 
> >   defined CONFIG_NOHIGHMEM
> > Math emulation (CONFIG_MATH_EMULATION) [N/y/?] 
> > MTRR (Memory Type Range Register) support (CONFIG_MTRR) [N/y/?] 
> > Symmetric multi-processing support (CONFIG_SMP) [N/y/?] 
> > APIC and IO-APIC support on uniprocessors (CONFIG_X86_UP_IOAPIC) [N/y/?] 
> > *
> > * General setup
> > *
> > Networking support (CONFIG_NET) [Y/n/?] 
> > SGI Visual Workstation support (CONFIG_VISWS) [N/y/?] 
> > PCI support (CONFIG_PCI) [Y/n/?] 
> >   PCI access mode (BIOS, Direct, Any) [Any] 
> >   defined CONFIG_PCI_GOANY
> > PCI device name database (CONFIG_PCI_NAMES) [Y/n/?] 
> > EISA support (CONFIG_EISA) [Y/n/?] 
> > MCA support (CONFIG_MCA) [N/y/?] 
> > Support for hot-pluggable devices (CONFIG_HOTPLUG) [Y/n/?] 
> > *
> > * PCMCIA/CardBus support
> > *
> > PCMCIA/CardBus support (CONFIG_PCMCIA) [N/y/m/?] 
> > System V IPC (CONFIG_SYSVIPC) [Y/n/?] 
> > BSD Process Accounting (CONFIG_BSD_PROCESS_ACCT) [Y/n/?] 
> > Sysctl support (CONFIG_SYSCTL) [Y/n/?] 
> > Kernel core (/proc/kcore) format (ELF, A.OUT) [ELF] 
> >   defined CONFIG_KCORE_ELF
> > Kernel support for a.out binaries (CONFIG_BINFMT_AOUT) [M/n/y/?] 
> > Kernel support for ELF binaries (CONFIG_BINFMT_ELF) [Y/m/n/?] 
> > Kernel support for MISC binaries (CONFIG_BINFMT_MISC) [M/n/y/?] 
> > Power Management support (CONFIG_PM) [Y/n/?] 
> >   Advanced Power Management BIOS support (CONFIG_APM) [Y/m/n/?] 
> >     Ignore USER SUSPEND (CONFIG_APM_IGNORE_USER_SUSPEND) [N/y/?] 
> >     Enable PM at boot time (CONFIG_APM_DO_ENABLE) [Y/n/?] 
> >     Make CPU Idle calls when idle (CONFIG_APM_CPU_IDLE) [Y/n/?] 
> >     Enable console blanking using APM (CONFIG_APM_DISPLAY_BLANK) [N/y/?] 
> >     RTC stores time in GMT (CONFIG_APM_RTC_IS_GMT) [N/y/?] 
> >     Allow interrupts during APM BIOS calls (CONFIG_APM_ALLOW_INTS) [N/y/?] 
> >     Use real mode APM BIOS call to power off (CONFIG_APM_REAL_MODE_POWER_OFF) [N/y/?] 
> > *
> > * Plug and Play configuration
> > *
> > Plug and Play support (CONFIG_PNP) [M/n/y/?] 
> >   ISA Plug and Play support (CONFIG_ISAPNP) [M/n/?] 
> > *
> > * Block devices
> > *
> > Normal PC floppy disk support (CONFIG_BLK_DEV_FD) [M/n/y/?] 
> > XT hard disk support (CONFIG_BLK_DEV_XD) [N/y/m/?] 
> > Parallel port IDE device support (CONFIG_PARIDE) [N/m/?] 
> > Compaq SMART2 support (CONFIG_BLK_CPQ_DA) [N/y/m/?] 
> > Compaq Smart Array 5xxx support (CONFIG_BLK_CPQ_CISS_DA) [N/y/m/?] 
> > Mylex DAC960/DAC1100 PCI RAID Controller support (CONFIG_BLK_DEV_DAC960) [N/y/m/?] 
> > Loopback device support (CONFIG_BLK_DEV_LOOP) [M/n/y/?] 
> > Network block device support (CONFIG_BLK_DEV_NBD) [N/y/m/?] 
> > RAM disk support (CONFIG_BLK_DEV_RAM) [N/y/m/?] 
> > *
> > * Multi-device support (RAID and LVM)
> > *
> > Multiple devices driver support (RAID and LVM) (CONFIG_MD) [N/y/?] 
> > *
> > * ATA/IDE/MFM/RLL support
> > *
> > ATA/IDE/MFM/RLL support (CONFIG_IDE) [Y/m/n/?] 
> > *
> > * IDE, ATA and ATAPI Block devices
> > *
> > Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support (CONFIG_BLK_DEV_IDE) [Y/m/n/?] 
> > *
> > * Please see Documentation/ide.txt for help/info on IDE drives
> > *
> >   Use old disk-only driver on primary interface (CONFIG_BLK_DEV_HD_IDE) [N/y/?] 
> >   Include IDE/ATA-2 DISK support (CONFIG_BLK_DEV_IDEDISK) [Y/m/n/?] 
> >     Use multi-mode by default (CONFIG_IDEDISK_MULTI_MODE) [N/y/?] 
> >   Include IDE/ATAPI CDROM support (CONFIG_BLK_DEV_IDECD) [M/n/y/?] 
> >   Include IDE/ATAPI TAPE support (CONFIG_BLK_DEV_IDETAPE) [N/y/m/?] 
> >   Include IDE/ATAPI FLOPPY support (CONFIG_BLK_DEV_IDEFLOPPY) [N/y/m/?] 
> >   SCSI emulation support (CONFIG_BLK_DEV_IDESCSI) [M/n/?] 
> > *
> > * IDE chipset support/bugfixes
> > *
> >   CMD640 chipset bugfix/support (CONFIG_BLK_DEV_CMD640) [Y/n/?] 
> >     CMD640 enhanced support (CONFIG_BLK_DEV_CMD640_ENHANCED) [N/y/?] 
> >   RZ1000 chipset bugfix/support (CONFIG_BLK_DEV_RZ1000) [Y/n/?] 
> >   Generic PCI IDE chipset support (CONFIG_BLK_DEV_IDEPCI) [Y/n/?] 
> >     Sharing PCI IDE interrupts support (CONFIG_IDEPCI_SHARE_IRQ) [Y/n/?] 
> >     Generic PCI bus-master DMA support (CONFIG_BLK_DEV_IDEDMA_PCI) [Y/n/?] 
> >     Boot off-board chipsets first support (CONFIG_BLK_DEV_OFFBOARD) [N/y/?] 
> >       Use PCI DMA by default when available (CONFIG_IDEDMA_PCI_AUTO) [Y/n/?] 
> >     AEC62XX chipset support (CONFIG_BLK_DEV_AEC62XX) [N/y/?] 
> >     ALI M15x3 chipset support (CONFIG_BLK_DEV_ALI15X3) [N/y/?] 
> >     AMD Viper support (CONFIG_BLK_DEV_AMD7409) [Y/n/?] 
> >     CMD64X chipset support (CONFIG_BLK_DEV_CMD64X) [N/y/?] 
> >     CY82C693 chipset support (CONFIG_BLK_DEV_CY82C693) [N/y/?] 
> >     Cyrix CS5530 MediaGX chipset support (CONFIG_BLK_DEV_CS5530) [N/y/?] 
> >     HPT34X chipset support (CONFIG_BLK_DEV_HPT34X) [N/y/?] 
> >     HPT366 chipset support (CONFIG_BLK_DEV_HPT366) [N/y/?] 
> >     Intel PIIXn chipsets support (CONFIG_BLK_DEV_PIIX) [N/y/?] 
> >     NS87415 chipset support (EXPERIMENTAL) (CONFIG_BLK_DEV_NS87415) [N/y/?] 
> >     PROMISE PDC20246/PDC20262/PDC20267 support (CONFIG_BLK_DEV_PDC202XX) [N/y/?] 
> >     ServerWorks OSB4 chipset support (CONFIG_BLK_DEV_OSB4) [N/y/?] 
> >     SiS5513 chipset support (CONFIG_BLK_DEV_SIS5513) [N/y/?] 
> >     SLC90E66 chipset support (CONFIG_BLK_DEV_SLC90E66) [N/y/?] 
> >     Tekram TRM290 chipset support (EXPERIMENTAL) (CONFIG_BLK_DEV_TRM290) [N/y/?] 
> >     VIA82CXXX chipset support (CONFIG_BLK_DEV_VIA82CXXX) [N/y/?] 
> >   Other IDE chipset support (CONFIG_IDE_CHIPSETS) [N/y/?] 
> >   IGNORE word93 Validation BITS (CONFIG_IDEDMA_IVB) [N/y/?] 
> 
> 
