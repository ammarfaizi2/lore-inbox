Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131362AbRBOAuq>; Wed, 14 Feb 2001 19:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131893AbRBOAug>; Wed, 14 Feb 2001 19:50:36 -0500
Received: from dns2.chaven.com ([207.238.162.18]:28128 "EHLO shell.chaven.com")
	by vger.kernel.org with ESMTP id <S131362AbRBOAuZ>;
	Wed, 14 Feb 2001 19:50:25 -0500
Message-ID: <031001c096e9$2c437a60$160912ac@stcostlnds2zxj>
From: "List User" <lists@chaven.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010215002012.A21227@gamersgold.net>
Subject: NFS mounting delays w/ 2.4.x kernel?
Date: Wed, 14 Feb 2001 18:49:29 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've seen reference to this before (I think on this list) but didn't pay
attention to them
at the time.  I am now running into this problem myself.  I've just upgraded
one of my NFS
servers here from 2.2.17 -> 2.4.1 ).

I'm running the user-space server nfs-server-2.2beta48 (tried beta47 as
well).  Current
versions of mount, et al.  When booting I get the following errors:

---------------------------
Mounted devfs on /dev
Trying to unmount old root ... okay
Freeing unused kernel memory: 228k freed
Adding Swap: 1048568k swap-space (priority -1)
portmap: server localhost not responding, timed out
portmap: server localhost not responding, timed out
lockd_up: makesock failed, error=-5
portmap: server localhost not responding, timed out
-----------------------------

Which pauses the boot process by about 3 minutes.  Everything mounts fine
but there is
the pause.  Doing a tcpump I see:

18:34:39.445211 192.168.2.18.931 > 192.168.2.26.827: udp 60 (DF)
18:34:39.445428 192.168.2.26.829 > 192.168.2.18.111: udp 56 (DF)
18:34:39.446396 192.168.2.18.111 > 192.168.2.26.829: udp 28 (DF)
18:34:39.446764 192.168.2.26.2114226 > 192.168.2.18.2049: 96 getattr [|nfs]
(DF)
18:34:39.447682 192.168.2.18.2049 > 192.168.2.26.2114226: reply ok 96
getattr [|nfs] (DF)
18:34:39.447894 192.168.2.26.18891442 > 192.168.2.18.2049: 96 statfs [|nfs]
(DF)
18:34:39.448528 192.168.2.18.2049 > 192.168.2.26.18891442: reply ok 48
statfs [|nfs] (DF)

(192.168.2.18 - nfs exporter, 192.168.2.26 the system that was upgraded the
one trying to
mount the exported volume).

When I don't change anything but boot the older 2.2.17 kernel the system
starts right up.
I don't see anything that would be causing this.  Attached is the
configuration for the kernel I'm
running.   I use menuconfig to configure the system (if that makes a
difference) and compile
kernels monolithic.

Does anyone have any ideas?


--------------
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_DAC960=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_LVM=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_OMIT_FLASHPOINT=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_DE4X5=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_ISO9660_FS=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
--------------------



