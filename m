Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbRE3Sbg>; Wed, 30 May 2001 14:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbRE3Sb0>; Wed, 30 May 2001 14:31:26 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:14342 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S261782AbRE3SbU>; Wed, 30 May 2001 14:31:20 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256A5C.006583B8.00@smtpnotes.altec.com>
Date: Wed, 30 May 2001 13:30:02 -0500
Subject: cs46xx oops in 2.4.5-ac4
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Since upgrading to 2.4.5-ac4 the Crystal Soundfusion card in my Thinkpad 600X
has stopped working.  Trying to play an audio file (with /usr/bin/play from sox
12.16) gives me an oops.  Here is the init stuff from dmesg for the sound card:

Crystal 4280/46xx + AC97 Audio, version 1.27.32, 13:05:58 May 29 2001
cs46xx: Card found at 0x50100000 and 0x50000000, IRQ 11
cs46xx: Thinkpad 600X/A20/T20 (1014:0153) at 0x50100000/0x50000000, IRQ 11
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)

And here is the oops info from ksymoops (apologies if my email program wraps any
lines; I intend to start using a decent mail program Real Soon Now):

ksymoops 2.4.1 on i686 2.4.5-ac4.  Options used
     -v /usr/src/linux-2.4.5-ac4/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac4/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0111f34>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: ccf7d884   ebx: 00000000   ecx: 00000286   edx: cca43f2c
esi: cca43f24   edi: ccf7d880   ebp: cca43f24   esp: cca43f08
ds: 0018   es: 0018   ss: 0018
Process sox (pid: 186, stackpage=cca43000)
Stack: ccf7d878 cca42000 c0105938 ffffffea cdcf7a20 00001000 ccf7d7f0 00000001
       cca42000 ccf7d884 00000000 c0105aa8 ccf7d878 ccf7d7c0 cdcf7a40 d0c75678
       ffffffea cdcf7a20 00001000 bffff870 00000000 ccf7d7f0 00000001 00000018
Call Trace: [<c0105938>] [<c0105aa8>] [<d0c75678>] [<c01225cb>] [<c012dd66>]
   [<c0106b27>]
Code: 89 13 51 9d 5b 5e c3 90 9c 58 fa 8b 4a 0c 8b 52 08 89 4a 04

>>EIP; c0111f34 <add_wait_queue_exclusive+1c/24>   <=====
Trace; c0105938 <__down+4c/a8>
Trace; c0105aa8 <__down_failed+8/c>
Trace; d0c75678 <[cs46xx].text.end+74/1dc>
Trace; c01225cb <generic_file_read+63/80>
Trace; c012dd66 <sys_write+8e/c4>
Trace; c0106b27 <system_call+33/38>
Code;  c0111f34 <add_wait_queue_exclusive+1c/24>
00000000 <_EIP>:
Code;  c0111f34 <add_wait_queue_exclusive+1c/24>   <=====
   0:   89 13                     mov    %edx,(%ebx)   <=====
Code;  c0111f36 <add_wait_queue_exclusive+1e/24>
   2:   51                        push   %ecx
Code;  c0111f37 <add_wait_queue_exclusive+1f/24>
   3:   9d                        popf
Code;  c0111f38 <add_wait_queue_exclusive+20/24>
   4:   5b                        pop    %ebx
Code;  c0111f39 <add_wait_queue_exclusive+21/24>
   5:   5e                        pop    %esi
Code;  c0111f3a <add_wait_queue_exclusive+22/24>
   6:   c3                        ret
Code;  c0111f3b <add_wait_queue_exclusive+23/24>
   7:   90                        nop
Code;  c0111f3c <remove_wait_queue+0/14>
   8:   9c                        pushf
Code;  c0111f3d <remove_wait_queue+1/14>
   9:   58                        pop    %eax
Code;  c0111f3e <remove_wait_queue+2/14>
   a:   fa                        cli
Code;  c0111f3f <remove_wait_queue+3/14>
   b:   8b 4a 0c                  mov    0xc(%edx),%ecx
Code;  c0111f42 <remove_wait_queue+6/14>
   e:   8b 52 08                  mov    0x8(%edx),%edx
Code;  c0111f45 <remove_wait_queue+9/14>
  11:   89 4a 04                  mov    %ecx,0x4(%edx)


