Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUGUGU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUGUGU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 02:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUGUGU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 02:20:56 -0400
Received: from main.gmane.org ([80.91.224.249]:27335 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265161AbUGUGUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 02:20:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: [2.6.7] Oops while doing rsync
Date: Wed, 21 Jul 2004 15:15:22 +0900
Message-ID: <cdl1ls$ija$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080103000307010607040701"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080103000307010607040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Yesterday while trying to do a big rsync (syncing portage on a Gentoo box), the process failed with strange errors and after a few retries I looked at dmesg. There were 10 oopses, so I logged them and rebooted the box. On reboot, it failed to unmount some NFS mounts, so a cold restart was needed.

Kernel is tainted (nvidia, vmware), but I guess it is not related to this (just a wild guess).

BTW dmesg was filled with the following:

Unknown EII protocol 86DD: csum at 16

which I guess has something to do with vmware and IPv6.

 # lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
0000:00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
0000:00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
0000:00:00.3 RAM memory: nVidia Corporation nForce 420 Memory Controller (DDR) (rev b2)
0000:00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
0000:00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
0000:00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
0000:00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet Controller (rev c2)
0000:00:05.0 Multimedia audio controller: nVidia Corporation: Unknown device 01b0 (rev c2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce Audio (rev c2)
0000:00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2)
0000:00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2)
0000:01:00.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:01:00.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
0000:01:02.0 USB Controller: NEC Corporation USB (rev 41)
0000:01:02.1 USB Controller: NEC Corporation USB (rev 41)
0000:01:02.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
0000:01:03.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
0000:02:00.0 VGA compatible controller: nVidia Corporation NVCrush11 [GeForce2 MX Integrated Graphics] (rev b1)

 # cat /proc/ide/amd74xx 
----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.13
South Bridge:                       0000:00:09.0
Revision:                           IDE 0xc3
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xe800
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA      UDMA       PIO
Address Setup:       30ns      30ns      30ns      90ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns     330ns
Data Recovery:       30ns      30ns      30ns     270ns
Cycle Time:          60ns     120ns      60ns     600ns
Transfer Rate:   33.3MB/s  16.6MB/s  33.3MB/s   3.3MB/s

 # cat /proc/ide/hd?/model 
Maxtor 98196H8
GENERIC CRD-BP1400P
Maxtor 54610H6

Any additional information and or debugging will be posted upon request.
Problem is not reproducible for now, will keep an eye.

Kalin.


--------------080103000307010607040701
Content-Type: text/plain;
 name="rsync.oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rsync.oops"

ksymoops 2.4.9 on i686 2.6.7-KK1_bla.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.7-KK1_bla/ (default)
     -m /var/tmp/kernels/2.6.7-KK1_bla/System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00aeaae6
c014cffe
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 00aeaaae   ebx: f28ad82c   ecx: e52bbf28   edx: f7fdcb60
esi: f28afa24   edi: e52bbf6c   ebp: f7fcd0e0   esp: e52bbefc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 e52bbf28 bfffd940 e52ba000 c014d12c 
       f7fcd0e0 f28afa24 e52bbf6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 e52bbf6c 00000000 e52bbf6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c01441ed>] sys_llseek+0x5d/0xd0
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>eax; 00aeaaae <__crc_flush_scheduled_work+2e9436/46def3>
>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; e52bbf28 <__crc___breadahead+1f6af3/21fa90>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; e52bbf6c <__crc___breadahead+1f6b37/21fa90>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; e52bbefc <__crc___breadahead+1f6ac7/21fa90>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c01441ed <sys_llseek+5d/d0>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

Unable to handle kernel paging request at virtual address 2848088c
c014cffe
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 28480854   ebx: f28ad82c   ecx: c4c3ff28   edx: f7fdcb60
esi: f28afa24   edi: c4c3ff6c   ebp: f7fcd0e0   esp: c4c3fefc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 c4c3ff28 bfffd940 c4c3e000 c014d12c 
       f7fcd0e0 f28afa24 c4c3ff6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 c4c3ff6c 00000000 c4c3ff6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c010edd0>] do_page_fault+0x0/0x4ff
 [<c0103f65>] error_code+0x2d/0x38
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>eax; 28480854 <__crc_sysdev_driver_register+31c776/52a6af>
>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; c4c3ff28 <__crc_fat_date_unix2dos+252368/2674dd>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; c4c3ff6c <__crc_fat_date_unix2dos+2523ac/2674dd>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; c4c3fefc <__crc_fat_date_unix2dos+25233c/2674dd>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c010edd0 <do_page_fault+0/4ff>
Trace; c0103f65 <error_code+2d/38>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

Unable to handle kernel paging request at virtual address 000e0044
c015bfcc
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c015bfcc>]    Tainted: P  
EFLAGS: 00010287   (2.6.7-KK1_bla) 
eax: 000e0020   ebx: f28d5eac   ecx: f28d5ebc   edx: f28d5ebc
esi: f28d5eac   edi: 00000019   ebp: f7ffea48   esp: d2087ef0
ds: 007b   es: 007b   ss: 0068
Stack: f27ec8fc f27ec868 c0159bd9 f28d5eac 00000031 00000080 00000000 d2086000 
       c0159f2f 00000080 c01338ab 00000080 000000d0 00026222 01667200 00000000 
       00000096 00000000 c03594a4 00000001 0000000c c0359380 c0134a31 00000040 
Call Trace:
 [<c0159bd9>] prune_dcache+0xf9/0x130
 [<c0159f2f>] shrink_dcache_memory+0x1f/0x30
 [<c01338ab>] shrink_slab+0x14b/0x190
 [<c0134a31>] balance_pgdat+0x1b1/0x200
 [<c0134b47>] kswapd+0xc7/0xe0
 [<c0111750>] autoremove_wake_function+0x0/0x60
 [<c0111750>] autoremove_wake_function+0x0/0x60
 [<c0134a80>] kswapd+0x0/0xe0
 [<c0102151>] kernel_thread_helper+0x5/0x14
Code: 8b 40 24 74 44 85 c0 74 07 8b 48 14 85 c9 75 31 ff 4b 1c 0f 


>>EIP; c015bfcc <iput+1c/70>   <=====

>>eax; 000e0020 <__crc___lock_buffer+5d2d9/2abc09>
>>ebx; f28d5eac <__crc_ide_config_drive_speed+391ef9/5f5663>
>>ecx; f28d5ebc <__crc_ide_config_drive_speed+391f09/5f5663>
>>edx; f28d5ebc <__crc_ide_config_drive_speed+391f09/5f5663>
>>esi; f28d5eac <__crc_ide_config_drive_speed+391ef9/5f5663>
>>ebp; f7ffea48 <__crc_netlink_register_notifier+72e59d/757878>
>>esp; d2087ef0 <__crc_auth_unix_lookup+339dba/6e98dc>

Trace; c0159bd9 <prune_dcache+f9/130>
Trace; c0159f2f <shrink_dcache_memory+1f/30>
Trace; c01338ab <shrink_slab+14b/190>
Trace; c0134a31 <balance_pgdat+1b1/200>
Trace; c0134b47 <kswapd+c7/e0>
Trace; c0111750 <autoremove_wake_function+0/60>
Trace; c0111750 <autoremove_wake_function+0/60>
Trace; c0134a80 <kswapd+0/e0>
Trace; c0102151 <kernel_thread_helper+5/14>

Code;  c015bfcc <iput+1c/70>
00000000 <_EIP>:
Code;  c015bfcc <iput+1c/70>   <=====
   0:   8b 40 24                  mov    0x24(%eax),%eax   <=====
Code;  c015bfcf <iput+1f/70>
   3:   74 44                     je     49 <_EIP+0x49>
Code;  c015bfd1 <iput+21/70>
   5:   85 c0                     test   %eax,%eax
Code;  c015bfd3 <iput+23/70>
   7:   74 07                     je     10 <_EIP+0x10>
Code;  c015bfd5 <iput+25/70>
   9:   8b 48 14                  mov    0x14(%eax),%ecx
Code;  c015bfd8 <iput+28/70>
   c:   85 c9                     test   %ecx,%ecx
Code;  c015bfda <iput+2a/70>
   e:   75 31                     jne    41 <_EIP+0x41>
Code;  c015bfdc <iput+2c/70>
  10:   ff 4b 1c                  decl   0x1c(%ebx)
Code;  c015bfdf <iput+2f/70>
  13:   0f 00 00                  sldtl  (%eax)

Unable to handle kernel NULL pointer dereference at virtual address 00000038
c014cffe
*pde = 00000000
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 00000000   ebx: f28ad82c   ecx: c4c3ff28   edx: f7fdcb60
esi: f28afa24   edi: c4c3ff6c   ebp: f7fcd0e0   esp: c4c3fefc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 c4c3ff28 bfffd940 c4c3e000 c014d12c 
       f7fcd0e0 f28afa24 c4c3ff6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 c4c3ff6c 00000000 c4c3ff6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; c4c3ff28 <__crc_fat_date_unix2dos+252368/2674dd>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; c4c3ff6c <__crc_fat_date_unix2dos+2523ac/2674dd>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; c4c3fefc <__crc_fat_date_unix2dos+25233c/2674dd>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

Unable to handle kernel paging request at virtual address 508202b8
c014cffe
*pde = 00000000
Oops: 0000 [#5]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 50820280   ebx: f28ad82c   ecx: eae1df28   edx: f7fdcb60
esi: f28afa24   edi: eae1df6c   ebp: f7fcd0e0   esp: eae1defc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 eae1df28 bfffd940 eae1c000 c014d12c 
       f7fcd0e0 f28afa24 eae1df6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 eae1df6c 00000000 eae1df6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c010edd0>] do_page_fault+0x0/0x4ff
 [<c0103f65>] error_code+0x2d/0x38
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>eax; 50820280 <__crc_dcache_dir_lseek+1ec02c/80544e>
>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; eae1df28 <__crc_unregister_blkdev+201a79/221b27>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; eae1df6c <__crc_unregister_blkdev+201abd/221b27>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; eae1defc <__crc_unregister_blkdev+201a4d/221b27>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c010edd0 <do_page_fault+0/4ff>
Trace; c0103f65 <error_code+2d/38>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

Unable to handle kernel paging request at virtual address 00c7d111
c014cffe
*pde = 00000000
Oops: 0000 [#6]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 00c7d0d9   ebx: f28ad82c   ecx: c54dff28   edx: f7fdcb60
esi: f28afa24   edi: c54dff6c   ebp: f7fcd0e0   esp: c54dfefc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 c54dff28 bfffd940 c54de000 c014d12c 
       f7fcd0e0 f28afa24 c54dff6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 c54dff6c 00000000 c54dff6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c010edd0>] do_page_fault+0x0/0x4ff
 [<c0103f65>] error_code+0x2d/0x38
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>eax; 00c7d0d9 <__crc_usb_check_bandwidth+db6e/f8220>
>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; c54dff28 <__crc___invalidate_device+305770/7ca963>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; c54dff6c <__crc___invalidate_device+3057b4/7ca963>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; c54dfefc <__crc___invalidate_device+305744/7ca963>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c010edd0 <do_page_fault+0/4ff>
Trace; c0103f65 <error_code+2d/38>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

 <1>Unable to handle kernel paging request at virtual address 0004ac38
c014cffe
*pde = 00000000
Oops: 0000 [#7]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 0004ac00   ebx: f28ad82c   ecx: ddebbf28   edx: f7fdcb60
esi: f28afa24   edi: ddebbf6c   ebp: f7fcd0e0   esp: ddebbefc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 ddebbf28 bfffd940 ddeba000 c014d12c 
       f7fcd0e0 f28afa24 ddebbf6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 ddebbf6c 00000000 ddebbf6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; ddebbf28 <__crc_usb_driver_claim_interface+e17b8/17e070>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; ddebbf6c <__crc_usb_driver_claim_interface+e17fc/17e070>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; ddebbefc <__crc_usb_driver_claim_interface+e178c/17e070>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

 <1>Unable to handle kernel paging request at virtual address 001b1c61
c014cffe
*pde = 00000000
Oops: 0000 [#8]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 001b1c29   ebx: f28ad82c   ecx: c7529f28   edx: f7fdcb60
esi: f28afa24   edi: c7529f6c   ebp: f7fcd0e0   esp: c7529efc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 c7529f28 bfffd940 c7528000 c014d12c 
       f7fcd0e0 f28afa24 c7529f6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 c7529f6c 00000000 c7529f6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>eax; 001b1c29 <__crc___lock_buffer+12eee2/2abc09>
>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; c7529f28 <__crc_sock_no_poll+15e121/431d07>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; c7529f6c <__crc_sock_no_poll+15e165/431d07>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; c7529efc <__crc_sock_no_poll+15e0f5/431d07>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

 <1>Unable to handle kernel paging request at virtual address 00486438
c014cffe
*pde = 00000000
Oops: 0000 [#9]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 00486400   ebx: f28ad82c   ecx: c7529f28   edx: f7fdcb60
esi: f28afa24   edi: c7529f6c   ebp: f7fcd0e0   esp: c7529efc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 c7529f28 bfffd940 c7528000 c014d12c 
       f7fcd0e0 f28afa24 c7529f6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 c7529f6c 00000000 c7529f6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c010edd0>] do_page_fault+0x0/0x4ff
 [<c0103f65>] error_code+0x2d/0x38
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>eax; 00486400 <__crc_vfs_rmdir+157ab0/2dfe16>
>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; c7529f28 <__crc_sock_no_poll+15e121/431d07>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; c7529f6c <__crc_sock_no_poll+15e165/431d07>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; c7529efc <__crc_sock_no_poll+15e0f5/431d07>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c010edd0 <do_page_fault+0/4ff>
Trace; c0103f65 <error_code+2d/38>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)

 <1>Unable to handle kernel paging request at virtual address 0004ac38
c014cffe
*pde = 00000000
Oops: 0000 [#10]
CPU:    0
EIP:    0060:[<c014cffe>]    Tainted: P  
EFLAGS: 00210246   (2.6.7-KK1_bla) 
eax: 0004ac00   ebx: f28ad82c   ecx: ede75f28   edx: f7fdcb60
esi: f28afa24   edi: ede75f6c   ebp: f7fcd0e0   esp: ede75efc
ds: 007b   es: 007b   ss: 0068
Stack: f7fcd0e0 f28afa24 f79eb000 00000000 ede75f28 bfffd940 ede74000 c014d12c 
       f7fcd0e0 f28afa24 ede75f6c f28afa24 f7fcd0e0 40fbe1f0 3802e615 40eb3051 
       00000000 00000001 00000000 00003783 00000000 ede75f6c 00000000 ede75f6c 
Call Trace:
 [<c014d12c>] vfs_lstat+0x4c/0x60
 [<c014d82b>] sys_lstat64+0x1b/0x40
 [<c010edd0>] do_page_fault+0x0/0x4ff
 [<c0103f65>] error_code+0x2d/0x38
 [<c0103dbb>] syscall_call+0x7/0xb
Code: 8b 50 38 85 d2 74 22 89 7c 24 08 89 74 24 04 89 2c 24 ff 50 


>>EIP; c014cffe <vfs_getattr+3e/c0>   <=====

>>ebx; f28ad82c <__crc_ide_config_drive_speed+369879/5f5663>
>>ecx; ede75f28 <__crc_vfs_statfs+42d6b/24ceb2>
>>edx; f7fdcb60 <__crc_netlink_register_notifier+70c6b5/757878>
>>esi; f28afa24 <__crc_ide_config_drive_speed+36ba71/5f5663>
>>edi; ede75f6c <__crc_vfs_statfs+42daf/24ceb2>
>>ebp; f7fcd0e0 <__crc_netlink_register_notifier+6fcc35/757878>
>>esp; ede75efc <__crc_vfs_statfs+42d3f/24ceb2>

Trace; c014d12c <vfs_lstat+4c/60>
Trace; c014d82b <sys_lstat64+1b/40>
Trace; c010edd0 <do_page_fault+0/4ff>
Trace; c0103f65 <error_code+2d/38>
Trace; c0103dbb <syscall_call+7/b>

Code;  c014cffe <vfs_getattr+3e/c0>
00000000 <_EIP>:
Code;  c014cffe <vfs_getattr+3e/c0>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c014d001 <vfs_getattr+41/c0>
   3:   85 d2                     test   %edx,%edx
Code;  c014d003 <vfs_getattr+43/c0>
   5:   74 22                     je     29 <_EIP+0x29>
Code;  c014d005 <vfs_getattr+45/c0>
   7:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c014d009 <vfs_getattr+49/c0>
   b:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c014d00d <vfs_getattr+4d/c0>
   f:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c014d010 <vfs_getattr+50/c0>
  12:   ff 50 00                  call   *0x0(%eax)


1 warning issued.  Results may not be reliable.

--------------080103000307010607040701--

