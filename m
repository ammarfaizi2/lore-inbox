Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310515AbSCSJPZ>; Tue, 19 Mar 2002 04:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSCSJPR>; Tue, 19 Mar 2002 04:15:17 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:18694 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S310516AbSCSJPB>; Tue, 19 Mar 2002 04:15:01 -0500
Date: Tue, 19 Mar 2002 01:14:27 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 oops with ReiserFS
Message-ID: <20020319091427.GA4271@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.5 (i686)
X-uptime: 1:13am  up  8:07,  2 users,  load average: 0.00, 0.00, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        This didn't make it through last time, so take 2.


        Apologies for this being so long.

        Just got this after a compile of 2.5.7, at boot. .config is below.

Linux version 2.5.7 (root@bellicha) (gcc version 2.95.3 20010315 (release)) #2 
Mon Mar 18 16:06:59 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line:
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1133.414 MHz processor.
.
.
.
.
Mounted devfs on /dev
Freeing unused kernel memory: 236k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 1028120k swap-space (priority -1)
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c013a61a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013a61a>]    Not tainted
EFLAGS: 00010286
eax: 00001000   ebx: 0000000f   ecx: 00000009   edx: 00002012
esi: 00000009   edi: 00002012   ebp: 00000000   esp: df9c5d90
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 35, threadinfo=df9c4000 task=dfb98c40)
Stack: 00001000 00002012 00000000 df9c6c00 df9c6c00 c013ad18 00000000 00002012
       00001000 df9c6c00 e08c8000 e08d93ec c013af57 00000000 00002012 00001000
       df9c6c00 e08b9acc 00000000 00002012 00001000 00000343 00000000 df9c6d54
Call Trace: [<c013ad18>] [<c013af57>] [<e08b9acc>] [<c0139d70>] [<e08abb59>]
   [<e08ac46c>] [<c017fe74>] [<c013fa91>] [<c013e620>] [<e08c4e40>] 
[<e08c4e40>]

   [<e08ac85f>] [<e08c4e40>] [<e08ac340>] [<c013e820>] [<e08c4e40>] 
[<c014fe79>]

   [<c0150160>] [<c014ff9d>] [<c0150584>] [<c0107077>]


Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10

[ snip ]

        The box continues to boot, though my ReiserFS partitions aren't 
available. Also, /proc fails to load, even after doing a mount /proc /proc -t 
proc, which kills me getting at /proc/ksyms and /proc/modules for ksymoops to 
give a decent trace. Here's the best I could get:

ksymoops 2.4.5 on i686 2.5.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7 (specified)
     -m ./System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000010
c013a61a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013a61a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00001000   ebx: 0000000f   ecx: 00000009   edx: 00002012
esi: 00000009   edi: 00002012   ebp: 00000000   esp: df9c5d90
ds: 0018   es: 0018   ss: 0018
Stack: 00001000 00002012 00000000 df9c6c00 df9c6c00 c013ad18 00000000 00002012 
       00001000 df9c6c00 e08c8000 e08d93ec c013af57 00000000 00002012 00001000 
       df9c6c00 e08b9acc 00000000 00002012 00001000 00000343 00000000 df9c6d54 
Call Trace: [<c013ad18>] [<c013af57>] [<e08b9acc>] [<c0139d70>] [<e08abb59>] 
   [<e08ac46c>] [<c017fe74>] [<c013fa91>] [<c013e620>] [<e08c4e40>] [<e08c4e40>] 
   [<e08ac85f>] [<e08c4e40>] [<e08ac340>] [<c013e820>] [<e08c4e40>] [<c014fe79>] 
   [<c0150160>] [<c014ff9d>] [<c0150584>] [<c0107077>] 
Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10 


>>EIP; c013a61a <__get_hash_table+1a/c0>   <=====

>>eax; 00001000 Before first symbol
>>edx; 00002012 Before first symbol
>>edi; 00002012 Before first symbol
>>esp; df9c5d90 <_end+1f6cb4ac/2051d71c>

Trace; c013ad18 <__getblk+18/40>
Trace; c013af57 <__bread+17/70>
Trace; e08b9acc <[reiserfs]reiserfs_journal_commit_thread+9c/160>
Trace; c0139d70 <__wait_on_buffer+80/90>
Trace; e08abb59 <[reiserfs]read_bitmaps+a9/1d0>
Trace; e08ac46c <[reiserfs]reiserfs_fill_super+7c/4b0>
Trace; c017fe74 <sprintf+14/20>
Trace; c013fa91 <bdevname+31/3a>
Trace; c013e620 <get_sb_bdev+200/270>
Trace; e08c4e40 <[reiserfs]MAX_KEY+3320/361f>
Trace; e08c4e40 <[reiserfs]MAX_KEY+3320/361f>
Trace; e08ac85f <[reiserfs]reiserfs_fill_super+46f/4b0>
Trace; e08c4e40 <[reiserfs]MAX_KEY+3320/361f>
Trace; e08ac340 <[reiserfs]hash_function+0/70>
Trace; c013e820 <do_kern_mount+50/d0>
Trace; e08c4e40 <[reiserfs]MAX_KEY+3320/361f>
Trace; c014fe79 <do_add_mount+69/140>
Trace; c0150160 <do_mount+170/190>
Trace; c014ff9d <copy_mount_options+4d/a0>
Trace; c0150584 <sys_mount+a4/110>
Trace; c0107077 <syscall_call+7/b>

Code;  c013a61a <__get_hash_table+1a/c0>
0000000000000000 <_EIP>:
Code;  c013a61a <__get_hash_table+1a/c0>   <=====
   0:   0f b7 45 10               movzwl 0x10(%ebp),%eax   <=====
Code;  c013a61e <__get_hash_table+1e/c0>
   4:   b0 00                     mov    $0x0,%al
Code;  c013a620 <__get_hash_table+20/c0>
   6:   66 0f b6 55 10            movzbw 0x10(%ebp),%dx
Code;  c013a625 <__get_hash_table+25/c0>
   b:   01 d0                     add    %edx,%eax
Code;  c013a627 <__get_hash_table+27/c0>
   d:   0f b7 c0                  movzwl %ax,%eax
Code;  c013a62a <__get_hash_table+2a/c0>
  10:   89 44 24 10               mov    %eax,0x10(%esp,1)


1185 warnings issued.  Results may not be reliable.


#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

