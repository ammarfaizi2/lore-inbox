Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbSJEMIP>; Sat, 5 Oct 2002 08:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262024AbSJEMIP>; Sat, 5 Oct 2002 08:08:15 -0400
Received: from transport.cksoft.de ([62.111.66.27]:44808 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262019AbSJEMIL>; Sat, 5 Oct 2002 08:08:11 -0400
Date: Sat, 5 Oct 2002 12:11:29 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: oops when rebooting 2.5.40 in driverfs_remove_file
Message-ID: <Pine.BSF.4.44.0210051208590.39858-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when rebooting 2.5.40 I get an Oops . Had to write it away by hand
because serial console only gave crap.

If you need any further information please let me know.


ksymoops 2.4.6 on i686 2.5.40.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.39/ (specified)
     -m /usr/src/linux/System.map (specified)

c018111c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c018111c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 5a5a5ab6   ecx: 5a5a5ab6   edx: c027e9a0
esi: 5a5a5a5a5  edi: d7d066f0   ebp: d7d06600   esp: d5f61e00
ds: 0068   es: 0068   ss: 0068
Stack: c027e9a0 00000077 d7d0664c c02babfc d7ce7720 c01d2353 d7d066f0 c0289f04
       d7d0664c c03bedb8 c017ee8b d7d0664c c02babfc d7d06600 d7d06600 00000001
       00000001 c017fab3 d7d06600 c03bedb8 c02012d8 d7d06600 c03bedb8 c03cedc8
Call Trace:
 [<c01d2353>] device_remove_file+0x33/0x60
 [<c017ee8b>] driverfs_remove_partitions+0x5b/0xc0
 [<c017fab3>] del_gendisk+0x13/0x60
 [<c02012d8>] idedisk_cleanup+0x68/0x90
 [<c01fd96b>] ide_notify_reboot+0xbb/0x310
 [<c012a1cd>] notifier_call_chain+0x2d/0x50
 [<c012a7d5>] sys_reboot+0x175/0x380
 [<c013c5fc>] kmem_cache_free_one+0xec/0x200
 [<c013b292>] free_block+0x62/0xa0
 [<c013c7bc>] __kmem_cache_free+0xac/0xee
 [<c0166130>] dput+0x30/0x210
 [<c014e6cd>] __fput+0x10d/0x140
 [<c014bee7>] filp_close+0xf7/0x130
 [<c014bf99>] sys_close+0x79/0x90
 [<c0107d6f>] syscall_call+0x7/0xb
Code: f0 ff 4e 5c 0f 88 d8 02 00 00 8b 47 04 89 04 24 8b 44 24 1c


>>EIP; c018111c <driverfs_remove_file+4c/c0>   <=====

>>edx; c027e9a0 <ic_req_params.1+2344/22984>
>>edi; d7d066f0 <_end+178b0c93/1845a5a3>
>>ebp; d7d06600 <_end+178b0ba3/1845a5a3>
>>esp; d5f61e00 <_end+15b0c3a3/1845a5a3>

Trace; c01d2353 <device_remove_file+33/60>
Trace; c017ee8b <driverfs_remove_partitions+5b/c0>
Trace; c017fab3 <del_gendisk+13/60>
Trace; c02012d8 <idedisk_cleanup+68/90>
Trace; c01fd96b <ide_notify_reboot+bb/c0>
Trace; c012a1cd <notifier_call_chain+2d/50>
Trace; c012a7d5 <sys_reboot+175/380>
Trace; c013c5fc <kmem_cache_free_one+ec/200>
Trace; c013b292 <free_block+62/a0>
Trace; c013c7bc <__kmem_cache_free+ac/ee>
Trace; c0166130 <dput+30/210>
Trace; c014e6cd <__fput+10d/140>
Trace; c014bee7 <filp_close+f7/130>
Trace; c014bf99 <sys_close+79/90>
Trace; c0107d6f <syscall_call+7/b>

Code;  c018111c <driverfs_remove_file+4c/c0>
00000000 <_EIP>:
Code;  c018111c <driverfs_remove_file+4c/c0>   <=====
   0:   f0 ff 4e 5c               lock decl 0x5c(%esi)   <=====
Code;  c0181120 <driverfs_remove_file+50/c0>
   4:   0f 88 d8 02 00 00         js     2e2 <_EIP+0x2e2> c01813fe <.text.lock.inode+a4/e6>
Code;  c0181126 <driverfs_remove_file+56/c0>
   a:   8b 47 04                  mov    0x4(%edi),%eax
Code;  c0181129 <driverfs_remove_file+59/c0>
   d:   89 04 24                  mov    %eax,(%esp,1)
Code;  c018112c <driverfs_remove_file+5c/c0>
  10:   8b 44 24 1c               mov    0x1c(%esp,1),%eax


-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

