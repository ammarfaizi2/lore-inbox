Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263009AbREaE0r>; Thu, 31 May 2001 00:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbREaE0h>; Thu, 31 May 2001 00:26:37 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:62733 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S263009AbREaE0b>; Thu, 31 May 2001 00:26:31 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256A5D.001829A5.00@smtpnotes.altec.com>
Date: Wed, 30 May 2001 23:25:41 -0500
Subject: Re: cs46xx oops in 2.4.5-ac4
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This problem is still present in 2.4.5-ac5.  Here's the latest oops:

ksymoops 2.4.1 on i686 2.4.5-ac5.  Options used
     -v /usr/src/linux-2.4.5-ac5/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac5/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0111f54>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: cfa78e84   ebx: 00000000   ecx: 00000286   edx: cc961f2c
esi: cc961f24   edi: cfa78e80   ebp: cc961f24   esp: cc961f08
ds: 0018   es: 0018   ss: 0018
Process sox (pid: 195, stackpage=cc961000)
Stack: cfa78e78 cc960000 c0105938 ffffffea cc9ce560 00001000 cfa78df0 00000001
       cc960000 cfa78e84 00000000 c0105aa8 cfa78e78 cfa78dc0 cc9ce580 d0c676b4
       ffffffea cc9ce560 00001000 bffff830 00000000 cfa78df0 c0267c40 00000000
Call Trace: [<c0105938>] [<c0105aa8>] [<d0c676b4>] [<c0119baa>] [<c012dd86>]
   [<c0106b27>]
Code: 89 13 51 9d 5b 5e c3 90 9c 58 fa 8b 4a 0c 8b 52 08 89 4a 04

>>EIP; c0111f54 <add_wait_queue_exclusive+1c/24>   <=====
Trace; c0105938 <__down+4c/a8>
Trace; c0105aa8 <__down_failed+8/c>
Trace; d0c676b4 <[cs46xx].text.end+74/1e0>
Trace; c0119baa <tqueue_bh+16/1c>
Trace; c012dd86 <sys_write+8e/c4>
Trace; c0106b27 <system_call+33/38>
Code;  c0111f54 <add_wait_queue_exclusive+1c/24>
00000000 <_EIP>:
Code;  c0111f54 <add_wait_queue_exclusive+1c/24>   <=====
   0:   89 13                     mov    %edx,(%ebx)   <=====
Code;  c0111f56 <add_wait_queue_exclusive+1e/24>
   2:   51                        push   %ecx
Code;  c0111f57 <add_wait_queue_exclusive+1f/24>
   3:   9d                        popf
Code;  c0111f58 <add_wait_queue_exclusive+20/24>
   4:   5b                        pop    %ebx
Code;  c0111f59 <add_wait_queue_exclusive+21/24>
   5:   5e                        pop    %esi
Code;  c0111f5a <add_wait_queue_exclusive+22/24>
   6:   c3                        ret
Code;  c0111f5b <add_wait_queue_exclusive+23/24>
   7:   90                        nop
Code;  c0111f5c <remove_wait_queue+0/14>
   8:   9c                        pushf
Code;  c0111f5d <remove_wait_queue+1/14>
   9:   58                        pop    %eax
Code;  c0111f5e <remove_wait_queue+2/14>
   a:   fa                        cli
Code;  c0111f5f <remove_wait_queue+3/14>
   b:   8b 4a 0c                  mov    0xc(%edx),%ecx
Code;  c0111f62 <remove_wait_queue+6/14>
   e:   8b 52 08                  mov    0x8(%edx),%edx
Code;  c0111f65 <remove_wait_queue+9/14>
  11:   89 4a 04                  mov    %ecx,0x4(%edx)


