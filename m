Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTDOVxW (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTDOVxW 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:53:22 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:9981 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S264095AbTDOVxL 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:53:11 -0400
Date: Wed, 16 Apr 2003 00:05:01 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard
 freeze ( lockup on CPU0)
Message-Id: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.5.67-mm3 froze up after few hours of uptime.

The log captured through the serial console wih nmi_watchdog=1 can be found here:

http://www.philou.org/2.5.67-mm3/2.5.67-mm3.log

The decoded oops can be found here ( hope it gives someone a hint as its looks rather
odd to me)

http://www.philou.org/2.5.67-mm3/ksymoops-2.5.67-mm3

Below is my .config. System is a DELL 530 MT workstation SMP 1.5 GHz Xeons, 512Mo RAM
running Debian unstable. Booted with elevator=as. Plain 2.5.67-mm3 , no other patch applied.
Modules init tools : 0.9.10.

Grub boot parameters are:

kernel /boot/vmlinuz-2.5.67-mm3 root=/dev/sda2 console=tty1 console=ttyS1,9600n8 elevator=as nmi_watchdog=1

Unlike several previous hard freezes since at least 2.5.65, i was still able to ping the machine
but except that it was completely stuck. Sys-rq didn't work.

I have to say that i tried IEEE1394 from shipped kernel and as it didn't work with my DV Camcorder
i tried with the latest SVN checkout still without success ( which correspond to the 2 batch of
IEEE1394 messages)
(used IEEE1394 as modules)

Hard freeze occurred almost half an hour after i rmmod'ed the IEEE1394 modules.

Thanks,

Philippe

/proc/modules output

emu10k1 58560 0 - Live 0xe0ad6000
ac97_codec 13600 1 emu10k1, Live 0xe0abc000
soundcore 7200 1 emu10k1, Live 0xe0a85000
hid 22816 0 - Live 0xe0a94000
uhci_hcd 28744 0 - Live 0xe0a8b000
usbcore 95252 4 hid,uhci_hcd, Live 0xe0a9d000


CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_EXPERIMENTAL=y

CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

CONFIG_X86_BIGSMP=y
CONFIG_MPENTIUMIII=y
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
CONFIG_X86_PREFETCH=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=2
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_1GB=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y

CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y


CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y


CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDECD=y


CONFIG_SCSI=y

CONFIG_BLK_DEV_SD=y

CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_AIC7XXX_DEBUG_MASK=0

CONFIG_IEEE1394=m

CONFIG_IEEE1394_OUI_DB=y


CONFIG_IEEE1394_OHCI1394=m

CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m


CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
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
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m

CONFIG_IPV6_SCTP__=y

CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

CONFIG_NETDEVICES=y

CONFIG_NET_ETHERNET=y
CONFIG_MII=y

CONFIG_NET_PCI=y
CONFIG_E100=y

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200

CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y

CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y

CONFIG_RTC=y

CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_FS_POSIX_ACL=y

CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y

CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

CONFIG_CRAMFS=y

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SMB_FS=y

CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

CONFIG_SOUND=m

CONFIG_SOUND_PRIME=m
CONFIG_SOUND_EMU10K1=m

CONFIG_USB=m

CONFIG_USB_DEVICEFS=y

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m


CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y


CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y

CONFIG_ZLIB_INFLATE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y

$ lspci -v

00:00.0 Host bridge: Intel Corp. 82860 860 (Wombat) Chipset Host Bridge (MCH) (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff

00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe100000-fe4fffff

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: e8000000-e9ffffff
                                
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
        Flags: bus master, medium devsel, latency 0
                                
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) (prog-if 80 [Master])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, medium devsel, latency 0
        I/O ports at ffa0 [size=16]
                                
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at ff80 [size=32]
                                
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: medium devsel, IRQ 17
        I/O ports at ccd0 [size=16]
                                
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, medium devsel, latency 0, IRQ 23
        I/O ports at ff60 [size=32]
                                
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at c800 [size=256]
        I/O ports at cc40 [size=64]
                                
01:00.0 VGA compatible controller: nVidia Corporation NV10DDR [GeForce 256 DDR] (rev 10) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 0014
        Flags: 66Mhz, medium devsel, IRQ 16
        Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at c1000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0
                                
02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe200000-fe4fffff
                                
03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corp. 82806AA PCI64 Hub APIC
        Flags: fast devsel      
        Memory at fe3ff000 (32-bit, non-prefetchable) [disabled] [size=4K]

03:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 20
        Memory at fe3fe000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ecc0 [size=64]
        Memory at fe200000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fe400000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

03:0e.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 22
        BIST result: 00
        I/O ports at e800 [disabled] [size=256]
        Memory at fe3fd000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe400000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

04:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link) (prog-if 10 [OHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at fbeff800 (32-bit, non-prefetchable) [size=2K]
        Memory at fbef8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1

04:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs CT4780 SBLive! Value
        Flags: bus master, medium devsel, latency 64, IRQ 18
        I/O ports at dce0 [size=32]
        Capabilities: [dc] Power Management version 1

04:0e.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 64
        I/O ports at dcd8 [size=8]
        Capabilities: [dc] Power Management version 1

04:0f.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta LT] (rev 15) (prog-if 00 [VGA])
        Subsystem: Creative Labs: Unknown device 1039
        Flags: 66Mhz, medium devsel, IRQ 19
        Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
