Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132576AbRDOGFy>; Sun, 15 Apr 2001 02:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDOGFo>; Sun, 15 Apr 2001 02:05:44 -0400
Received: from venus.tis.com.ar ([63.69.231.252]:31734 "EHLO
	mercurio.ba.technisys.com.ar") by vger.kernel.org with ESMTP
	id <S132576AbRDOGF1>; Sun, 15 Apr 2001 02:05:27 -0400
Date: Sun, 15 Apr 2001 03:04:54 -0300
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.3: cat /proc/tty/driver/serial
Message-ID: <20010415030454.A6729@technisys.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
From: =?iso-8859-1?Q?Nicol=E1s_Lichtmaier?= <nick@technisys.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just looking around and I found this:

# cat /proc/tty/driver/serial
Segmentation fault

And this is the oops:

Unable to handle kernel paging request at virtual address d00eff1c
 printing eip:
d00eff1c
*pde = 01505067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d00eff1c>]
EFLAGS: 00010282
eax: c6ee3f98   ebx: caaea800   ecx: caaea820   edx: d00eff1c
esi: 00000400   edi: c6845000   ebp: 00000400   esp: c6ee3f60
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 15394, stackpage=c6ee3000)
Stack: c0145cca c6845000 c6ee3f98 00000000 00000400 c6ee3f94 d00f6dc0 caaea800 
       ffffffea 00000000 00000400 c15de220 00000000 00000000 00000000 c012c886 
       caaea800 0804cda8 00000400 caaea820 c6ee2000 00000400 0804cda8 bffff834 
Call Trace: [proc_file_read+242/404] [<d00f6dc0>] [sys_read+150/204] [system_call+51/56] 

Code:  Bad EIP value.

 Here's some info about my system:

# lsmod 
Module                  Size  Used by
cmpci                  21632   0 
soundcore               3888   4  [cmpci]
ne2k-pci                4480   1 
8390                    6144   0  [ne2k-pci]
# grep =y /boot/config-2.4.3 
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
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
CONFIG_PARPORT_1284=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_EUI64=y
CONFIG_IPV6_NO_PB=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_NET_PCI=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PSMOUSE=y
CONFIG_JOYSTICK=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_QUOTA=y
CONFIG_REISERFS_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD_V3=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
CONFIG_SOUND_CMPCI_4CH=y
CONFIG_MAGIC_SYSRQ=y
# cat /proc/version 
Linux version 2.4.3 (root@mazinger) (gcc version 2.95.4 20010319 (Debian prerelease)) #1 sáb abr 14 15:16:13 ART 2001
# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.132
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 999.42
# lspci   
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0f.1 Communication controller: C-Media Electronics Inc CM8738 (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev 2a)
