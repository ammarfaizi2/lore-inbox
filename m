Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTKJNr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTKJNr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:47:59 -0500
Received: from smtp.irisa.fr ([131.254.130.26]:28360 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S263506AbTKJNrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:47:49 -0500
Message-ID: <3FAFA5B2.9030103@free.fr>
Date: Mon, 10 Nov 2003 14:50:26 +0000
From: shal <shal@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.6.0-test9-bk13]kernel BUG at mm/slab.c:1696!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I report a kernel error in my syslog.

It appared when I use mozilla-1.4.1 for do big download.

I am on a slackware current with 2.6.0-tesç-bk13 kernel.

# gcc -v
Reading specs from /usr/lib/gcc-lib/i486-slackware-linux/3.2.3/specs
Configured with: ../gcc-3.2.3/configure --prefix=/usr --enable-shared 
--enable-threads=posix --enable-__cxa_atexit --disable-checking 
--with-gnu-ld --verbose --target=i486-slackware-linux 
--host=i486-slackware-linux
Thread model: posix
gcc version 3.2.3


# lspci (with a 2.4.22-ac4)
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP]
00:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 23)
00:08.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0a.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee 
(rev 03)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)







Nov  9 16:11:20 shal kernel: slab error in cache_free_debugcheck(): 
cache `size-2048': double free, or memor
y outside object was overwritten
Nov  9 16:11:20 shal kernel: Call Trace:
Nov  9 16:11:20 shal kernel:  [<c0156762>] kfree+0x2f2/0x420
Nov  9 16:11:20 shal kernel:  [<c037a884>] kfree_skbmem+0x14/0x30
Nov  9 16:11:20 shal kernel:  [<c037a884>] kfree_skbmem+0x14/0x30
Nov  9 16:11:20 shal kernel:  [<c037a920>] __kfree_skb+0x80/0x100
Nov  9 16:11:20 shal kernel:  [<c03a72f2>] tcp_recvmsg+0xbd2/0xf10
Nov  9 16:11:20 shal kernel:  [<c03cdb64>] inet_recvmsg+0x54/0x70
Nov  9 16:11:20 shal kernel:  [<c0375e29>] sock_recvmsg+0x99/0xc0
Nov  9 16:11:20 shal kernel:  [<c031f7a8>] serio_interrupt+0x58/0x60
Nov  9 16:11:20 shal kernel:  [<c014fd09>] buffered_rmqueue+0xc9/0x280
Nov  9 16:11:20 shal kernel:  [<c0375b3a>] sockfd_lookup+0x1a/0x70
Nov  9 16:11:20 shal kernel:  [<c0377824>] sys_recvfrom+0x94/0xf0
Nov  9 16:11:20 shal kernel:  [<c011f3e8>] kernel_map_pages+0x28/0x80
Nov  9 16:11:20 shal kernel:  [<c03778b6>] sys_recv+0x36/0x40
Nov  9 16:11:20 shal kernel:  [<c0378140>] sys_socketcall+0x190/0x2a0
Nov  9 16:11:20 shal kernel:  [<c010b26b>] syscall_call+0x7/0xb
Nov  9 16:11:20 shal kernel:
Nov  9 16:11:20 shal kernel: c780601e: redzone 1: 0x5a5a5a5a, redzone 2: 
0x0.
Nov  9 16:11:20 shal kernel: ------------[ cut here ]------------
Nov  9 16:11:20 shal kernel: kernel BUG at mm/slab.c:1696!
Nov  9 16:11:20 shal kernel: invalid operand: 0000 [#2]
Nov  9 16:11:20 shal kernel: CPU:    0
Nov  9 16:11:20 shal kernel: EIP:    0060:[<c01566f9>]    Not tainted
Nov  9 16:11:20 shal kernel: EFLAGS: 00010006
Nov  9 16:11:20 shal kernel: EIP is at kfree+0x289/0x420
Nov  9 16:11:20 shal kernel: eax: c7806000   ebx: 80010c00   ecx: 
00001000   edx: 0000001e
Nov  9 16:11:20 shal kernel: esi: cffefb00   edi: c7806000   ebp: 
ce903cf8   esp: ce903cc8
Nov  9 16:11:20 shal kernel: ds: 007b   es: 007b   ss: 0068
Nov  9 16:11:20 shal kernel: Process mozilla-bin (pid: 9665, 
threadinfo=ce902000 task=ce816960)
Nov  9 16:11:20 shal kernel: Stack: cffefb00 c780601e 5a5a5a5a 00000000 
0780601e c037a884 c780601e cffe8f78
Nov  9 16:11:20 shal kernel:        00000282 c7936f54 00000000 0479653e 
ce903d0c c037a884 c7806816 00000000
Nov  9 16:11:20 shal kernel:        00000000 ce903d24 c037a920 c7936f54 
c7936f54 00000000 c7936f54 ce903d88
Nov  9 16:11:20 shal kernel: Call Trace:
Nov  9 16:11:20 shal kernel:  [<c037a884>] kfree_skbmem+0x14/0x30
Nov  9 16:11:20 shal kernel:  [<c037a884>] kfree_skbmem+0x14/0x30
Nov  9 16:11:20 shal kernel:  [<c037a920>] __kfree_skb+0x80/0x100
Nov  9 16:11:20 shal kernel:  [<c03a72f2>] tcp_recvmsg+0xbd2/0xf10
Nov  9 16:11:20 shal kernel:  [<c03cdb64>] inet_recvmsg+0x54/0x70
Nov  9 16:11:20 shal kernel:  [<c0375e29>] sock_recvmsg+0x99/0xc0
Nov  9 16:11:20 shal kernel:  [<c031f7a8>] serio_interrupt+0x58/0x60
Nov  9 16:11:20 shal kernel:  [<c014fd09>] buffered_rmqueue+0xc9/0x280
Nov  9 16:11:20 shal kernel:  [<c0375b3a>] sockfd_lookup+0x1a/0x70
Nov  9 16:11:20 shal kernel:  [<c0377824>] sys_recvfrom+0x94/0xf0
Nov  9 16:11:20 shal kernel:  [<c011f3e8>] kernel_map_pages+0x28/0x80
Nov  9 16:11:21 shal kernel:  [<c03778b6>] sys_recv+0x36/0x40
Nov  9 16:11:21 shal kernel:  [<c0378140>] sys_socketcall+0x190/0x2a0
Nov  9 16:11:21 shal kernel:  [<c010b26b>] syscall_call+0x7/0xb
Nov  9 16:11:21 shal kernel:
Nov  9 16:11:21 shal kernel: Code: 0f 0b a0 06 73 52 41 c0 e9 d9 fe ff 
ff 0f 0b 9f 06 73 52 41
Nov  9 16:11:21 shal kernel:  bttv0: skipped frame. no signal? high irq 
latency?







# cat  .config | grep -v "not set" | grep "="
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_VIA686A=m
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_FB=y
CONFIG_FB_3DFX=m
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_ENS1371=m
CONFIG_SND_INTEL8X0=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_AUDIO=m
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_PWC=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y







