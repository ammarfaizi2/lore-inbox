Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263124AbTCSTGZ>; Wed, 19 Mar 2003 14:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263125AbTCSTGZ>; Wed, 19 Mar 2003 14:06:25 -0500
Received: from smtp-out.comcast.net ([24.153.64.115]:59461 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S263124AbTCSTGX>;
	Wed, 19 Mar 2003 14:06:23 -0500
Date: Wed, 19 Mar 2003 14:14:50 -0500
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: 2.5.65 jaz drive devfs oops
To: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1048533291.e063f2@bittwiddlers.com>
Message-id: <20030319191450.GA23769@bittwiddlers.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_6UwJg5ftbzO8uzlKJ+I1/g)"
User-Agent: Mutt/1.5.3i
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_6UwJg5ftbzO8uzlKJ+I1/g)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline


Once the jaz drive spins down and then I try to access it again it either
doesn't respond ever, hangs the process permenantly, or generates the
attached oops.  If anyone wants more info let me know and I'll reboot back
with devfs turned on

-- 
  Matthew Harrell                          Nondeterminism means never
  Bit Twiddlers, Inc.                       having to say you are wrong.
  mharrell@bittwiddlers.com     

--Boundary_(ID_6UwJg5ftbzO8uzlKJ+I1/g)
Content-type: text/plain; charset=us-ascii; NAME=oops.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=oops.txt

sdb: Spinning up disk...........ready
SCSI device sdb: 2091050 512-byte hdwr sectors (1071 MB)
sdb: Write Protect is off
sdb: Mode Sense: 39 00 10 08
SCSI device sdb: drive cache: write back
Unable to handle kernel paging request at virtual address 6c2e736d
 printing eip:
c01ab5b3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c01ab5b3>]    Not tainted
EFLAGS: 00010202
EIP is at devfs_unregister+0x23/0x50
eax: 6c2e736d   ebx: c15f6240   ecx: c15740fc   edx: 00000000
esi: 001fe7e0   edi: c15717e0   ebp: 00000001   esp: d1b13d10
ds: 007b   es: 007b   ss: 0068
Process tcsh (pid: 22836, threadinfo=d1b12000 task=c40eec60)
Stack: 00000000 c017154e c1574150 c0187ce3 c15f6240 00000005 c15717e0 c0188101 
       d7e08740 00000004 0000001e 00000001 fffffffa c15f2c00 fffffffa c0280b9c 
       00000000 00000001 00000000 d7e08740 c15717e0 00000001 c01608ec d7e08740 
Call Trace:
 [<c017154e>] invalidate_device+0x6e/0x90
 [<c0187ce3>] delete_partition+0x83/0xa0
 [<c0188101>] rescan_partitions+0x151/0x160
 [<c0280b9c>] sd_open+0xac/0x120
 [<c01608ec>] do_open+0xfc/0x410
 [<c0160c7e>] blkdev_get+0x7e/0xa0
 [<c0160730>] __check_disk_change+0x40/0x70
 [<c01abc35>] check_disc_changed+0x45/0x50
 [<c01abc6f>] scan_dir_for_removable+0x2f/0x80
 [<c01ac237>] devfs_readdir+0x197/0x220
 [<c016a82e>] vfs_readdir+0x9e/0xa0
 [<c016ab50>] filldir64+0x0/0x120
 [<c016ad0a>] sys_getdents64+0x9a/0xdd
 [<c016ab50>] filldir64+0x0/0x120
 [<c0169b71>] do_fcntl+0xe1/0x1b0
 [<c0158300>] default_llseek+0x0/0xd0
 [<c0158453>] sys_lseek+0x83/0xa0
 [<c010941f>] syscall_call+0x7/0xb

Code: f0 81 28 00 00 00 01 0f 85 2b 23 00 00 89 5c 24 04 8b 43 20 

--Boundary_(ID_6UwJg5ftbzO8uzlKJ+I1/g)
Content-type: text/plain; charset=us-ascii; NAME=oops-trace.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=oops-trace.txt

>>EIP; c01ab5b3 <devfs_unregister+23/50>   <=====

>>eax; 6c2e736d <__crc_ide_do_reset+63b51/399654>
>>ebx; c15f6240 <__crc_global_cache_flush+72dda/2b10e2>
>>ecx; c15740fc <__crc_memcpy_tokerneliovec+316074/3253de>
>>esi; 001fe7e0 <__crc_smp_call_function+b280f/3c30bf>
>>edi; c15717e0 <__crc_memcpy_tokerneliovec+313758/3253de>
>>esp; d1b13d10 <__crc_pci_scan_slot+1d8152/25ce78>

Trace; c017154e <invalidate_device+6e/90>
Trace; c0187ce3 <delete_partition+83/a0>
Trace; c0188101 <rescan_partitions+151/160>
Trace; c0280b9c <sd_open+ac/120>
Trace; c01608ec <do_open+fc/410>
Trace; c0160c7e <blkdev_get+7e/a0>
Trace; c0160730 <__check_disk_change+40/70>
Trace; c01abc35 <check_disc_changed+45/50>
Trace; c01abc6f <scan_dir_for_removable+2f/80>
Trace; c01ac237 <devfs_readdir+197/220>
Trace; c016a82e <vfs_readdir+9e/a0>
Trace; c016ab50 <filldir64+0/120>
Trace; c016ad0a <sys_getdents64+9a/dd>
Trace; c016ab50 <filldir64+0/120>
Trace; c0169b71 <do_fcntl+e1/1b0>
Trace; c0158300 <default_llseek+0/d0>
Trace; c0158453 <sys_lseek+83/a0>
Trace; c010941f <syscall_call+7/b>

Code;  c01ab5b3 <devfs_unregister+23/50>
00000000 <_EIP>:
Code;  c01ab5b3 <devfs_unregister+23/50>   <=====
   0:   f0 81 28 00 00 00 01      lock subl $0x1000000,(%eax)   <=====
Code;  c01ab5ba <devfs_unregister+2a/50>
   7:   0f 85 2b 23 00 00         jne    2338 <_EIP+0x2338>
Code;  c01ab5c0 <devfs_unregister+30/50>
   d:   89 5c 24 04               mov    %ebx,0x4(%esp,1)
Code;  c01ab5c4 <devfs_unregister+34/50>
  11:   8b 43 20                  mov    0x20(%ebx),%eax

--Boundary_(ID_6UwJg5ftbzO8uzlKJ+I1/g)--
