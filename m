Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTEQKxW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 06:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTEQKxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 06:53:22 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:34467 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261405AbTEQKxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 06:53:09 -0400
Subject: Re: 2.5.69-mm6: pccard oops while booting: round 2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: c-d.hailfinger.kernel.2003@gmx.net, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <20030517031840.486683fc.akpm@digeo.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>
	 <20030516132908.62e54266.akpm@digeo.com>
	 <1053121346.569.1.camel@teapot.felipe-alfaro.com>
	 <3EC56173.1000306@gmx.net>
	 <1053166275.586.9.camel@teapot.felipe-alfaro.com>
	 <20030517031840.486683fc.akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-3aZO2qTleK+xSsZyECqh"
Message-Id: <1053169552.613.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 17 May 2003 13:05:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3aZO2qTleK+xSsZyECqh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-05-17 at 12:18, Andrew Morton wrote:
> Bummer.  Vital info is chopped off the top of the oops output.

Well, I'm idiot. Please, disregard my previos mail. This contains the
full oops, config and patch:

---
I've been working on this a little this morning and these are the new
conclusions I've drawn:

1. Definitively, the oops is being caused by the YMFPCI driver. I have
built a mini-kernel by squashing the config to a minimum (disabled
modules, preemptive, removed USB, IDE, AGP, Networking, CardBus, and
nearly everything possible) and the kernel still faults.

2. Compiling the kernel with frame pointers causes a panic during boot
instead of an oops. Thus, I've changed my config to use frame pointers.
I don't know if this will make debugging a little harder or not, but I
think it's interesting to use them as the call trace is a little
different this time.

Attached to this message are the following files:

"ymfpci2.patch" which replaces the "YMPFCI" string with "1MFPCI",
"2MFPCI" and so on. This patch should be applied against a pristine,
clean 2.5.69-mm6 kernel tree.

"config" contains the configuration I used to build the kernel. Nearly
everything has been left off: no swapping, no modules, no preemptive, no
ACPI, no APM, no power management, no IDE, no USB, no AGP, no
networking, etc. I made this to keep the number of additional drivers to
a minimum and being able to concentrate on the faulting driver.

"oops" contains the kernel oops when booting 2.5.69-mm6 + ymfpci2.patch
using the above config file.

Hope this can make things easier for you, guys, cause this thing is
getting greater than me.
---


--=-3aZO2qTleK+xSsZyECqh
Content-Disposition: attachment; filename=config
Content-Type: text/plain; name=config; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# General setup
#
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
# CONFIG_MODULES is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
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
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_025GB is not set
# CONFIG_05GB is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
# CONFIG_NET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# ISDN subsystem
#

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
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_YMFPCI=y
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
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y

--=-3aZO2qTleK+xSsZyECqh
Content-Disposition: attachment; filename=oops
Content-Type: text/plain; name=oops; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Unable to handle kernel paging request at virtual address fceec0d7
 printing eip:
c016954f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c016954f>]     Not tainted VLI
EFLAGS: 00010246
EIP is at sys_create_link+0xcf/0x130
eax: cffedae0   ebx: ffffffff   ecx: ffffffff   edx: fceec0cf
esi: c01d128d   edi: cff5e470   ebp: c12ebf10   esp: c12ebee4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c12ea000 task=c12e9880)
Stack: cff5e470 cffedae0 00000021 c01e8600 c13d0000 cffedae0 00000021 fceec0cf
       c01e8630 cff5e44c 00000000 c12ebf28 c0193932 c01e8600 cff5e470 cff5e470
       c01e85e8 c12ebf44 c01939ba cff5e44c c01e85e8 cff5e454 c01e1f80 c01e85e8
Call Trace:
 [<c0193932>] device_bind_driver+0x42/0x50
 [<c01939ba>] bus_match+0x7a/0x80
 [<c0193aad>] driver_attach+0x5d/0x70
 [<c0193d56>] bus_add_driver+0xa6/0xc0
 [<c01941b1>] driver_register+0x31/0x40
 [<c01a74ca>] snd_ctl_register_ioctl+0x1a/0x70
 [<c017be45>] pci_register_driver+0x45/0x60
 [<c0214f45>] alsa_card_ymfpci_init+0x15/0x50
 [<c020679b>] do_initcalls+0x2b/0xa0
 [<c01231b2>] init_workqueues+0x12/0x30
 [<c0105088>] init+0x28/0x150
 [<c0105060>] init+0x0/0x150
 [<c01073dd>] kernel_thread_helper+0x5/0x18

Code: ac aa 84 c0 75 fa 4b 83 c1 03 83 fb ff 75 ed 8b 45 ec 8b 55 e8 8b 7d 0c 89
 44 24 08 89 54 24 04 89 3c 24 e8 d4 fe ff ff 8b 55 f0 <8b> 42 08 8d 48 6c ff 48
 6c 78 68 8b 45 10 89 14 24 89 44 24 04
 <0>Kernel panic: Attempted to kill init!


--=-3aZO2qTleK+xSsZyECqh
Content-Disposition: attachment; filename=ymfpci2.patch
Content-Type: text/x-patch; name=ymfpci2.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -puN ./sound/pci/ymfpci/ymfpci_main.c~a ./sound/pci/ymfpci/ymfpci_main.c
--- 25/./sound/pci/ymfpci/ymfpci_main.c~a	2003-05-16 13:26:26.000000000 -0700
+++ 25-akpm/./sound/pci/ymfpci/ymfpci_main.c	2003-05-16 13:27:27.000000000 -0700
@@ -1093,7 +1093,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI", device, 32, 1, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "1MFPCI", device, 32, 1, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm_free;
@@ -1103,7 +1103,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI");
+	strcpy(pcm->name, "2MFPCI");
 	chip->pcm = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1138,7 +1138,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI - AC'97", device, 0, 1, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "3MFPCI - AC'97", device, 0, 1, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm2_free;
@@ -1147,7 +1147,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI - AC'97");
+	strcpy(pcm->name, "4MFPCI - AC'97");
 	chip->pcm2 = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1182,7 +1182,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI - IEC958", device, 1, 0, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "5MFPCI - IEC958", device, 1, 0, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm_spdif_free;
@@ -1191,7 +1191,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI - IEC958");
+	strcpy(pcm->name, "6MFPCI - IEC958");
 	chip->pcm_spdif = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1226,7 +1226,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI - Rear", device, 1, 0, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "7MFPCI - Rear", device, 1, 0, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm_4ch_free;
@@ -1235,7 +1235,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI - Rear PCM");
+	strcpy(pcm->name, "8MFPCI - Rear PCM");
 	chip->pcm_4ch = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1831,7 +1831,7 @@ static void snd_ymfpci_proc_read(snd_inf
 {
 	// ymfpci_t *chip = snd_magic_cast(ymfpci_t, private_data, return);
 	
-	snd_iprintf(buffer, "YMFPCI\n\n");
+	snd_iprintf(buffer, "9MFPCI\n\n");
 }
 
 static int __devinit snd_ymfpci_proc_init(snd_card_t * card, ymfpci_t *chip)
@@ -2226,12 +2226,12 @@ int __devinit snd_ymfpci_create(snd_card
 	chip->reg_area_virt = (unsigned long)ioremap_nocache(chip->reg_area_phys, 0x8000);
 	pci_set_master(pci);
 
-	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "YMFPCI")) == NULL) {
+	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "AMFPCI")) == NULL) {
 		snd_ymfpci_free(chip);
 		snd_printk("unable to grab memory region 0x%lx-0x%lx\n", chip->reg_area_phys, chip->reg_area_phys + 0x8000 - 1);
 		return -EBUSY;
 	}
-	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "YMFPCI", (void *) chip)) {
+	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "BMFPCI", (void *) chip)) {
 		snd_ymfpci_free(chip);
 		snd_printk("unable to grab IRQ %d\n", pci->irq);
 		return -EBUSY;
diff -puN ./sound/pci/ymfpci/ymfpci.c~a ./sound/pci/ymfpci/ymfpci.c
--- 25/./sound/pci/ymfpci/ymfpci.c~a	2003-05-16 13:26:26.000000000 -0700
+++ 25-akpm/./sound/pci/ymfpci/ymfpci.c	2003-05-16 13:27:49.000000000 -0700
@@ -122,7 +122,7 @@ static int __devinit snd_card_ymfpci_pro
 			fm_port[dev] = addr;
 		}
 		if (fm_port[dev] >= 0 &&
-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
+		    (chip->fm_res = request_region(fm_port[dev], 4, "CMFPCI OPL3")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
 			pci_write_config_word(pci, PCIR_DSXG_FMBASE, fm_port[dev]);
 		}
@@ -133,7 +133,7 @@ static int __devinit snd_card_ymfpci_pro
 			mpu_port[dev] = addr;
 		}
 		if (mpu_port[dev] >= 0 &&
-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
+		    (chip->mpu_res = request_region(mpu_port[dev], 2, "DMFPCI MPU401")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);
 		}
@@ -146,7 +146,7 @@ static int __devinit snd_card_ymfpci_pro
 		default: fm_port[dev] = -1; break;
 		}
 		if (fm_port[dev] > 0 &&
-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
+		    (chip->fm_res = request_region(fm_port[dev], 4, "EMFPCI OPL3")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
 		} else {
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_FMIO;
@@ -160,7 +160,7 @@ static int __devinit snd_card_ymfpci_pro
 		default: mpu_port[dev] = -1; break;
 		}
 		if (mpu_port[dev] > 0 &&
-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
+		    (chip->mpu_res = request_region(mpu_port[dev], 2, "FMFPCI MPU401")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 		} else {
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_MPUIO;


--=-3aZO2qTleK+xSsZyECqh--

