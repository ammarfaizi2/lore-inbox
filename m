Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKQNWA>; Fri, 17 Nov 2000 08:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbQKQNVu>; Fri, 17 Nov 2000 08:21:50 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:26479
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129097AbQKQNVs>; Fri, 17 Nov 2000 08:21:48 -0500
Date: Fri, 17 Nov 2000 14:49:38 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Reproducable oops in 2.2.17 and 2.2.18pre21
Message-ID: <20001117144938.F12733@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I get an oops reproducably with 2.2.17 and 2.2.18pre21 on a stock RH 6.2
system. I cannot trigger it with the RH supplied kernel (2.2.14-5.0).
I also got it with 2.2.17pre10 which prompted me to upgrade the kernel.
I initially suspected bad RAM but have exchanged the RAM with memtest86'ed
RAM for no improvement.

What I do: I try to back the system up with tar zcvf /var/backup.tar.gz 
-X exclude /lib /sbin /var /bin /etc /boot /home /root /usr
(the exclude file contains the path of the file itself, i.e., 
/var/ backup.tar.gz).

Running 2.2.17 I got the following oops during the backup, i.e., tar
had not finished yet (the exact place in the backup process varies):


ksymoops 0.7c on i586 2.2.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Nov 13 18:15:05 firewall kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004 
Nov 13 18:15:05 firewall kernel: current->tss.cr3 = 07259000, %cr3 = 07259000 
Nov 13 18:15:05 firewall kernel: *pde = 00000000 
Nov 13 18:15:05 firewall kernel: Oops: 0002 
Nov 13 18:15:05 firewall kernel: CPU:    0 
Nov 13 18:15:05 firewall kernel: EIP:    0010:[<c0121b43>] 
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 13 18:15:05 firewall kernel: EFLAGS: 00010087 
Nov 13 18:15:05 firewall kernel: eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000 
Nov 13 18:15:05 firewall kernel: esi: c02009f0   edi: 00001000   ebp: c022a790   esp: c725bd4c 
Nov 13 18:15:05 firewall kernel: ds: 0018   es: 0018   ss: 0018 
Nov 13 18:15:05 firewall kernel: Process bzip2 (pid: 1327, process nr: 23, stackpage=c725b000) 
Nov 13 18:15:05 firewall kernel: Stack: 00001000 00000306 00000001 0000000a 00000202 00000000 00000306 000016cf  
Nov 13 18:15:05 firewall kernel:        00001000 c0126ff4 00000003 00000000 00001000 00000306 00000002 c10fd3c0  
Nov 13 18:15:05 firewall kernel:        c06c1000 c01261e8 00001000 000016cf 00001000 00000306 00000002 c10fd3c0  
Nov 13 18:15:05 firewall kernel: Call Trace: [<c0126ff4>] [<c01261e8>] [<c01263c5>] [<c0125f01>] [<c013f74c>] [<c013fdc2>] [<c014011b>]  
Nov 13 18:15:05 firewall kernel:        [<c01264ff>] [<c013e23e>] [<c011130e>] [<c011ae20>] [<c011157e>] [<c0111573>] [<c010a103>] [<c01249cf>]  
Nov 13 18:15:05 firewall kernel:        [<c012483c>] [<c010923d>] [<c0109104>]  
Nov 13 18:15:05 firewall kernel: Code: 89 70 04 89 e8 2b 05 ec da 1d c0 8d 04 40 89 c2 c1 e2 04 01  

>>EIP; c0121b43 <__get_free_pages+1eb/2b8>   <=====
Trace; c0126ff4 <grow_buffers+40/f8>
Trace; c01261e8 <refill_freelist+10/44>
Trace; c01263c5 <getblk+139/164>
Trace; c0125f01 <get_hash_table+1d/2c>
Trace; c013f74c <ext2_alloc_block+74/178>
Trace; c013fdc2 <block_getblk+156/2a0>
Trace; c014011b <ext2_getblk+20f/21c>
Trace; c01264ff <__brelse+13/64>
Trace; c013e23e <ext2_file_write+226/5bc>
Trace; c011130e <update_wall_time+12/48>
Trace; c011ae20 <handle_mm_fault+c8/13c>
Trace; c011157e <timer_bh+d2/3a0>
Trace; c0111573 <timer_bh+c7/3a0>
Trace; c010a103 <do_8259A_IRQ+8f/9c>
Trace; c01249cf <sys_write+c3/e8>
Trace; c012483c <sys_read+0/d0>
Trace; c010923d <error_code+2d/40>
Trace; c0109104 <system_call+34/40>
Code;  c0121b43 <__get_free_pages+1eb/2b8>
00000000 <_EIP>:
Code;  c0121b43 <__get_free_pages+1eb/2b8>   <=====
   0:   89 70 04                  mov    %esi,0x4(%eax)   <=====
Code;  c0121b46 <__get_free_pages+1ee/2b8>
   3:   89 e8                     mov    %ebp,%eax
Code;  c0121b48 <__get_free_pages+1f0/2b8>
   5:   2b 05 ec da 1d c0         sub    0xc01ddaec,%eax
Code;  c0121b4e <__get_free_pages+1f6/2b8>
   b:   8d 04 40                  lea    (%eax,%eax,2),%eax
Code;  c0121b51 <__get_free_pages+1f9/2b8>
   e:   89 c2                     mov    %eax,%edx
Code;  c0121b53 <__get_free_pages+1fb/2b8>
  10:   c1 e2 04                  shl    $0x4,%edx
Code;  c0121b56 <__get_free_pages+1fe/2b8>
  13:   01 00                     add    %eax,(%eax)


1 warning issued.  Results may not be reliable.




Running 2.2.18pre21 I get the following during the scp I do afterwards
to get the data off of the machine (sometimes it lock up here, other
times it doesn't):


ksymoops 0.7c on i586 2.2.18pre21.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000014
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011be86>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c02d12e0   ecx: c02d12e0   edx: 00000010
esi: 00000400   edi: 00000000   ebp: 00000030   esp: c7fe1fac
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, process nr: 5, stackpage=c7fe1000)
Stack: c7fe0000 0000001e 00000006 00000001 00000001 c0121007 00000006 00000030
c7fe0000 c01b615a c7fe01c5 00000e00 c01210ef 00000030 00000f00 c7ff9fc0
c0106000 c0107c63 00000000 00000f00 c01ebfd8                             Call 
Trace: [<c0121007>] [<c01b615a>] [<c01210ef>] [<c0106000>] [<c0107c63>]    
Code: 89 42 04 8b 51 04 85 d2 74 04 8b 01 89 02 c7 01 00 00 00 00

>>EIP; c011be86 <remove_inode_page+4a/70>   <=====
Trace; c0121007 <do_try_to_free_pages+33/b8>
Trace; c01b615a <tvecs+1d1a/3700>
Trace; c01210ef <kswapd+63/98>
Trace; c0106000 <get_options+0/74>
Trace; c0107c63 <kernel_thread+23/30>
Code;  c011be86 <remove_inode_page+4a/70>
00000000 <_EIP>:
Code;  c011be86 <remove_inode_page+4a/70>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c011be89 <remove_inode_page+4d/70>
   3:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c011be8c <remove_inode_page+50/70>
   6:   85 d2                     test   %edx,%edx
Code;  c011be8e <remove_inode_page+52/70>
   8:   74 04                     je     e <_EIP+0xe> c011be94 <remove_inode_page+58/70>
Code;  c011be90 <remove_inode_page+54/70>
   a:   8b 01                     mov    (%ecx),%eax
Code;  c011be92 <remove_inode_page+56/70>
   c:   89 02                     mov    %eax,(%edx)
Code;  c011be94 <remove_inode_page+58/70>
   e:   c7 01 00 00 00 00         movl   $0x0,(%ecx)



Both kernels have the same .config with the exception that 2.2.18pre21
have serial console enabled. It is the 2.2.18pre21 .config that is
attached below.

The machine is a P200 MMX with 128MB (tested) RAM. Cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 4
model name	: Pentium MMX
stepping	: 4
cpu MHz		: 199.434
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 398.13




Any comments and suggestions are welcome. Further info gladly provided.

Regards,
  Rasmus


.config:


#
# Automatically generated by make menuconfig: don't edit
#

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M686 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_OLD_PROC=y
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PARPORT is not set
# CONFIG_APM is not set
# CONFIG_TOSHIBA is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_NETLINK is not set
CONFIG_FIREWALL=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_IP_FIREWALL=y
CONFIG_IP_TRANSPARENT_PROXY=y
CONFIG_IP_MASQUERADE=y
CONFIG_IP_MASQUERADE_ICMP=y
CONFIG_IP_ROUTER=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_ALIAS=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_RARP is not set
CONFIG_SKB_LARGE=y
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_EISA is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set

#
# Token ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_LANMEDIA is not set
# CONFIG_COMX is not set
# CONFIG_DLCI is not set
# CONFIG_WAN_DRIVERS is not set
# CONFIG_XPEED is not set
# CONFIG_SBNI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_INTEL_RNG is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_MINIX_FS=y
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
