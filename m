Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSETMcF>; Mon, 20 May 2002 08:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSETMcE>; Mon, 20 May 2002 08:32:04 -0400
Received: from 217-79-104-247.adsl.griffin.net.uk ([217.79.104.247]:50983 "EHLO
	lemur.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S315943AbSETMcD>; Mon, 20 May 2002 08:32:03 -0400
Subject: OOPS: ext3/sparc badness
From: Beezly <beezly@beezly.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 May 2002 13:32:00 +0100
Message-Id: <1021897921.8474.8.camel@montgomery>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with an ext3 filesystem on sparc64 (an Ultra1).

kernel is: 

Linux lemur 2.4.19-pre7 #5 SMP Fri Apr 26 01:30:49 BST 2002 sparc64
unknown

and was compiled with gcc-3.0.4.

The ext3 filesystem is on an md-raid1 set and I get an oops after a
seemingly random amount of time. The kernel was compiled with gcc-3.0.4
because it appears 2.95 does not compile the md code correctly on Sparc
(see http://marc.theaimsgroup.com/?l=linux-raid&m=101981888804890&w=2). 
Here's the oops. I would be very happy to help debugging this problem.

Cheers,

Andrew Beresford

Oops follows...

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 000000000000070e
tsk->{mm,active_mm}->pgd = fffff8000155e000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
mrtg(14342): Oops
CPU[0]: local_irq_count[0] irqs_running[0]
TSTATE: 0000004411009607 TPC: 00000000004a2b3c TNPC: 00000000004a2b40 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: fffff8000074bb78 g1: 00000000004a2960 g2: 0000000000000001 g3: fffff800115cd068
g4: fffff80000000000 g5: 0000000000000001 g6: fffff80001564000 g7: 0000000000000001
o0: fffff80001564000 o1: 0000000000000000 o2: 0000000000ff0000 o3: 000000000000ff00
o4: 0000000000000001 o5: 0000000000000001 sp: fffff800015672c1 ret_pc: 00000000004a2b20
l0: fffff800104f0400 l1: fffff8001257fd20 l2: 00000000006d1800 l3: fffff80013e913b0
l4: 000000000000000a l5: fffff80003e0a011 l6: 00000000005f9400 l7: 0000000000649c00
i0: fffffffffffffff3 i1: fffff800104f0400 i2: 00000000005fad40 i3: 00000000004a2b00
i4: 0000000000000005 i5: 0000000000000003 i6: fffff80001567391 i7: 00000000004784d0
Caller[00000000004784d0]
Caller[000000000047904c]
Caller[00000000004799ec]
Caller[00000000004751d0]
Caller[00000000004112f4]
Caller[00000000702b5040]
Instruction DUMP: 94102000  15003fc0  d25fa7e7 <d6024000> 1300003f  a12ae018  92126300  920ac009  940ac00a 


>>PC;  004a2b3c <ext3_lookup+3c/c0>   <=====

>>g0; fffff8000074bb78 <END_OF_CODE+fffff7fffe748eb5/????>
>>g1; 004a2960 <ext3_find_entry+1a0/340>
>>g3; fffff800115cd068 <END_OF_CODE+fffff8000f5ca3a5/????>
>>g4; fffff80000000000 <END_OF_CODE+fffff7fffdffd33d/????>
>>g6; fffff80001564000 <END_OF_CODE+fffff7ffff56133d/????>
>>o0; fffff80001564000 <END_OF_CODE+fffff7ffff56133d/????>
>>o2; 00ff0000 <_end+8b44f8/18c44f8>
>>o3; 0000ff00 Before first symbol
>>sp; fffff800015672c1 <END_OF_CODE+fffff7ffff5645fe/????>
>>ret_pc; 004a2b20 <ext3_lookup+20/c0>
>>l0; fffff800104f0400 <END_OF_CODE+fffff8000e4ed73d/????>
>>l1; fffff8001257fd20 <END_OF_CODE+fffff8001057d05d/????>
>>l2; 006d1800 <cdev_hashtable+370/400>
>>l3; fffff80013e913b0 <END_OF_CODE+fffff80011e8e6ed/????>
>>l5; fffff80003e0a011 <END_OF_CODE+fffff80001e0734e/????>
>>l6; 005f9400 <rdwr_pipe_fops+80/90>
>>l7; 00649c00 <dcache_lock+0/40>
>>i0; fffffffffffffff3 <END_OF_CODE+fffffffffdffd330/????>
>>i1; fffff800104f0400 <END_OF_CODE+fffff8000e4ed73d/????>
>>i2; 005fad40 <ext3_dir_inode_operations+0/80>
>>i3; 004a2b00 <ext3_lookup+0/c0>
>>i6; fffff80001567391 <END_OF_CODE+fffff7ffff5646ce/????>
>>i7; 004784d0 <real_lookup+f0/1a0>

Trace; 004784d0 <real_lookup+f0/1a0>
Trace; 0047904c <link_path_walk+90c/c20>
Trace; 004799ec <__user_walk+4c/80>
Trace; 004751d0 <sys_stat64+10/a0>
Trace; 004112f4 <linux_sparc_syscall32+34/40>
Trace; 702b5040 <END_OF_CODE+6e2b237d/????>

Code;  004a2b30 <ext3_lookup+30/c0>
00000000 <_PC>:
Code;  004a2b30 <ext3_lookup+30/c0>
   0:   94 10 20 00       clr  %o2
Code;  004a2b34 <ext3_lookup+34/c0>
   4:   15 00 3f c0       sethi  %hi(0xff0000), %o2
Code;  004a2b38 <ext3_lookup+38/c0>
   8:   d2 5f a7 e7       unknown
Code;  004a2b3c <ext3_lookup+3c/c0>   <=====
   c:   d6 02 40 00       ld  [ %o1 ], %o3   <=====
Code;  004a2b40 <ext3_lookup+40/c0>
  10:   13 00 00 3f       sethi  %hi(0xfc00), %o1
Code;  004a2b44 <ext3_lookup+44/c0>
  14:   a1 2a e0 18       sll  %o3, 0x18, %l0
Code;  004a2b48 <ext3_lookup+48/c0>
  18:   92 12 63 00       or  %o1, 0x300, %o1
Code;  004a2b4c <ext3_lookup+4c/c0>
  1c:   92 0a c0 09       and  %o3, %o1, %o1
Code;  004a2b50 <ext3_lookup+50/c0>
  20:   94 0a c0 0a       and  %o3, %o2, %o2


1 warning issued.  Results may not be reliable.

