Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbRECVLF>; Thu, 3 May 2001 17:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRECVKy>; Thu, 3 May 2001 17:10:54 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:1066 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135222AbRECVKm>; Thu, 3 May 2001 17:10:42 -0400
Message-ID: <3AF1C946.6060602@blue-labs.org>
Date: Thu, 03 May 2001 14:10:30 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9+) Gecko/20010503
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-drivers@lists.quicknet.net
Subject: [OOPS] Quicknet PhoneJACK usage in 2.4.4 isn't a good thing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.4, nothing special.  PCI PhoneJACK.

00:0a.0 Multimedia audio controller: Quicknet Technologies Inc: Unknown 
device 0500
       Flags: medium devsel
       I/O ports at a400 [size=32]
       Memory at c9000000 (32-bit, non-prefetchable) [size=4K]
       I/O ports at a000 [size=32]
       Memory at c8800000 (32-bit, non-prefetchable) [size=4K]

$ cat /proc/ixj

$Id: ixj.c,v 3.31 2000/04/14 19:24:47 jaugenst Exp $
$Id: ixj.h,v 3.14 2000/03/30 22:06:48 eokerson Exp $
$Id: ixjuser.h,v 3.21 2001/04/03 23:42:00 eokerson Exp $
Card Num 0
DSP Base Address 0xa400
XILINX Base Address 0xa410
DSP Type 8022
DSP Version 01.17
Serial Number 500414e7
Card Type = Internet PhoneJACK PCI
Readers 0
Writers 0
FSK words 0
Capabilities 12
DSP Processor load 0
Caller ID data not sent
Caller ID Date
Caller ID Time
Caller ID Name
Caller ID Number
Play CODEC NO CODEC CHOSEN
Record CODEC NO CODEC CHOSEN
AEC OFF
Hook state 0
Port POTS
SLIC state STANDBY


Problems:

1) loading the ixj module while X is running causes a kernel OOPS in the 
swapper, killing the machine flat out.
2) after successfully loading the modules and starting X to use gnophone 
GUI application, answering a call will cause a crash.  Sometimes just 
the inbound ringing is sufficient to crash.

The CVS version of these modules doesn't kill the machine but it still 
OOPS and a reboot is necessary to remove the broken modules.

Here is an oops of the module loading.  I'll be posting more oopses as I 
can catch them.

David

==============================================================

Unable to handle kernel paging request at virtual address 67615d6c   
*pde = 00000000                                                      
Oops: 0000                                                           
CPU:    0                                                            
EIP:    0010:[<d0a90c81>]              
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202                       
eax: 67615d64   ebx: cc600000   ecx: 00600000   edx: 0000607c
esi: d0a8a5c0   edi: 00000000   ebp: d0a98180   esp: c03a3f14
ds: 0018   es: 0018   ss: 0018                              
Process swapper (pid: 0, stackpage=c03a3000)
Stack: cc600000 d0a8a606 cc600000 00000000 d0a8a5c0 00000000 c03a3fa4 
00000000
      c011a315 00000001 c011a6b6 00000000 00000000 c03e25a0 00000000 
c03a3fa4
      c040d24c c0119fe2 c037d7f8 c0117bbf 00000000 c0117af8 00000000 
00000001
Call Trace: [<d0a8a606>] [<d0a8a5c0>] [<c011a315>] [<c011a6b6>] 
[<c0119fe2>] [<c0117bbf>] [<c0117af8>]
      [<c0117a02>] [<c0107e99>] [<c0105118>] [<c0105118>] [<c0106afc>] 
[<c0105118>] [<c0105118>] [<c0100018>]
      [<c010513b>] [<c010519e>] [<c0105000>] [<c0100197>]               
                                     
Code: 8b 40 08 85 c0 74 09 50 e8 aa 5f 69 ef 83 c4 04 8b 83 08 0c

 >>EIP; d0a90c81 <[ixj].rodata.start+ba1/1031>   <=====
Trace; d0a8a606 <[ixj]ixj_daa_write+7f2/d2c>
Trace; d0a8a5c0 <[ixj]ixj_daa_write+7ac/d2c>
Trace; c011a315 <update_wall_time+3d/40>
Trace; c011a6b6 <timer_bh+20e/248>
Trace; c0119fe2 <tqueue_bh+16/1c>
Trace; c0117bbf <bh_action+1b/60>
Trace; c0117af8 <tasklet_hi_action+38/5c>
Trace; c0117a02 <do_softirq+42/64>
Trace; c0107e99 <do_IRQ+9d/b0>
Trace; c0105118 <default_idle+0/28>
Trace; c0105118 <default_idle+0/28>
Trace; c0106afc <ret_from_intr+0/20>
Trace; c0105118 <default_idle+0/28>
Trace; c0105118 <default_idle+0/28>
Trace; c0100018 <startup_32+18/a5>
Trace; c010513b <default_idle+23/28>
Trace; c010519e <cpu_idle+3e/54>
Trace; c0105000 <init+0/108>
Trace; c0100197 <L6+0/2>

Code;  d0a90c81 <[ixj].rodata.start+ba1/1031>
00000000 <_EIP>:
Code;  d0a90c81 <[ixj].rodata.start+ba1/1031>   <=====
  0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  d0a90c84 <[ixj].rodata.start+ba4/1031>
  3:   85 c0                     test   %eax,%eax
Code;  d0a90c86 <[ixj].rodata.start+ba6/1031>


