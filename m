Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSJNWmp>; Mon, 14 Oct 2002 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJNWmp>; Mon, 14 Oct 2002 18:42:45 -0400
Received: from x154001.fttd-s.tudelft.nl ([145.94.154.1]:18436 "EHLO
	stereo.rotzorg.org") by vger.kernel.org with ESMTP
	id <S262248AbSJNWmi>; Mon, 14 Oct 2002 18:42:38 -0400
Date: Tue, 15 Oct 2002 00:48:29 +0200
To: linux-kernel@vger.kernel.org
Subject: Spontaneous reboot while booting && CONFIG_MOUSE
Message-ID: <20021014224829.GA16662@rotzorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: sgr@rotzorg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys and gals,

I encoutered a rather strange (and frustrating bug). I found that, while
booting a brand-new compiled 2.4.19 kernel, just after the PIIX and the
two recognised disks the computer rebooted. (and rebooted again... and
again -- until i found out.) I could see the following lines and then the
computer rebooted:

PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100%% native mode: will probe irqs later
ide0: BM-DMA at 0xf000-0xf007, BIOS settings : hda:DMA, hdb:DMA
ide1: BM-DMA at 0xf008-0xf00f, BIOS settings : hdc:DMA, hdd:pio

I've managed to track down the cause of the reboots: setting
CONFIG_MOUSE=m and CONFIG_PSMOUSE=y fixed the problem.

tuner:/usr/src/dotconfig# diff dotconfig-2.4.19-stoereo.1.9.working
dotconfig-2.4.19-stoereo.1.10.notworking 
590,594c590
< CONFIG_MOUSE=m
< CONFIG_PSMOUSE=y
< # CONFIG_82C710_MOUSE is not set
< # CONFIG_PC110_PAD is not set
< # CONFIG_MK712_MOUSE is not set
---
> # CONFIG_MOUSE is not set

i've included a copy of my dotconfig-2.4.19-stoereo.1.10.notworking at
the end of this message.

While setting or unsetting the mouse options doesn't matter much, i rather
have it off.

I've arrived at this by gradually adding options and removing others. If
somebody wants, i can experiment some more. Please CC me privately in
case you have comments, questions or answers as i do not read the
mailing list. (i read kernel cousins though.)

thanks i advance,
Sander

included copy of dotconfig-2.4.19-stoereo.1.10.notworking (filtered
comment and empty lines out:)
<SNIP>
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_M586MMX=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_NOHIGHMEM=y
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
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=m
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_ISA=y
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=m
CONFIG_PPP=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
</SNIP>
-- 
Sander		GNU Guru and Mainframe hacker
work http://www.consul.com
