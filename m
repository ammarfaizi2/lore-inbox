Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRGXAhz>; Mon, 23 Jul 2001 20:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266040AbRGXAhp>; Mon, 23 Jul 2001 20:37:45 -0400
Received: from c954190-a.saltlk1.ut.home.com ([24.13.131.33]:33787 "EHLO
	mail.leapdragon.net") by vger.kernel.org with ESMTP
	id <S266006AbRGXAhb>; Mon, 23 Jul 2001 20:37:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Aron Hsiao <thoth@leapdragon.net>
Reply-To: thoth@leapdragon.net
Organization: The Inevitable Magic Company
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops! (info attached) 2.4.x+EtherTalk+LPRng
Date: Mon, 23 Jul 2001 18:34:12 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072318341200.01363@newton>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Disclaimer: IANAKH (I am not a kernel hacker.)

Oops! SYMPTOM:

Printing to an EtherTalk printer using netatalk-1.5pre6 and kernel
2.4.[2,5,6,7] generates an Oops! (Oops! and related details
attached at end of message.)


Configuration (software):

2.4 kernels (2.4.2 and 2.4.5-2.4.7)
netatalk-1.5pre6
LPRng 3.7.4
glibc 2.2
gcc 2.96


Configuration (hardware):

Athlon-C 1.0GHz (not overclocked)
Asus A7V133 + 768MB premium brand RAM
AMD PCNet32 PCI Ethernet*
  (*device is behind a DEC 21152 PCI bridge)
Apple LaserWriter IIg on EtherTalk

           CPU0
  0:     351613          XT-PIC  timer
  1:       6651          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      28495          XT-PIC  sym53c8xx, PCnet/FAST 79C971
  9:        105          XT-PIC  bttv, sym53c8xx, usb-uhci, usb-uhci
 10:         61          XT-PIC  sym53c8xx
 11:     333887          XT-PIC  es1371, nvidia
 12:     102148          XT-PIC  PS/2 Mouse
 14:        132          XT-PIC  ide0
 15:         79          XT-PIC  ide1
NMI:          0
ERR:          0


OTHER INFO:

I didn't experience this problem under 2.2 kernels, though of
course this proves nothing... System is under moderate load
and may enjoy uptimes of several weeks under heavy memory
pressure without problems -- until I try to print via EtherTalk.

Usually the first spooled job prints okay; it is on the second
job that the OOPS usually seems to occur and the system is
then completely wedged... Magic SysRq doesn't work, have to
reset hard.

Thanks in advance for help, anyone! I'm not subscribed to the 
list, but I watch the archives daily.


-------------------------------------------

OOPS (already ksymoops'ed) DETAILS:

Unable to handle kernel paging request at virtual address fffffffc
c0110633
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0110633>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010017
eax: e8afec28   ebx: 00000000   ecx: 00000001   edx: e8afec2c
esi: e9c22200   edi: fffffff8   ebp: c02e1f1c   esp: c02e1f00
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02e1000)
Stack: e8afec2c 00000001 00000286 00000001 e8afec28 e9c22200 fffffffd 00000046
       c821b106 e8ba0000 c02dcd00 ee978d40 00000000 e9c22200 ee978140 c021a7f1
       e9c22200 ee978440 ee97849c c021b60b 00000287 00000000 c021b6d5 ee978140
Call Trace: [<c021b106>] [<c021a7f1>] [<c021b60b>] [<c021b6d5>] [<c021ec82>] [<c011651b>] [<c01080ec>]
       [<c01051a0>] [<c01051a0>] p<c0106d54>] [<c01051a0>] [<c01051a0>] [<c01051c3>] [<c0105242>] [<c0105000>]
Code: 8b 4f 04 8b 1b 8b 01 85 45 f0 74 4f 31 c0 9c 5e fa c7 01 00
 
>>EIP; c0110633 <__wake_up+33/a0>   <=====
Trace; c021b106 <sock_def_write_space+36/90>
Trace; c021a7f1 <sock_wfree+21/40>
Trace; c021b60b <kfree_skbmem+b/60>
Trace; c021b6d5 <__kfree_skb+75/120>
Trace; c021ec82 <net_tx_action+52/c0>
Trace; c011651b <do_softirq+4b/90>
Trace; c01080ec <do_IRQ+9c/b0>
Trace; c01051a0 <default_idle+0/30>
Trace; c01051a0 <default_idle+0/30>
Code;  c0110633 <__wake_up+33/a0>
00000000 <_EIP>:
Code;  c0110633 <__wake_up+33/a0>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0110636 <__wake_up+36/a0>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0110638 <__wake_up+38/a0>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c011063a <__wake_up+3a/a0>
   7:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c011063d <__wake_up+3d/a0>
   a:   74 4f                     je     5b <_EIP+0x5b> c011068e <__wake_up+8e/a0>
Code;  c011063f <__wake_up+3f/a0>
   c:   31 c0                     xor    %eax,%eax
Code;  c0110641 <__wake_up+41/a0>
   e:   9c                        pushf
Code;  c0110642 <__wake_up+42/a0>
   f:   5e                        pop    %esi
Code;  c0110643 <__wake_up+43/a0>
  10:   fa                        cli
Code;  c0110644 <__wake_up+44/a0>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
 
Kernel panic: Aiee, killing interrupt handler!
