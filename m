Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291259AbSAaUFR>; Thu, 31 Jan 2002 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291261AbSAaUFJ>; Thu, 31 Jan 2002 15:05:09 -0500
Received: from port29.ds1-rdo.adsl.cybercity.dk ([212.242.196.94]:39724 "EHLO
	xyzzy.adsl.dk") by vger.kernel.org with ESMTP id <S291259AbSAaUEz>;
	Thu, 31 Jan 2002 15:04:55 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre7: Problems linking fs/fs.o
X-Home-Page: http://peter.makholm.net/
Xyzzy: Nothing happens!
From: Peter Makholm <peter@makholm.net>
Date: Thu, 31 Jan 2002 21:04:45 +0100
Message-ID: <87r8o6478i.fsf@xyzzy.adsl.dk>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to compile kernel 2.4.18-pre7 on i386 it errors when it's
trying to link with fs/fs.o:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o drivers/video/video.o drivers/i2c/i2c.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
fs/fs.o: In function `generic_cont_expand':
fs/fs.o(.text+0x41cb): undefined reference to `page_cache_release'
fs/fs.o: In function `cont_prepare_write':
fs/fs.o(.text+0x42cb): undefined reference to `page_cache_release'
fs/fs.o(.text+0x43b5): undefined reference to `page_cache_release'
fs/fs.o: In function `block_truncate_page':
fs/fs.o(.text+0x461e): undefined reference to `page_cache_release'
fs/fs.o: In function `block_symlink':
fs/fs.o(.text+0x4e1b): undefined reference to `page_cache_release'
fs/fs.o(.text+0x4e4f): more undefined references to `page_cache_release' follow
make: *** [vmlinux] Error 1
xyzzy% 

Kernel 2.4.17 compiles just fine with the same configuration. I'm
using Debian Testing, it is the same problems we previously
experienced with a too new binutils?


'grep "^CONFIG" .config' gives the following:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_I82365=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_CMBATT=y
CONFIG_ACPI_THERMAL=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IPV6=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_PROC=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_NET_RADIO=y
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_PCMCIA_HERMES=m
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=m
CONFIG_IRDA=m
CONFIG_INPUT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y
CONFIG_AGP_AMD=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_G450=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SOUND_BT878=y
CONFIG_SOUND_ES1371=y
CONFIG_SOUND_TVMIXER=y
CONFIG_USB=m
CONFIG_USB_UHCI=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y


-- 
Når folk spørger mig, om jeg er nørd, bliver jeg altid ilde til mode
og svarer lidt undskyldende: "Nej, jeg bruger RedHat".
                                -- Allan Olesen på dk.edb.system.unix
