Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278509AbRKRTRB>; Sun, 18 Nov 2001 14:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKRTQw>; Sun, 18 Nov 2001 14:16:52 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:44554 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S278509AbRKRTQq>; Sun, 18 Nov 2001 14:16:46 -0500
Date: Sun, 18 Nov 2001 20:10:20 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        george anzinger <george@mvista.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [Patch] enable uptime display > 497 days
Message-ID: <20011118201020.A7240@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <Pine.LNX.4.30.0111111803120.11130-100000@gans.physik3.uni-rostock.de> <Pine.LNX.4.30.0111181251330.6257-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0111181251330.6257-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 12:57:01PM +0100, Tim Schmielau wrote:
> [new patch further down]
> 
> I extended the patch to use a counter for periodically checking for
> jiffies overflows, so none can go undetected anymore. Still the CPU time
> overhead is minimal as timer are implemented rather efficiently
> 
I tried it, but it wouldn't apply cleanly (something in arch/arm
clashed). That didn't look too worrying, but compilation also failed:

make[1]: Leaving directory `/usr/src/linux-2.4.15pre6/arch/alpha/math-emu'
ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/alpha/kernel/kernel.o arch/alpha/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/math-emu.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.
o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/usb/u
sbdrv.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux-2.4.15pre6/arch/alpha/lib/lib.a /usr/src/linux-2.4.15pre6/lib/lib.a /usr/src/linux-2.4.15pre6/arch/alpha/lib/l
ib.a \
        --end-group \
        -o vmlinux
kernel/kernel.o: In function `do_fork':
kernel/kernel.o(.text+0x3168): undefined reference to `get_jiffies64'
kernel/kernel.o(.text+0x316c): undefined reference to `get_jiffies64'
kernel/kernel.o: In function `sys_sysinfo':
kernel/kernel.o(.text+0x9c7c): undefined reference to `get_jiffies64'
kernel/kernel.o(.text+0x9c80): undefined reference to `get_jiffies64'
mm/mm.o: In function `badness':
mm/mm.o(.text+0x148b8): undefined reference to `get_jiffies64'
mm/mm.o(.text+0x148bc): more undefined references to `get_jiffies64' follow
make: *** [vmlinux] Error 1
alpha:/usr/src/linux#

This is on an Alpha, .config below.

Good luck,
Jurriaan

CONFIG_ALPHA=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_ALPHA_MIATA=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_PCI=y
CONFIG_ALPHA_EV5=y
CONFIG_ALPHA_CIA=y
CONFIG_ALPHA_PYXIS=y
CONFIG_ALPHA_SRM=y
CONFIG_PCI_NAMES=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID5=y
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_DE4X5=y
CONFIG_YELLOWFIN=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_OSF_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_PCI_CONSOLE=y
CONFIG_SOUND=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=y
CONFIG_USB_STORAGE=y
CONFIG_USB_SCANNER=y
CONFIG_MATHEMU=y
CONFIG_MAGIC_SYSRQ=y
-- 
I am the burned out bulb you can not reach
	Darkwing Duck
GNU/Linux 2.4.15-pre6 on Debian/Alpha 64-bits 988 bogomips load:2.54 1.76 0.82
