Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUBKQwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUBKQwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:52:06 -0500
Received: from scrye.com ([216.17.180.1]:27060 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S265941AbUBKQuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:50:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Feb 2004 09:49:57 -0700
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
Subject: Bad Drive or JFS bug? (2.4.25-pre8)
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Message-Id: <20040211164958.BEC80CB32C@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings. 

It's unclear to me if this is a jfs error, or if my drive is simply
dying. There are no other indications of errors with the drive, but in
the logs: 

Feb 11 04:04:59 voldemort kernel: blkno = 6d2e74726f, nblocks = 65646c
Feb 11 04:04:59 voldemort kernel: ERROR: (device ide0(3,3)): dbFree: block to be freed is outside the map
Feb 11 04:04:59 voldemort kernel: blkno = 3000003831, nblocks = 392e6d
Feb 11 04:04:59 voldemort kernel: ERROR: (device ide0(3,3)): dbFree: block to be freed is outside the map
Feb 11 04:04:59 voldemort kernel: BUG at jfs_dmap.c:2764 assert(newval == leaf[buddy])
Feb 11 04:04:59 voldemort kernel: kernel BUG at jfs_dmap.c:2764!
Feb 11 04:04:59 voldemort kernel: invalid operand: 0000
Feb 11 04:04:59 voldemort kernel: CPU:    0
Feb 11 04:04:59 voldemort kernel: EIP:    0010:[<c01d23dd>]    Tainted: G Z
Feb 11 04:04:59 voldemort kernel: EFLAGS: 00010286
Feb 11 04:04:59 voldemort kernel: eax: 00000038   ebx: 0000000c   ecx: e0e08000   edx: f615bf64
Feb 11 04:04:59 voldemort kernel: esi: 00000000   edi: e8c6c010   ebp: 00000080   esp: e0e09cb0
Feb 11 04:04:59 voldemort kernel: ds: 0018   es: 0018   ss: 0018
Feb 11 04:04:59 voldemort kernel: Process tmpwatch (pid: 31705, stackpage=e0e09000)
Feb 11 04:04:59 voldemort kernel: Stack: c032d102 c032d308 00000acc c032d3fd e8c6c076 00000080 00000040 00
0000c0
Feb 11 04:04:59 voldemort kernel:        0000000b 00000fe0 c01d1c95 e8c6c010 000000c0 0000000b c0140de6 f7
fe7bb4
Feb 11 04:04:59 voldemort kernel:        e8c6c010 00000fe0 00001020 00049013 00000000 0000000d 00049013 00
000000
Feb 11 04:05:00 voldemort kernel: Call Trace:    [<c01d1c95>] [<c0140de6>] [<c01d18b3>] [<c01cf75f>] [<c01
e144a>]
Feb 11 04:05:00 voldemort kernel:   [<c01d41b8>] [<c01ca426>] [<c01dfbbd>] [<c01e00bb>] [<c01c13c0>] [<c01
c286b>]
Feb 11 04:05:00 voldemort kernel:   [<c01c234e>] [<c01c13c0>] [<c01c13f8>] [<c01692f0>] [<c015e5f2>] [<c01
5e852>]
Feb 11 04:05:00 voldemort kernel:   [<c010950f>]
Feb 11 04:05:00 voldemort kernel:
Feb 11 04:05:00 voldemort kernel: Code: 0f 0b cc 0a 08 d3 32 c0 39 74 24 14 7d 45 89 74 24 04 b8 ff

kernel version is 2.4.25-pre8. 

decoded oops is: 

ksymoops 2.4.9 on i686 2.4.25-pre8_2.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.25-pre8_2.0/ (default)
     -m /boot/System.map-2.4.25-pre8_2.0 (specified)

 invalid operand: 0000
 CPU:    0
 EIP:    0010:[<c01d23dd>]    Tainted: G Z
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010286
 eax: 00000038   ebx: 0000000c   ecx: e0e08000   edx: f615bf64
 esi: 00000000   edi: e8c6c010   ebp: 00000080   esp: e0e09cb0
 ds: 0018   es: 0018   ss: 0018
 Process tmpwatch (pid: 31705, stackpage=e0e09000)
 Stack: c032d102 c032d308 00000acc c032d3fd e8c6c076 00000080 00000040 000000c0
        0000000b 00000fe0 c01d1c95 e8c6c010 000000c0 0000000b c0140de6 f7fe7bb4
        e8c6c010 00000fe0 00001020 00049013 00000000 0000000d 00049013 00000000
 Call Trace:    [<c01d1c95>] [<c0140de6>] [<c01d18b3>] [<c01cf75f>] [<c01e144a>]
   [<c01d41b8>] [<c01ca426>] [<c01dfbbd>] [<c01e00bb>] [<c01c13c0>] [<c01c286b>]
   [<c01c234e>] [<c01c13c0>] [<c01c13f8>] [<c01692f0>] [<c015e5f2>] [<c015e852>]
   [<c010950f>]
 Code: 0f 0b cc 0a 08 d3 32 c0 39 74 24 14 7d 45 89 74 24 04 b8 ff


>>EIP; c01d23dd <dbJoin+7d/f0>   <=====

>>ecx; e0e08000 <_end+209eb828/3848b888>
>>edx; f615bf64 <_end+35d3f78c/3848b888>
>>edi; e8c6c010 <_end+2884f838/3848b888>
>>esp; e0e09cb0 <_end+209ed4d8/3848b888>

Trace; c01d1c95 <dbFreeBits+f5/2c0>
Trace; c0140de6 <read_cache_page+46/b0>
Trace; c01d18b3 <dbFreeDmap+43/e0>
Trace; c01cf75f <dbFree+17f/2b0>
Trace; c01e144a <txFreeMap+9a/310>
Trace; c01d41b8 <read_index_page+98/a0>
Trace; c01ca426 <xtTruncate+a96/d70>
Trace; c01dfbbd <txUnlock+fd/240>
Trace; c01e00bb <txCommit+2ab/2f0>
Trace; c01c13c0 <jfs_delete_inode+0/40>
Trace; c01c286b <freeZeroLink+ab/1c0>
Trace; c01c234e <jfs_unlink+13e/440>
Trace; c01c13c0 <jfs_delete_inode+0/40>
Trace; c01c13f8 <jfs_delete_inode+38/40>
Trace; c01692f0 <iput+130/2b0>
Trace; c015e5f2 <vfs_unlink+f2/1c0>
Trace; c015e852 <sys_unlink+192/2f0>
Trace; c010950f <system_call+33/38>

Code;  c01d23dd <dbJoin+7d/f0>
00000000 <_EIP>:
Code;  c01d23dd <dbJoin+7d/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01d23df <dbJoin+7f/f0>
   2:   cc                        int3
Code;  c01d23e0 <dbJoin+80/f0>
   3:   0a 08                     or     (%eax),%cl
Code;  c01d23e2 <dbJoin+82/f0>
   5:   d3                        (bad)
Code;  c01d23e3 <dbJoin+83/f0>
   6:   32 c0                     xor    %al,%al
Code;  c01d23e5 <dbJoin+85/f0>
   8:   39 74 24 14               cmp    %esi,0x14(%esp,1)
Code;  c01d23e9 <dbJoin+89/f0>
   c:   7d 45                     jge    53 <_EIP+0x53>
Code;  c01d23eb <dbJoin+8b/f0>
   e:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c01d23ef <dbJoin+8f/f0>
  12:   b8 ff 00 00 00            mov    $0xff,%eax

Happy to provide any further information...

kevin
