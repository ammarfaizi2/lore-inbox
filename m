Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUJCMBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUJCMBw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUJCMBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:01:52 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:48073 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S267839AbUJCL4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 07:56:55 -0400
Date: Sun, 3 Oct 2004 12:56:49 +0100
From: Alexander Clouter <alex-kernel@digriz.org.uk>
To: pavel@ucw.cz
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.9-rc1->rc3 and futex's hang
Message-ID: <20041003115649.GA22399@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel (and the kernel team),

----------------
summary: kernel's 2.6.9-rc1->2.6.9-rc3 lock up my jabber client (on a futex)
keywords: futex, 2.6.9, hanging (no oops)
----------------

I'm getting desperate, my Jabber client keeps locking up and its kernel
2.6.9-rc1 -> 2.6.9-rc3 [Linux version 2.6.9-rc3 (alex@inskipp) (gcc version
3.3.4 (Debian 1:3.3.4-13)) #12 Sat Oct 2 15:47:07 BST 2004; untainted] that
are causing the problems (bizarrely), whilst with 2.6.8.1 everything is
peachy.

I have tried trimming all the 'fancy' bits/options I choose in the kernel b=
ut=20
it seems to have no effect.

The jabber client (with an strace) shows it hangs on a futex.  I do not have
a clue if this is related to your OpenOffice issue[1], for you it segfaults
OO, for me it hangs my Jabber client (tkabber) and I have to kill it. :(

Now I would love to be able to help more but I do not have a clue where to=
=20
start.

I am currently running two interesting patches (dyn-swapiness and the latest
acpi-20040816 updates); no Pre-Empt either.

I have included my .config and such in hope I can compare it to yours and
vice versa (might have stumbled on a clashing mixture of options).

I have been reading through the 2.6.9-rc1 Changelog and cannot find what
could be significant.  The only strange thing about this is when I'm straci=
ng
its harder (read as takes longer) to reproduce the problem.....a tad
annoying.

Below I attach what the jabber client waits on when it behaves, when it han=
gs=20
it looks like it is still 'behaving' find.  Sending any signal to the proce=
ss=20
seems to mop it up, otherwise using xkill on it leaves it lurking about.

Where, what why?  Help.  I more than likely have not given enough diagnosti=
c=20
information however please send me the requests on what you want me to do o=
r=20
if you have any patch revertations you want me to try and I can.

Cheers

Alex

[1] http://www.spinics.net/lists/kernel/msg295867.html

-------- normal ----------
futex(0x804a900, FUTEX_WAKE, 1)         =3D 1
clock_gettime(CLOCK_REALTIME, {1096803971, 308864000}) =3D 0
futex(0x8345b68, FUTEX_WAIT, 218979, {0, 312180000}) =3D 0
futex(0x804a900, FUTEX_WAKE, 1)         =3D 0
gettimeofday({1096803971, 309222}, {4294967236, 0}) =3D 0
ioctl(8, FIONREAD, [32])                =3D 0
read(8, "\n\3$\355#\0\240\1\0\370\377\277\1\0\0\0 \0\0\0 \0\0\0"..., 32) =
=3D 32
gettimeofday({1096803971, 318643}, {4294967236, 0}) =3D 0
gettimeofday({1096803971, 318695}, {4294967236, 0}) =3D 0
gettimeofday({1096803971, 318774}, {4294967236, 0}) =3D 0
write(6, "\0", 1)                       =3D 1
gettimeofday({1096803971, 318887}, {4294967236, 0}) =3D 0
futex(0x804a900, FUTEX_WAKE, 1)         =3D 1
clock_gettime(CLOCK_REALTIME, {1096803971, 319000000}) =3D 0
futex(0x8345b68, FUTEX_WAIT, 218980, {0, 99756000}) =3D -1 ETIMEDOUT=20
(Connection timed out)
write(6, "\0", 1)                       =3D 1
futex(0x804a900, FUTEX_WAKE, 1)         =3D 1
gettimeofday({1096803971, 419707}, {4294967236, 0}) =3D 0
gettimeofday({1096803971, 419767}, {4294967236, 0}) =3D 0
write(8, "\n\7\2\0G\0\240\1\31\0\v\0@\0\0\0\0\0\30\0\22\0\0\0@\0"..., 52) =
=3D=20
52
write(6, "\0", 1)                       =3D 1
futex(0x804a900, FUTEX_WAKE, 1)         =3D 1
futex(0x8345b68, FUTEX_WAIT, 218981, NULL
-------------------

---------- when it hangs ----------
clock_gettime(CLOCK_REALTIME, {1096804174, 654500000}) =3D 0
futex(0x8345b58, FUTEX_WAKE, 1)         =3D 0
futex(0x804a900, FUTEX_WAKE, 1)         =3D 0
gettimeofday({1096804174, 654555}, {4294967236, 0}) =3D 0
ioctl(8, FIONREAD, [64])                =3D 0
read(8, "\3\'\207\36\235\242\201\4@\0\0\0!\32\240\1\0\0\0\0h\1E"..., 64) =
=3D 64
gettimeofday({1096804174, 654634}, {4294967236, 0}) =3D 0
gettimeofday({1096804174, 654688}, {4294967236, 0}) =3D 0
gettimeofday({1096804174, 654743}, {4294967236, 0}) =3D 0
write(6, "\0", 1)                       =3D 1
gettimeofday({1096804174, 654784}, {4294967236, 0}) =3D 0
futex(0x804a900, FUTEX_WAKE, 1)         =3D 1
clock_gettime(CLOCK_REALTIME, {1096804174, 654825000}) =3D 0
futex(0x8345b68, FUTEX_WAIT, 224296, {0, 76523000}) =3D -1 ETIMEDOUT=20
(Connection timed out)
futex(0x804a900, FUTEX_WAKE, 1)         =3D 0
gettimeofday({1096804174, 736351}, {4294967236, 0}) =3D 0
ioctl(8, FIONREAD, [32])                =3D 0
read(8, "\3A\217\36\317\242\201\4@\0\0\0!\32\240\1\0\0\0\0h\1E\1"..., 32) =
=3D=20
32
gettimeofday({1096804174, 736573}, {4294967236, 0}) =3D 0
gettimeofday({1096804174, 736595}, {4294967236, 0}) =3D 0
gettimeofday({1096804174, 736615}, {4294967236, 0}) =3D 0
gettimeofday({1096804174, 736652}, {4294967236, 0}) =3D 0
write(6, "\0", 1)                       =3D 1
futex(0x804a900, FUTEX_WAKE, 1)         =3D 1
futex(0x8345b58, FUTEX_WAKE, 1)         =3D 1
futex(0x8345b68, FUTEX_WAIT, 224297, NULL
------------------

--
 _________________________________________
/ A bird in the bush usually has a friend \
\ in there with him.                      /
 -----------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

------ /proc/config ------
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-rc3
# Sat Oct  2 15:46:31 2004
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=3Dy
CONFIG_BROKEN_ON_SMP=3Dy

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_HOTPLUG=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=3Dy
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=3Dy

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
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
CONFIG_MPENTIUMM=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_HPET_TIMER=3Dy
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dm
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=3Dm
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_EFI is not set
CONFIG_REGPARM=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
# CONFIG_CPU_FREQ_PROC_INTF is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
# CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=3Dm

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=3Dm
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=3Dm
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=3Dy
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=3Dy
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=3Dy
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dm
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_YENTA=3Dm
CONFIG_CARDBUS=3Dy
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=3Dy

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dy
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=3Dy
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
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
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dm
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dm

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

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=3Dm
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

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
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
# CONFIG_IP_ROUTE_FWMARK is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_TUNNEL=3Dm

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_IPRANGE=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
CONFIG_IRDA_DEBUG=3Dy

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
CONFIG_NSC_FIR=3Dm
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
CONFIG_BT=3Dm
CONFIG_BT_L2CAP=3Dm
CONFIG_BT_SCO=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=3Dm
CONFIG_BT_HCIUSB_SCO=3Dy
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_BCSP_TXCRC=3Dy
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIBTUART is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=3Dm
CONFIG_E1000_NAPI=3Dy
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=3Dy

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
# CONFIG_PPPOE is not set
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

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
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dm
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dm
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_SERIAL_NONSTANDARD=3Dy
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=3Dm
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dm
CONFIG_SERIAL_8250_CS=3Dm
CONFIG_SERIAL_8250_ACPI=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dm
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dm
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=3Dy
CONFIG_HPET_RTC_IRQ=3Dy
CONFIG_HPET_MMAP=3Dy
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_CHARDEV=3Dm

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dm
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
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
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
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=3Dy
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_DEBUG=3Dy
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
CONFIG_FONT_ACORN_8x8=3Dy
CONFIG_FONT_MINI_4x6=3Dy
CONFIG_FONT_SUN8x16=3Dy
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=3Dm
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=3Dm
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=3Dm

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=3Dm
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
CONFIG_SND_INTEL8X0=3Dm
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=3Dm
CONFIG_USB_DEBUG=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_SPLIT_ISO=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=3Dm

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_RW_DETECT=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_HID_FF=3Dy
CONFIG_HID_PID=3Dy
CONFIG_LOGITECH_FF=3Dy
CONFIG_THRUSTMASTER_FF=3Dy
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=3Dm
# CONFIG_USB_SERIAL_PL2303 is not set
CONFIG_USB_SERIAL_SAFE=3Dm
CONFIG_USB_SERIAL_SAFE_PADDED=3Dy
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dm
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=3Dy
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=3Dy
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

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
# CONFIG_CRAMFS is not set
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
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=3Dm
CONFIG_CIFS_STATS=3Dy
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_POSIX is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"UTF8"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dm
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
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dm
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_4KSTACKS=3Dy
# CONFIG_SCHEDSTATS is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dm
CONFIG_CRYPTO_SHA1=3Dy
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES_586=3Dm
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_DEFLATE=3Dm
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC32=3Dm
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_PC=3Dy
------------

------ /proc/cpuinfo -----
alex@inskipp:/usr/src/t40p-patches$ cat /proc/cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1600MHz
stepping        : 5
cpu MHz         : 1599.098
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat=
=20
clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
bogomips        : 3167.57
---------

--------- lsmod -------
alex@inskipp:/usr/src/t40p-patches$ lsmod
Module                  Size  Used by
radeon                125156  0=20
rfcomm                 30748  0=20
l2cap                  18436  5 rfcomm
bluetooth              37892  4 rfcomm,l2cap
deflate                 2816  0=20
zlib_deflate           21528  1 deflate
zlib_inflate           17024  1 deflate
serpent                14976  0=20
aes_i586               38900  0=20
blowfish               10496  0=20
des                    11776  0=20
md5                     3968  0=20
af_key                 25488  2=20
ds                     13572  4=20
thermal                15880  0=20
fan                     4100  0=20
button                  6544  0=20
ac                      4740  0=20
battery                10372  0=20
ath_pci                47904  0=20
ath_rate_onoe           6792  1 ath_pci
wlan                  100444  3 ath_pci,ath_rate_onoe
ath_hal               130128  2 ath_pci
e1000                  78724  0=20
yenta_socket           17408  0=20
pcmcia_core            54468  2 ds,yenta_socket
8250_pci               16512  0=20
8250                   16128  1 8250_pci
serial_core            17920  1 8250
snd_intel8x0           27432  3=20
snd_ac97_codec         63696  1 snd_intel8x0
snd_pcm_oss            46120  0=20
snd_mixer_oss          16384  1 snd_pcm_oss
snd_pcm                78728  3 snd_intel8x0,snd_pcm_oss
snd_timer              19460  2 snd_pcm
snd_page_alloc          7560  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         5632  1 snd_intel8x0
snd_rawmidi            18724  1 snd_mpu401_uart
snd_seq_device          6536  1 snd_rawmidi
snd                    44132  13=20
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mix
er_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
ehci_hcd               39940  0=20
usbhid                 31744  0=20
uhci_hcd               28684  0=20
usbcore               109028  5 ehci_hcd,usbhid,uhci_hcd
ppp_synctty             7552  0=20
ppp_generic            19220  1 ppp_synctty
slhc                    6912  1 ppp_generic
loop                   11912  0=20
xfrm_user              12292  0=20
rtc                     6932  0=20
nvram                   7048  1=20
speedstep_centrino      7124  0=20
freq_table              3460  1 speedstep_centrino
processor              22056  2 thermal,speedstep_centrino
ide_cd                 36768  0=20
cdrom                  36252  1 ide_cd
psmouse                18696  0=20

-----------------------

--=20
 _________________________________________=20
/ A bird in the bush usually has a friend \
\ in there with him.                      /
 -----------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBX+kBNv5Ugh/sRBYRAg1AAJsEGCKCGhmcmP6nUbKbtXhoEITAkQCggt9C
16R/ILt8eg2dY3/m02vEmgQ=
=WxY/
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
