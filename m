Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTK2Sdv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 13:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTK2Sdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 13:33:51 -0500
Received: from [212.121.145.100] ([212.121.145.100]:61830 "EHLO
	mail.x-cellent.com") by vger.kernel.org with ESMTP id S263879AbTK2Sdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 13:33:43 -0500
Subject: LVM2 related OOPS in 2.4.22 (kernel BUG at kcopyd.c:130!)
From: Stefan Majer <stefan@x-cellent.com>
To: linux-lvm@sistina.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1070130848.15958.6.camel@dom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 29 Nov 2003 19:34:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Im currently testing a LVM2 Setup with Kernel 2.4.22.

First i created a logical volume and the about 5 snapshots.
Then i wanted to create a filesystem on the source LV with
mkreiserfs.

i have the following LVM2 Version installed:
  LVM version:     2.00.08-cvs (2003-11-14)
  Library version: 1.00.06-ioctl-cvs (2003-11-13)
  Driver version:  4.0.1

the mkreiserfs never returns and i got the following oops:

kernel BUG at kcopyd.c:130!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c021217c>]    Not tainted
EFLAGS: 00010287
eax: 00000100   ebx: c564c5c0   ecx: c36c5600   edx: 00001020
esi: d09cc004   edi: 00000000   ebp: 00000000   esp: c4145ee8
ds: 0018   es: 0018   ss: 0018
Process lvremove (pid: 9448, stackpage=c4145000)
Stack: c564c5c0 c564c5c0 c0212b1b c564c5c0 c12ddd40 c0210428 c564c5c0
c2e092a0 
       d09cc004 c5644cc0 c020bff1 d09cc004 000000fe 00000006 c51bf6a0
080c98f0 
       c020b513 c5644cc0 00000000 00000000 c51bf6a0 d09a0000 00000004
c020b581 
Call Trace:    [<c0212b1b>] [<c0210428>] [<c020bff1>] [<c020b513>]
[<c020b581>]
  [<c020d616>] [<c020dc59>] [<c020f039>] [<c0119952>] [<c020dc10>]
[<c014489b>]
  [<c0107277>]

Code: 0f 0b 82 00 37 23 29 c0 eb da 8d 76 00 8d bc 27 00 00 00 00 
 <1>Unable to handle kernel paging request at virtual address d09d3480
 printing eip:
c021187c
*pde = 0fe91067
*pte = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c021187c>]    Not tainted
EFLAGS: 00010282
eax: 00000451   ebx: cfea5f3c   ecx: d09d3480   edx: 00000000
esi: 00000000   edi: ca3ba740   ebp: c0210810   esp: cfea5f20
ds: 0018   es: 0018   ss: 0018
Process kcopyd (pid: 9, stackpage=cfea5000)
Stack: c51bfee0 00000048 c51bfee0 c0211be9 c51bfee0 00000048 cfea5f3c
00000451 
       00000000 00000454 00000000 c12ddd40 00000000 ca3ba740 c0210861
c12ddd8c 
       ca3ba740 c0210800 ca3ba740 ca3b8724 c0212333 00000000 00000000
ca3ba740 
Call Trace:    [<c0211be9>] [<c0210861>] [<c0210800>] [<c0212333>]
[<c0212537>]
  [<c02125d7>] [<c02122d0>] [<c0212d77>] [<c010571e>] [<c0212cb0>]

Code: 89 01 8b 43 08 89 51 04 8b 53 0c 89 41 08 31 c0 89 51 0c 83 
kernel BUG at kcopyd.c:130!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c021217c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: 00000100   ebx: c564c5c0   ecx: c36c5600   edx: 00001020
esi: d09cc004   edi: 00000000   ebp: 00000000   esp: c4145ee8
ds: 0018   es: 0018   ss: 0018
Process lvremove (pid: 9448, stackpage=c4145000)
Stack: c564c5c0 c564c5c0 c0212b1b c564c5c0 c12ddd40 c0210428 c564c5c0
c2e092a0 
       d09cc004 c5644cc0 c020bff1 d09cc004 000000fe 00000006 c51bf6a0
080c98f0 
       c020b513 c5644cc0 00000000 00000000 c51bf6a0 d09a0000 00000004
c020b581 
Call Trace:    [<c0212b1b>] [<c0210428>] [<c020bff1>] [<c020b513>]
[<c020b581>]
  [<c020d616>] [<c020dc59>] [<c020f039>] [<c0119952>] [<c020dc10>]
[<c014489b>]
  [<c0107277>]
Code: 0f 0b 82 00 37 23 29 c0 eb da 8d 76 00 8d bc 27 00 00 00 00 


>>EIP; c021217c <dm_unregister_target+51cc/58b0>   <=====

>>ebx; c564c5c0 <_end+531feec/105b598c>
>>ecx; c36c5600 <_end+3398f2c/105b598c>
>>esp; c4145ee8 <_end+3e19814/105b598c>

Trace; c0212b1b <kcopyd_client_destroy+1b/2b0>
Trace; c0210428 <dm_unregister_target+3478/58b0>
Trace; c020bff1 <dm_kdevname+651/930>
Trace; c020b513 <pci_assign_resource+2543/29d0>
Trace; c020b581 <pci_assign_resource+25b1/29d0>
Trace; c020d616 <dm_unregister_target+666/58b0>
Trace; c020dc59 <dm_unregister_target+ca9/58b0>
Trace; c020f039 <dm_unregister_target+2089/58b0>
Trace; c0119952 <tasklet_kill+b2/c0>
Trace; c020dc10 <dm_unregister_target+c60/58b0>
Trace; c014489b <kill_fasync+3cb/420>
Trace; c0107277 <__up_wakeup+1297/1690>

Code;  c021217c <dm_unregister_target+51cc/58b0>
00000000 <_EIP>:
Code;  c021217c <dm_unregister_target+51cc/58b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c021217e <dm_unregister_target+51ce/58b0>
   2:   82                        (bad)  
Code;  c021217f <dm_unregister_target+51cf/58b0>
   3:   00 37                     add    %dh,(%edi)
Code;  c0212181 <dm_unregister_target+51d1/58b0>
   5:   23 29                     and    (%ecx),%ebp
Code;  c0212183 <dm_unregister_target+51d3/58b0>
   7:   c0 eb da                  shr    $0xda,%bl
Code;  c0212186 <dm_unregister_target+51d6/58b0>
   a:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0212189 <dm_unregister_target+51d9/58b0>
   d:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi

 <1>Unable to handle kernel paging request at virtual address d09d3480
c021187c
*pde = 0fe91067
Oops: 0002
CPU:    0
EIP:    0010:[<c021187c>]    Not tainted
EFLAGS: 00010282
eax: 00000451   ebx: cfea5f3c   ecx: d09d3480   edx: 00000000
esi: 00000000   edi: ca3ba740   ebp: c0210810   esp: cfea5f20
ds: 0018   es: 0018   ss: 0018
Process kcopyd (pid: 9, stackpage=cfea5000)
Stack: c51bfee0 00000048 c51bfee0 c0211be9 c51bfee0 00000048 cfea5f3c
00000451 
       00000000 00000454 00000000 c12ddd40 00000000 ca3ba740 c0210861
c12ddd8c 
       ca3ba740 c0210800 ca3ba740 ca3b8724 c0212333 00000000 00000000
ca3ba740 
Call Trace:    [<c0211be9>] [<c0210861>] [<c0210800>] [<c0212333>]
[<c0212537>]
  [<c02125d7>] [<c02122d0>] [<c0212d77>] [<c010571e>] [<c0212cb0>]
Code: 89 01 8b 43 08 89 51 04 8b 53 0c 89 41 08 31 c0 89 51 0c 83 


>>EIP; c021187c <dm_unregister_target+48cc/58b0>   <=====

>>ebx; cfea5f3c <_end+fb79868/105b598c>
>>edi; ca3ba740 <_end+a08e06c/105b598c>
>>ebp; c0210810 <dm_unregister_target+3860/58b0>
>>esp; cfea5f20 <_end+fb7984c/105b598c>

Trace; c0211be9 <dm_unregister_target+4c39/58b0>
Trace; c0210861 <dm_unregister_target+38b1/58b0>
Trace; c0210800 <dm_unregister_target+3850/58b0>
Trace; c0212333 <dm_unregister_target+5383/58b0>
Trace; c0212537 <dm_unregister_target+5587/58b0>
Trace; c02125d7 <dm_unregister_target+5627/58b0>
Trace; c02122d0 <dm_unregister_target+5320/58b0>
Trace; c0212d77 <kcopyd_client_destroy+277/2b0>
Trace; c010571e <machine_power_off+1ee/400>
Trace; c0212cb0 <kcopyd_client_destroy+1b0/2b0>

Code;  c021187c <dm_unregister_target+48cc/58b0>
00000000 <_EIP>:
Code;  c021187c <dm_unregister_target+48cc/58b0>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  c021187e <dm_unregister_target+48ce/58b0>
   2:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0211881 <dm_unregister_target+48d1/58b0>
   5:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c0211884 <dm_unregister_target+48d4/58b0>
   8:   8b 53 0c                  mov    0xc(%ebx),%edx
Code;  c0211887 <dm_unregister_target+48d7/58b0>
   b:   89 41 08                  mov    %eax,0x8(%ecx)
Code;  c021188a <dm_unregister_target+48da/58b0>
   e:   31 c0                     xor    %eax,%eax
Code;  c021188c <dm_unregister_target+48dc/58b0>
  10:   89 51 0c                  mov    %edx,0xc(%ecx)
Code;  c021188f <dm_unregister_target+48df/58b0>
  13:   83 00 00                  addl   $0x0,(%eax)


Greetings

Stefan Majer

