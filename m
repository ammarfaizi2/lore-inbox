Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWARH7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWARH7B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWARH7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:59:01 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:49419 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932370AbWARH7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:59:00 -0500
Date: Wed, 18 Jan 2006 08:59:36 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-Id: <20060118085936.4773dd77.khali@linux-fr.org>
In-Reply-To: <20060117232701.GA7606@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	<43CD67AE.9030501@eyal.emu.id.au>
	<20060117232701.GA7606@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, Eyal,

> > I am looking at a problem where the build seems to remove /dev/null,
> > which is then created as a regular file (naturally). This did not
> > happen before.
> > 
> > # ls -l /dev/null
> > crw-rw-rw-  1 root root 1, 3 Jan 18 08:42 /dev/null
> > # make distclean
> >   CLEAN   scripts/basic
> >   CLEAN   scripts/kconfig
> >   CLEAN   include/config
> >   CLEAN   .config .config.old include/asm include/linux/autoconf.h include/linux/version.h .kernelrelease
> > # ls -l /dev/null
> > -rwxr-xr-x  1 root root 47 Jan 18 08:42 /dev/null
> 
> Strange.
> I have tried to reproduce without luck...
> Can you please do above steps again with V=1 added like this:
> ls -l /dev/null
> make distclean V=1
> ls -l /dev/null

I just tried this on a freshly unpacked and configured (but not
compiled) 2.6.16-rc1, and I observe a similarly strange, though
different, behavior:

hyperion:/home/khali/src/linux-2.6.16-rc1 # ls -l /dev/null
crw-rw-rw-  1 root root 1, 3 2006-01-18 09:30 /dev/null
hyperion:/home/khali/src/linux-2.6.16-rc1 # make distclean V=1
make -f scripts/Makefile.clean obj=arch/x86_64/boot
make -f scripts/Makefile.clean obj=arch/x86_64/boot/compressed/
make -f scripts/Makefile.clean obj=/home/khali/src/linux-2.6.16-rc1
make -f scripts/Makefile.clean obj=arch/x86_64/crypto
make -f scripts/Makefile.clean obj=arch/x86_64/ia32
make -f scripts/Makefile.clean obj=arch/x86_64/kernel
make -f scripts/Makefile.clean obj=arch/x86_64/kernel/../../i386/kernel/cpu/mtrr
make -f scripts/Makefile.clean obj=arch/x86_64/kernel/acpi
make -f scripts/Makefile.clean obj=arch/x86_64/kernel/cpufreq
make -f scripts/Makefile.clean obj=arch/x86_64/lib
make -f scripts/Makefile.clean obj=arch/x86_64/mm
make -f scripts/Makefile.clean obj=arch/x86_64/oprofile
make -f scripts/Makefile.clean obj=arch/x86_64/pci
make -f scripts/Makefile.clean obj=block
make -f scripts/Makefile.clean obj=crypto
make -f scripts/Makefile.clean obj=drivers
make -f scripts/Makefile.clean obj=drivers/acpi
make -f scripts/Makefile.clean obj=drivers/acpi/dispatcher
make -f scripts/Makefile.clean obj=drivers/acpi/events
make -f scripts/Makefile.clean obj=drivers/acpi/executer
make -f scripts/Makefile.clean obj=drivers/acpi/hardware
make -f scripts/Makefile.clean obj=drivers/acpi/namespace
make -f scripts/Makefile.clean obj=drivers/acpi/parser
make -f scripts/Makefile.clean obj=drivers/acpi/resources
make -f scripts/Makefile.clean obj=drivers/acpi/sleep
make -f scripts/Makefile.clean obj=drivers/acpi/tables
make -f scripts/Makefile.clean obj=drivers/acpi/utilities
make -f scripts/Makefile.clean obj=drivers/amba
make -f scripts/Makefile.clean obj=drivers/atm
make -f scripts/Makefile.clean obj=drivers/base
make -f scripts/Makefile.clean obj=drivers/base/power
make -f scripts/Makefile.clean obj=drivers/block
make -f scripts/Makefile.clean obj=drivers/block/aoe
make -f scripts/Makefile.clean obj=drivers/block/paride
make -f scripts/Makefile.clean obj=drivers/bluetooth
make -f scripts/Makefile.clean obj=drivers/cdrom
make -f scripts/Makefile.clean obj=drivers/char
make -f scripts/Makefile.clean obj=drivers/char/agp
make -f scripts/Makefile.clean obj=drivers/char/drm
make -f scripts/Makefile.clean obj=drivers/char/ftape
make -f scripts/Makefile.clean obj=drivers/char/ftape/compressor
make -f scripts/Makefile.clean obj=drivers/char/ftape/lowlevel
make -f scripts/Makefile.clean obj=drivers/char/ftape/zftape
make -f scripts/Makefile.clean obj=drivers/char/ipmi
make -f scripts/Makefile.clean obj=drivers/char/mwave
make -f scripts/Makefile.clean obj=drivers/char/pcmcia
make -f scripts/Makefile.clean obj=drivers/char/rio
make -f scripts/Makefile.clean obj=drivers/char/tpm
make -f scripts/Makefile.clean obj=drivers/char/watchdog
make -f scripts/Makefile.clean obj=drivers/connector
make -f scripts/Makefile.clean obj=drivers/cpufreq
make -f scripts/Makefile.clean obj=drivers/crypto
make -f scripts/Makefile.clean obj=drivers/dio
make -f scripts/Makefile.clean obj=drivers/eisa
make -f scripts/Makefile.clean obj=drivers/fc4
make -f scripts/Makefile.clean obj=drivers/firmware
make -f scripts/Makefile.clean obj=drivers/hwmon
make -f scripts/Makefile.clean obj=drivers/i2c
make -f scripts/Makefile.clean obj=drivers/i2c/algos
make -f scripts/Makefile.clean obj=drivers/i2c/busses
make -f scripts/Makefile.clean obj=drivers/i2c/chips
make -f scripts/Makefile.clean obj=drivers/ide
make -f scripts/Makefile.clean obj=drivers/ide/arm
make -f scripts/Makefile.clean obj=drivers/ide/cris
make -f scripts/Makefile.clean obj=drivers/ide/legacy
make -f scripts/Makefile.clean obj=drivers/ide/mips
make -f scripts/Makefile.clean obj=drivers/ide/pci
make -f scripts/Makefile.clean obj=drivers/ieee1394
make -f scripts/Makefile.clean obj=drivers/infiniband
make -f scripts/Makefile.clean obj=drivers/infiniband/core
make -f scripts/Makefile.clean obj=drivers/infiniband/hw/mthca
make -f scripts/Makefile.clean obj=drivers/infiniband/ulp/ipoib
make -f scripts/Makefile.clean obj=drivers/infiniband/ulp/srp
make -f scripts/Makefile.clean obj=drivers/input
make -f scripts/Makefile.clean obj=drivers/input/joystick
make -f scripts/Makefile.clean obj=drivers/input/joystick/iforce
make -f scripts/Makefile.clean obj=drivers/input/keyboard
make -f scripts/Makefile.clean obj=drivers/input/misc
make -f scripts/Makefile.clean obj=drivers/input/mouse
make -f scripts/Makefile.clean obj=drivers/input/touchscreen
make -f scripts/Makefile.clean obj=drivers/input/gameport
make -f scripts/Makefile.clean obj=drivers/input/serio
make -f scripts/Makefile.clean obj=drivers/isdn
make -f scripts/Makefile.clean obj=drivers/isdn/act2000
make -f scripts/Makefile.clean obj=drivers/isdn/capi
make -f scripts/Makefile.clean obj=drivers/isdn/divert
make -f scripts/Makefile.clean obj=drivers/isdn/hardware
make -f scripts/Makefile.clean obj=drivers/isdn/hardware/avm
make -f scripts/Makefile.clean obj=drivers/isdn/hardware/eicon
make -f scripts/Makefile.clean obj=drivers/isdn/hisax
make -f scripts/Makefile.clean obj=drivers/isdn/hysdn
make -f scripts/Makefile.clean obj=drivers/isdn/i4l
make -f scripts/Makefile.clean obj=drivers/isdn/icn
make -f scripts/Makefile.clean obj=drivers/isdn/isdnloop
make -f scripts/Makefile.clean obj=drivers/isdn/pcbit
make -f scripts/Makefile.clean obj=drivers/isdn/sc
make -f scripts/Makefile.clean obj=drivers/macintosh
make -f scripts/Makefile.clean obj=drivers/mca
make -f scripts/Makefile.clean obj=drivers/md
make -f scripts/Makefile.clean obj=drivers/media
make -f scripts/Makefile.clean obj=drivers/media/common
make -f scripts/Makefile.clean obj=drivers/media/dvb
make -f scripts/Makefile.clean obj=drivers/media/dvb/b2c2
make -f scripts/Makefile.clean obj=drivers/media/dvb/bt8xx
make -f scripts/Makefile.clean obj=drivers/media/dvb/cinergyT2
make -f scripts/Makefile.clean obj=drivers/media/dvb/dvb-core
make -f scripts/Makefile.clean obj=drivers/media/dvb/dvb-usb
make -f scripts/Makefile.clean obj=drivers/media/dvb/frontends
make -f scripts/Makefile.clean obj=drivers/media/dvb/pluto2
make -f scripts/Makefile.clean obj=drivers/media/dvb/ttpci
make -f scripts/Makefile.clean obj=drivers/media/dvb/ttusb-budget
make -f scripts/Makefile.clean obj=drivers/media/dvb/ttusb-dec
make -f scripts/Makefile.clean obj=drivers/media/radio
make -f scripts/Makefile.clean obj=drivers/media/video
make -f scripts/Makefile.clean obj=drivers/media/video/cx25840
make -f scripts/Makefile.clean obj=drivers/media/video/cx88
make -f scripts/Makefile.clean obj=drivers/media/video/em28xx
make -f scripts/Makefile.clean obj=drivers/media/video/ovcamchip
make -f scripts/Makefile.clean obj=drivers/media/video/saa7134
make -f scripts/Makefile.clean obj=drivers/message
make -f scripts/Makefile.clean obj=drivers/message/fusion
make -f scripts/Makefile.clean obj=drivers/message/i2o
make -f scripts/Makefile.clean obj=drivers/mfd
make -f scripts/Makefile.clean obj=drivers/misc
make -f scripts/Makefile.clean obj=drivers/misc/hdpuftrs
make -f scripts/Makefile.clean obj=drivers/misc/ibmasm
make -f scripts/Makefile.clean obj=drivers/mmc
make -f scripts/Makefile.clean obj=drivers/mtd
make -f scripts/Makefile.clean obj=drivers/mtd/chips
make -f scripts/Makefile.clean obj=drivers/mtd/devices
make -f scripts/Makefile.clean obj=drivers/mtd/maps
make -f scripts/Makefile.clean obj=drivers/mtd/nand
make -f scripts/Makefile.clean obj=drivers/mtd/onenand
make -f scripts/Makefile.clean obj=drivers/net
make -f scripts/Makefile.clean obj=drivers/net/appletalk
make -f scripts/Makefile.clean obj=drivers/net/arcnet
make -f scripts/Makefile.clean obj=drivers/net/arm
make -f scripts/Makefile.clean obj=drivers/net/bonding
make -f scripts/Makefile.clean obj=drivers/net/chelsio
make -f scripts/Makefile.clean obj=drivers/net/cris
make -f scripts/Makefile.clean obj=drivers/net/e1000
make -f scripts/Makefile.clean obj=drivers/net/fec_8xx
make -f scripts/Makefile.clean obj=drivers/net/fs_enet
make -f scripts/Makefile.clean obj=drivers/net/hamradio
make -f scripts/Makefile.clean obj=drivers/net/ibm_emac
make -f scripts/Makefile.clean obj=drivers/net/irda
make -f scripts/Makefile.clean obj=drivers/net/ixgb
make -f scripts/Makefile.clean obj=drivers/net/ixp2000
make -f scripts/Makefile.clean obj=drivers/net/pcmcia
make -f scripts/Makefile.clean obj=drivers/net/phy
make -f scripts/Makefile.clean obj=drivers/net/sk98lin
make -f scripts/Makefile.clean obj=drivers/net/skfp
make -f scripts/Makefile.clean obj=drivers/net/tokenring
make -f scripts/Makefile.clean obj=drivers/net/tulip
make -f scripts/Makefile.clean obj=drivers/net/wan
make -f scripts/Makefile.clean obj=drivers/net/wan/lmc
make -f scripts/Makefile.clean obj=drivers/net/wireless
make -f scripts/Makefile.clean obj=drivers/net/wireless/hostap
make -f scripts/Makefile.clean obj=drivers/net/wireless/prism54
make -f scripts/Makefile.clean obj=drivers/nubus
make -f scripts/Makefile.clean obj=drivers/parisc
make -f scripts/Makefile.clean obj=drivers/parport
make -f scripts/Makefile.clean obj=drivers/pci
make -f scripts/Makefile.clean obj=drivers/pci/hotplug
make -f scripts/Makefile.clean obj=drivers/pci/pcie
make -f scripts/Makefile.clean obj=drivers/pcmcia
make -f scripts/Makefile.clean obj=drivers/pnp
make -f scripts/Makefile.clean obj=drivers/pnp/isapnp
make -f scripts/Makefile.clean obj=drivers/pnp/pnpacpi
make -f scripts/Makefile.clean obj=drivers/pnp/pnpbios
make -f scripts/Makefile.clean obj=drivers/rapidio
make -f scripts/Makefile.clean obj=drivers/rapidio/switches
make -f scripts/Makefile.clean obj=drivers/sbus
make -f scripts/Makefile.clean obj=drivers/sbus/char
make -f scripts/Makefile.clean obj=drivers/scsi
make -f scripts/Makefile.clean obj=drivers/scsi/aacraid
make -f scripts/Makefile.clean obj=drivers/scsi/aic7xxx
make -f scripts/Makefile.clean obj=drivers/scsi/aic7xxx/aicasm
make -f scripts/Makefile.clean obj=drivers/scsi/arm
make -f scripts/Makefile.clean obj=drivers/scsi/ibmvscsi
make -f scripts/Makefile.clean obj=drivers/scsi/lpfc
make -f scripts/Makefile.clean obj=drivers/scsi/megaraid
make -f scripts/Makefile.clean obj=drivers/scsi/pcmcia
make -f scripts/Makefile.clean obj=drivers/scsi/qla2xxx
make -f scripts/Makefile.clean obj=drivers/scsi/sym53c8xx_2
make -f scripts/Makefile.clean obj=drivers/serial
make -f scripts/Makefile.clean obj=drivers/serial/cpm_uart
make -f scripts/Makefile.clean obj=drivers/serial/jsm
make -f scripts/Makefile.clean obj=drivers/sh
make -f scripts/Makefile.clean obj=drivers/sh/superhyway
make -f scripts/Makefile.clean obj=drivers/sn
make -f scripts/Makefile.clean obj=drivers/spi
make -f scripts/Makefile.clean obj=drivers/tc
make -f scripts/Makefile.clean obj=drivers/telephony
make -f scripts/Makefile.clean obj=drivers/usb
make -f scripts/Makefile.clean obj=drivers/usb/atm
make -f scripts/Makefile.clean obj=drivers/usb/class
make -f scripts/Makefile.clean obj=drivers/usb/core
make -f scripts/Makefile.clean obj=drivers/usb/host
make -f scripts/Makefile.clean obj=drivers/usb/image
make -f scripts/Makefile.clean obj=drivers/usb/input
make -f scripts/Makefile.clean obj=drivers/usb/media
make -f scripts/Makefile.clean obj=drivers/usb/media/pwc
make -f scripts/Makefile.clean obj=drivers/usb/misc
make -f scripts/Makefile.clean obj=drivers/usb/misc/sisusbvga
make -f scripts/Makefile.clean obj=drivers/usb/mon
make -f scripts/Makefile.clean obj=drivers/usb/net
make -f scripts/Makefile.clean obj=drivers/usb/serial
make -f scripts/Makefile.clean obj=drivers/usb/storage
make -f scripts/Makefile.clean obj=drivers/usb/gadget
make -f scripts/Makefile.clean obj=drivers/video
make -f scripts/Makefile.clean obj=drivers/video/aty
make -f scripts/Makefile.clean obj=drivers/video/backlight
make -f scripts/Makefile.clean obj=drivers/video/console
make -f scripts/Makefile.clean obj=drivers/video/geode
make -f scripts/Makefile.clean obj=drivers/video/kyro
make -f scripts/Makefile.clean obj=drivers/video/logo
make -f scripts/Makefile.clean obj=drivers/video/matrox
make -f scripts/Makefile.clean obj=drivers/video/nvidia
make -f scripts/Makefile.clean obj=drivers/video/riva
make -f scripts/Makefile.clean obj=drivers/video/savage
make -f scripts/Makefile.clean obj=drivers/video/sis
make -f scripts/Makefile.clean obj=drivers/video/i810
make -f scripts/Makefile.clean obj=drivers/video/intelfb
make -f scripts/Makefile.clean obj=drivers/w1
make -f scripts/Makefile.clean obj=drivers/zorro
make -f scripts/Makefile.clean obj=fs
make -f scripts/Makefile.clean obj=fs/9p
make -f scripts/Makefile.clean obj=fs/adfs
make -f scripts/Makefile.clean obj=fs/affs
make -f scripts/Makefile.clean obj=fs/afs
make -f scripts/Makefile.clean obj=fs/autofs
make -f scripts/Makefile.clean obj=fs/autofs4
make -f scripts/Makefile.clean obj=fs/befs
make -f scripts/Makefile.clean obj=fs/bfs
make -f scripts/Makefile.clean obj=fs/cifs
make -f scripts/Makefile.clean obj=fs/coda
make -f scripts/Makefile.clean obj=fs/configfs
make -f scripts/Makefile.clean obj=fs/cramfs
make -f scripts/Makefile.clean obj=fs/debugfs
make -f scripts/Makefile.clean obj=fs/devfs
make -f scripts/Makefile.clean obj=fs/devpts
make -f scripts/Makefile.clean obj=fs/efs
make -f scripts/Makefile.clean obj=fs/exportfs
make -f scripts/Makefile.clean obj=fs/ext2
make -f scripts/Makefile.clean obj=fs/ext3
make -f scripts/Makefile.clean obj=fs/fat
make -f scripts/Makefile.clean obj=fs/freevxfs
make -f scripts/Makefile.clean obj=fs/fuse
make -f scripts/Makefile.clean obj=fs/hfs
make -f scripts/Makefile.clean obj=fs/hfsplus
make -f scripts/Makefile.clean obj=fs/hostfs
make -f scripts/Makefile.clean obj=fs/hpfs
make -f scripts/Makefile.clean obj=fs/hppfs
make -f scripts/Makefile.clean obj=fs/hugetlbfs
make -f scripts/Makefile.clean obj=fs/isofs
make -f scripts/Makefile.clean obj=fs/jbd
make -f scripts/Makefile.clean obj=fs/jffs
make -f scripts/Makefile.clean obj=fs/jffs2
make -f scripts/Makefile.clean obj=fs/jfs
make -f scripts/Makefile.clean obj=fs/lockd
make -f scripts/Makefile.clean obj=fs/minix
make -f scripts/Makefile.clean obj=fs/msdos
make -f scripts/Makefile.clean obj=fs/ncpfs
make -f scripts/Makefile.clean obj=fs/nfs
make -f scripts/Makefile.clean obj=fs/nfs_common
make -f scripts/Makefile.clean obj=fs/nfsd
make -f scripts/Makefile.clean obj=fs/nls
make -f scripts/Makefile.clean obj=fs/ntfs
make -f scripts/Makefile.clean obj=fs/ocfs2
make -f scripts/Makefile.clean obj=fs/ocfs2/cluster
make -f scripts/Makefile.clean obj=fs/ocfs2/dlm
make -f scripts/Makefile.clean obj=fs/openpromfs
make -f scripts/Makefile.clean obj=fs/partitions
make -f scripts/Makefile.clean obj=fs/proc
make -f scripts/Makefile.clean obj=fs/qnx4
make -f scripts/Makefile.clean obj=fs/ramfs
make -f scripts/Makefile.clean obj=fs/reiserfs
make -f scripts/Makefile.clean obj=fs/relayfs
make -f scripts/Makefile.clean obj=fs/romfs
make -f scripts/Makefile.clean obj=fs/smbfs
make -f scripts/Makefile.clean obj=fs/sysfs
make -f scripts/Makefile.clean obj=fs/sysv
make -f scripts/Makefile.clean obj=fs/udf
make -f scripts/Makefile.clean obj=fs/ufs
make -f scripts/Makefile.clean obj=fs/vfat
make -f scripts/Makefile.clean obj=fs/xfs
make -f scripts/Makefile.clean obj=init
make -f scripts/Makefile.clean obj=ipc
make -f scripts/Makefile.clean obj=kernel
make -f scripts/Makefile.clean obj=kernel/irq
make -f scripts/Makefile.clean obj=kernel/power
make -f scripts/Makefile.clean obj=lib
make -f scripts/Makefile.clean obj=lib/reed_solomon
make -f scripts/Makefile.clean obj=lib/zlib_deflate
make -f scripts/Makefile.clean obj=lib/zlib_inflate
make -f scripts/Makefile.clean obj=mm
make -f scripts/Makefile.clean obj=net
make -f scripts/Makefile.clean obj=net/802
make -f scripts/Makefile.clean obj=net/8021q
make -f scripts/Makefile.clean obj=net/appletalk
make -f scripts/Makefile.clean obj=net/atm
make -f scripts/Makefile.clean obj=net/ax25
make -f scripts/Makefile.clean obj=net/bluetooth
make -f scripts/Makefile.clean obj=net/bluetooth/bnep
make -f scripts/Makefile.clean obj=net/bluetooth/cmtp
make -f scripts/Makefile.clean obj=net/bluetooth/hidp
make -f scripts/Makefile.clean obj=net/bluetooth/rfcomm
make -f scripts/Makefile.clean obj=net/bridge
make -f scripts/Makefile.clean obj=net/bridge/netfilter
make -f scripts/Makefile.clean obj=net/core
make -f scripts/Makefile.clean obj=net/dccp
make -f scripts/Makefile.clean obj=net/dccp/ccids
make -f scripts/Makefile.clean obj=net/dccp/ccids/lib
make -f scripts/Makefile.clean obj=net/decnet
make -f scripts/Makefile.clean obj=net/decnet/netfilter
make -f scripts/Makefile.clean obj=net/econet
make -f scripts/Makefile.clean obj=net/ethernet
make -f scripts/Makefile.clean obj=net/ieee80211
make -f scripts/Makefile.clean obj=net/ipv4
make -f scripts/Makefile.clean obj=net/ipv4/ipvs
make -f scripts/Makefile.clean obj=net/ipv4/netfilter
make -f scripts/Makefile.clean obj=net/ipx
make -f scripts/Makefile.clean obj=net/irda
make -f scripts/Makefile.clean obj=net/irda/ircomm
make -f scripts/Makefile.clean obj=net/irda/irlan
make -f scripts/Makefile.clean obj=net/irda/irnet
make -f scripts/Makefile.clean obj=net/key
make -f scripts/Makefile.clean obj=net/lapb
make -f scripts/Makefile.clean obj=net/llc
make -f scripts/Makefile.clean obj=net/netfilter
make -f scripts/Makefile.clean obj=net/netlink
make -f scripts/Makefile.clean obj=net/netrom
make -f scripts/Makefile.clean obj=net/packet
make -f scripts/Makefile.clean obj=net/rose
make -f scripts/Makefile.clean obj=net/rxrpc
make -f scripts/Makefile.clean obj=net/sched
make -f scripts/Makefile.clean obj=net/sctp
make -f scripts/Makefile.clean obj=net/sunrpc
make -f scripts/Makefile.clean obj=net/sunrpc/auth_gss
make -f scripts/Makefile.clean obj=net/tipc
make -f scripts/Makefile.clean obj=net/unix
make -f scripts/Makefile.clean obj=net/wanrouter
make -f scripts/Makefile.clean obj=net/x25
make -f scripts/Makefile.clean obj=net/xfrm
make -f scripts/Makefile.clean obj=security
make -f scripts/Makefile.clean obj=security/keys
make -f scripts/Makefile.clean obj=security/selinux
make -f scripts/Makefile.clean obj=security/selinux/ss
make -f scripts/Makefile.clean obj=sound
make -f scripts/Makefile.clean obj=sound/arm
make -f scripts/Makefile.clean obj=sound/core
make -f scripts/Makefile.clean obj=sound/core/oss
make -f scripts/Makefile.clean obj=sound/core/seq
make -f scripts/Makefile.clean obj=sound/core/seq/instr
make -f scripts/Makefile.clean obj=sound/drivers
make -f scripts/Makefile.clean obj=sound/drivers/mpu401
make -f scripts/Makefile.clean obj=sound/drivers/opl3
make -f scripts/Makefile.clean obj=sound/drivers/opl4
make -f scripts/Makefile.clean obj=sound/drivers/vx
make -f scripts/Makefile.clean obj=sound/i2c
make -f scripts/Makefile.clean obj=sound/i2c/other
make -f scripts/Makefile.clean obj=sound/isa
make -f scripts/Makefile.clean obj=sound/isa/ad1816a
make -f scripts/Makefile.clean obj=sound/isa/ad1848
make -f scripts/Makefile.clean obj=sound/isa/cs423x
make -f scripts/Makefile.clean obj=sound/isa/es1688
make -f scripts/Makefile.clean obj=sound/isa/gus
make -f scripts/Makefile.clean obj=sound/isa/opti9xx
make -f scripts/Makefile.clean obj=sound/isa/sb
make -f scripts/Makefile.clean obj=sound/isa/wavefront
make -f scripts/Makefile.clean obj=sound/mips
make -f scripts/Makefile.clean obj=sound/oss
make -f scripts/Makefile.clean obj=sound/oss/cs4281
make -f scripts/Makefile.clean obj=sound/oss/dmasound
make -f scripts/Makefile.clean obj=sound/oss/emu10k1
make -f scripts/Makefile.clean obj=sound/parisc
make -f scripts/Makefile.clean obj=sound/pci
make -f scripts/Makefile.clean obj=sound/pci/ac97
make -f scripts/Makefile.clean obj=sound/pci/ali5451
make -f scripts/Makefile.clean obj=sound/pci/au88x0
make -f scripts/Makefile.clean obj=sound/pci/ca0106
make -f scripts/Makefile.clean obj=sound/pci/cs46xx
make -f scripts/Makefile.clean obj=sound/pci/cs5535audio
make -f scripts/Makefile.clean obj=sound/pci/emu10k1
make -f scripts/Makefile.clean obj=sound/pci/hda
make -f scripts/Makefile.clean obj=sound/pci/ice1712
make -f scripts/Makefile.clean obj=sound/pci/korg1212
make -f scripts/Makefile.clean obj=sound/pci/mixart
make -f scripts/Makefile.clean obj=sound/pci/nm256
make -f scripts/Makefile.clean obj=sound/pci/pcxhr
make -f scripts/Makefile.clean obj=sound/pci/rme9652
make -f scripts/Makefile.clean obj=sound/pci/trident
make -f scripts/Makefile.clean obj=sound/pci/vx222
make -f scripts/Makefile.clean obj=sound/pci/ymfpci
make -f scripts/Makefile.clean obj=sound/pcmcia
make -f scripts/Makefile.clean obj=sound/pcmcia/pdaudiocf
make -f scripts/Makefile.clean obj=sound/pcmcia/vx
make -f scripts/Makefile.clean obj=sound/ppc
make -f scripts/Makefile.clean obj=sound/sparc
make -f scripts/Makefile.clean obj=sound/synth
make -f scripts/Makefile.clean obj=sound/synth/emux
make -f scripts/Makefile.clean obj=sound/usb
make -f scripts/Makefile.clean obj=sound/usb/usx2y
make -f scripts/Makefile.clean obj=usr
  rm -rf .tmp_versions
  rm -f arch/x86_64/boot/fdimage arch/x86_64/boot/mtools.conf vmlinux System.map .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map
make -f scripts/Makefile.clean obj=Documentation/DocBook
make -f scripts/Makefile.clean obj=Documentation/DocBook/man/
make -f scripts/Makefile.clean obj=scripts
make -f scripts/Makefile.clean obj=scripts/basic
make -f scripts/Makefile.clean obj=scripts/genksyms
make -f scripts/Makefile.clean obj=scripts/kconfig
make -f scripts/Makefile.clean obj=scripts/kconfig/lxdialog
make -f scripts/Makefile.clean obj=scripts/mod
make -f scripts/Makefile.clean obj=scripts/package
  rm -rf
  rm -f
hyperion:/home/khali/src/linux-2.6.16-rc1 # ls -l /dev/null
crwxrwxrwx  1 root root 1, 3 2006-01-18 09:30 /dev/null
hyperion:/home/khali/src/linux-2.6.16-rc1 #

See the permissions change? I wonder what caused that.

The trace above is from a SuSE 10.0 on x86_64. Then I tried on my
laptop which has a Slackware 10.2 on i386, kernel had been built in the
directory, and result is the same:

root@arrakis:/home/khali/src/linux-2.6.16-rc1> ls -l /dev/null
crw-rw-rw-  1 root root 1, 3 2006-01-18 08:22 /dev/null
root@arrakis:/home/khali/src/linux-2.6.16-rc1> make distclean V=1
(...)
root@arrakis:/home/khali/src/linux-2.6.16-rc1> ls -l /dev/null
crwxrwxrwx  1 root root 1, 3 2006-01-18 08:22 /dev/null
root@arrakis:/home/khali/src/linux-2.6.16-rc1>

So there is something weird here, which seems to be rather
system-independent, although I can't explain why Eyal and I observe
different weirdnesses.

> Not a fix - but do not build as root....

I second Sam here - never build anything as root, kernel or anything
else. This is never needed and possibly dangerous.

-- 
Jean Delvare
