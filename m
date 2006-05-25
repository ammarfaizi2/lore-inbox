Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWEYN7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWEYN7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWEYN7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:59:13 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:64421 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030187AbWEYN7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:59:12 -0400
Date: Thu, 25 May 2006 15:59:11 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.18 crash on HP DL585
Message-ID: <20060525135911.GC20917@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Yesterday I have tried to upgrade our quad-opteron HP DL585
(running 2.6.11.10 kernel) to a newer kernel (2.6.16.18, compiled on
Fedora Core 5 compilers). After ~12 hours of uptime the system has crashed.
I have managed to catch the attached messages on the serial console
(but I suspect these are not the first messages after the crash). There
is nothing meaningful in the system log file.

	The system has an ext3 volume on an internal HP CCISS array,
and all the other volumes are XFS over LVM2 on an external FC array
connected to QLogic 2312 HBA. The call trace contains ext3_* functions,
so I suspect it is related to writing to the Samba log files or something
like that (no files on ext3 are exported via Samba).

	I don't expect this report to be meaningful enough, but this is
a production server which I cannot reboot for testing too often :-(
I am sending this just in case somebody could see something obvious in it.
The 2.6.11.10 ran pretty stable on this box, and upgrades to newer kernel
brought various new problems which forced me to stay with the older kernel.

	I am attaching also a kernel config and a lspci output.

-Yenya

BUG: soft lockup detected on CPU#2!
CPU 2:
Modules linked in:
Pid: 29680, comm: smbd Not tainted 2.6.16.18-fc5 #4
RIP: 0010:[<ffffffff803a4a81>] <ffffffff803a4a81>{.text.lock.spinlock+5}
RSP: 0018:ffff8105bf13fb10  EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000000500 RCX: 0000000000001000
RDX: 0000000000000000 RSI: ffff8104f835ea28 RDI: ffff81020721d75c
RBP: ffff8104f835ea28 R08: ffff8105bf13fc38 R09: 0000000000001000
R10: ffff810407348040 R11: 0000000000000246 R12: ffffffff801a40da
R13: 00000000000009de R14: ffff8104e05c1d98 R15: ffff8101ff82ac00
FS:  00002b5ab3d8bd80(0000) GS:ffff8104070b66c0(0000) knlGS:00000000f7db44c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000053450c CR3: 000000053effe000 CR4: 00000000000006e0

Call Trace: <ffffffff801b2f4d>{do_get_write_access+1064}
       <ffffffff80167807>{__getblk+29} <ffffffff801b304d>{journal_get_write_access+34}
       <ffffffff801a405a>{ext3_reserve_inode_write+56} <ffffffff801a40c8>{ext3_mark_inode_dirty+22}
       <ffffffff801a6b60>{ext3_dirty_inode+99} <ffffffff801841fc>{__mark_inode_dirty+41}
       <ffffffff80146b14>{__generic_file_aio_write_nolock+665}
       <ffffffff8031d952>{do_sock_read+152} <ffffffff80146faf>{generic_file_aio_write+101}
       <ffffffff801a259e>{ext3_file_write+22} <ffffffff8016575a>{do_sync_write+199}
       <ffffffff8013ad42>{autoremove_wake_function+0} <ffffffff80165fc4>{vfs_write+173}
       <ffffffff8016655b>{sys_write+69} <ffffffff8010a936>{system_call+126}
BUG: soft lockup detected on CPU#2!
CPU 2:
Modules linked in:
Pid: 29680, comm: smbd Not tainted 2.6.16.18-fc5 #4
RIP: 0010:[<ffffffff803a4a81>] <ffffffff803a4a81>{.text.lock.spinlock+5}
RSP: 0018:ffff8105bf13fb10  EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000000500 RCX: 0000000000001000
RDX: 0000000000000000 RSI: ffff8104f835ea28 RDI: ffff81020721d75c
RBP: ffff8104f835ea28 R08: ffff8105bf13fc38 R09: 0000000000001000
R10: ffff810407348040 R11: 0000000000000246 R12: ffffffff801a40da
R13: 00000000000009de R14: ffff8104e05c1d98 R15: ffff8101ff82ac00
FS:  00002b5ab3d8bd80(0000) GS:ffff8104070b66c0(0000) knlGS:00000000f7db44c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000053450c CR3: 000000053effe000 CR4: 00000000000006e0

Call Trace: <ffffffff801b2f4d>{do_get_write_access+1064}
       <ffffffff80167807>{__getblk+29} <ffffffff801b304d>{journal_get_write_access+34}
       <ffffffff801a405a>{ext3_reserve_inode_write+56} <ffffffff801a40c8>{ext3_mark_inode_dirty+22}
       <ffffffff801a6b60>{ext3_dirty_inode+99} <ffffffff801841fc>{__mark_inode_dirty+41}
       <ffffffff80146b14>{__generic_file_aio_write_nolock+665}
       <ffffffff8031d952>{do_sock_read+152} <ffffffff80146faf>{generic_file_aio_write+101}
       <ffffffff801a259e>{ext3_file_write+22} <ffffffff8016575a>{do_sync_write+199}
       <ffffffff8013ad42>{autoremove_wake_function+0} <ffffffff80165fc4>{vfs_write+173}
       <ffffffff8016655b>{sys_write+69} <ffffffff8010a936>{system_call+126}
BUG: soft lockup detected on CPU#2!
CPU 2:
Modules linked in:
Pid: 29680, comm: smbd Not tainted 2.6.16.18-fc5 #4
RIP: 0010:[<ffffffff803a4a7c>] <ffffffff803a4a7c>{.text.lock.spinlock+0}
RSP: 0018:ffff8105bf13fb10  EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000000500 RCX: 0000000000001000
RDX: 0000000000000000 RSI: ffff8104f835ea28 RDI: ffff81020721d75c
RBP: ffff8104f835ea28 R08: ffff8105bf13fc38 R09: 0000000000001000
R10: ffff810407348040 R11: 0000000000000246 R12: ffffffff801a40da
R13: 00000000000009de R14: ffff8104e05c1d98 R15: ffff8101ff82ac00
FS:  00002b5ab3d8bd80(0000) GS:ffff8104070b66c0(0000) knlGS:00000000f7db44c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000053450c CR3: 000000053effe000 CR4: 00000000000006e0

Call Trace: <ffffffff801b2f4d>{do_get_write_access+1064}
       <ffffffff80167807>{__getblk+29} <ffffffff801b304d>{journal_get_write_access+34}
       <ffffffff801a405a>{ext3_reserve_inode_write+56} <ffffffff801a40c8>{ext3_mark_inode_dirty+22}
       <ffffffff801a6b60>{ext3_dirty_inode+99} <ffffffff801841fc>{__mark_inode_dirty+41}
       <ffffffff80146b14>{__generic_file_aio_write_nolock+665}
       <ffffffff8031d952>{do_sock_read+152} <ffffffff80146faf>{generic_file_aio_write+101}
       <ffffffff801a259e>{ext3_file_write+22} <ffffffff8016575a>{do_sync_write+199}
       <ffffffff8013ad42>{autoremove_wake_function+0} <ffffffff80165fc4>{vfs_write+173}
       <ffffffff8016655b>{sys_write+69} <ffffffff8010a936>{system_call+126}

[...]

$ egrep -v '^#|^$' //usr/src/linux-2.6.16.18/.config 
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION="-rhel3"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_STOP_MACHINE=y
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_X86_PC=y
CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT_NONE=y
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_DISCONTIGMEM_MANUAL=y
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=4
CONFIG_HPET_TIMER=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_AMD=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_HZ_100=y
CONFIG_HZ=100
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=m
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_FIB_HASH=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_IPV6=y
CONFIG_NET_PKTGEN=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_BLK_CPQ_CISS_DA=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_UB=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_QLA_FC=y
CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE=y
CONFIG_SCSI_QLA2300=y
CONFIG_SCSI_QLA2322=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=m
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_TIGON3=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_STORAGE=m
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_EXPORT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=852
CONFIG_FAT_DEFAULT_IOCHARSET="utf-8"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
CONFIG_CIFS=m
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf-8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_DES=y
CONFIG_CRC32=y

# /sbin/lspci
00:03.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:04.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:04.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:04.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:07.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:07.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
00:08.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:08.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:02.0 System peripheral: Compaq Computer Corporation Integrated Lights Out Controller (rev 01)
01:02.2 System peripheral: Compaq Computer Corporation Integrated Lights Out  Processor (rev 01)
01:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:04.0 RAID bus controller: Compaq Computer Corporation Smart Array 5i/532 (rev 01)
02:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
02:06.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 10)
04:09.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
04:09.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
04:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
04:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
04:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
04:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
04:0c.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
04:0c.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
06:0e.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
