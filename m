Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSK0QCM>; Wed, 27 Nov 2002 11:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSK0QCM>; Wed, 27 Nov 2002 11:02:12 -0500
Received: from e-gate.pl ([212.244.191.5]:51362 "EHLO bukszpryt.e-gate.pl")
	by vger.kernel.org with ESMTP id <S262924AbSK0QCL>;
	Wed, 27 Nov 2002 11:02:11 -0500
Date: Wed, 27 Nov 2002 17:09:22 +0100 (CET)
From: Leszek Matok <Lam@Lam.pl>
X-X-Sender: lam@bukszpryt.e-gate.pl
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.20-rc4-ac1
Message-ID: <Pine.LNX.4.44.0211271645460.5983-100000@bukszpryt.e-gate.pl>
Organization: LAC Entertainment
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have a machine with few hard discs connected via 3 different IDE 
controllers. I've decided to use recent -ac kernel to test its functionality 
with this hardware and it seems to be working to some point... I'm testing 
stability of the configuration running multiple copies of badblocks -w for all 
my hdds, and after 2 hours of testing it said:
kernel BUG at buffer.c:510!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013acae>]    Not tainted
EFLAGS: 00010286
eax: db000000   ebx: 00000002   ecx: dbdef9c0   edx: c02ccc8c
esi: dbdef9c0   edi: 00000001   ebp: dbdefec0   esp: d5827ee4
ds: 0018   es: 0018   ss: 0018
Process badblocks (pid: 242, stackpage=d5827000)
Stack: 00000002 c013b5fb dbdef9c0 00000002 dbdef9c0 00000800 c013c172 dbdef9c0 
       00000400 00000000 00000000 00000400 00000800 00000400 c013c7f9 dfe02340 
       c115818c 00000400 00000800 c012bebb c115818c 00000400 00000800 00000800 
Call Trace:    [<c013b5fb>] [<c013c172>] [<c013c7f9>] [<c012bebb>] [<c0139593>]
  [<c0107277>]

Code: 0f 0b fe 01 92 e5 23 c0 8b 02 85 c0 75 07 89 0a 89 49 24 8b 

Because it's "kernel BUG", I've decided to report this to you. One of 
badblocks processes segfaulted - it was checking /dev/hdj, which is connected 
through on-board VIA controller, and the badblocks checking /dev/hdi on the 
same cable at the same time didn't produce any errors, so it looks rather as a 
kernel problem, not a hardware-related one. I'm including ksymoops output:

>>EIP; c013acae <file_fsync+23e/320>   <=====

>>eax; db000000 <___strtok+1ad0bd2c/20563d2c>
>>ecx; dbdef9c0 <___strtok+1bafb6ec/20563d2c>
>>edx; c02ccc8c <zone_table+f64/1c50>
>>esi; dbdef9c0 <___strtok+1bafb6ec/20563d2c>
>>ebp; dbdefec0 <___strtok+1bafbbec/20563d2c>
>>esp; d5827ee4 <___strtok+15533c10/20563d2c>

Trace; c013b5fb <set_buffer_flushtime+7b/a0>
Trace; c013c172 <create_empty_buffers+662/680>
Trace; c013c7f9 <block_prepare_write+79/80>
Trace; c012bebb <generic_file_write+46b/28a0>
Trace; c0139593 <default_llseek+3d3/ca0>
Trace; c0107277 <__up_wakeup+1287/1660>

Code;  c013acae <file_fsync+23e/320>
00000000 <_EIP>:
Code;  c013acae <file_fsync+23e/320>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013acb0 <file_fsync+240/320>
   2:   fe 01                     incb   (%ecx)
Code;  c013acb2 <file_fsync+242/320>
   4:   92                        xchg   %eax,%edx
Code;  c013acb3 <file_fsync+243/320>
   5:   e5 23                     in     $0x23,%eax
Code;  c013acb5 <file_fsync+245/320>
   7:   c0 8b 02 85 c0 75 07      rorb   $0x7,0x75c08502(%ebx)
Code;  c013acbc <file_fsync+24c/320>
   e:   89 0a                     mov    %ecx,(%edx)
Code;  c013acbe <file_fsync+24e/320>
  10:   89 49 24                  mov    %ecx,0x24(%ecx)
Code;  c013acc1 <file_fsync+251/320>
  13:   8b 00                     mov    (%eax),%eax

I hope someone on the list knows what's happening and finds this information 
useful. I'm not subscribed, but I'll check in the archives if someone is 
answering without Cc: to me :)

Lam
P.S. I'm not using taskfile IO. Maybe I should?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE95O40GU+CzS/wSzYRAhQzAJ4iOIFfAhLTjW234EV01dPvCc48GACfRoLi
R93DO6ahuzeFErlMYMpWWrk=
=FLUd
-----END PGP SIGNATURE-----

