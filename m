Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289741AbSAWJMa>; Wed, 23 Jan 2002 04:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289746AbSAWJMV>; Wed, 23 Jan 2002 04:12:21 -0500
Received: from cal056302.student.utwente.nl ([130.89.230.202]:51205 "EHLO
	cal056302.student.utwente.nl") by vger.kernel.org with ESMTP
	id <S289741AbSAWJMI>; Wed, 23 Jan 2002 04:12:08 -0500
Date: Wed, 23 Jan 2002 10:11:44 +0100 (CET)
From: Jurriaan Wijnberg <jur@cal056302.student.utwente.nl>
X-X-Sender: jur@cal056302.student.utwente.nl
Reply-To: Jurriaan Wijnberg <jurriaan@wijnberg.org>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.5.3-pre3 (scheduler?)
Message-ID: <Pine.LNX.4.44.0201231004290.8908-100000@cal056302.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I got an Oops in 2.5.3-pre3

It happens when a cdrom is mounted and execing: eject. 
When cdrom is not mounted the drive ejects as usual.

I think it is somewhere in the scheduler code.
Oops and full trace below.

Regards,

Jurriaan Wijnberg
ps. I'm not on the list, so please CC


Unable to handle kernel NULL pointer dereference at virtual address 00000277
c0114aa6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0114aa6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: 0000008a   ebx: ceb1a000   ecx: c02ebef4   edx: 00000253
esi: c02eba80   edi: c02eb500   ebp: c02b3e9c   esp: c02b3e88
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: ceb1be94 ceb1becc 00000086 c02b3e98 00000046 c02b3ebc c0115425 ceb1a000 
       00000000 cfe71c50 c0317504 00000082 00000001 00000000 c01b3005 cfe71c50 
       c01d2b1f cfe71c50 cfe71c50 00000001 c0317504 00000003 00000001 00000001 
Call Trace: [<c0115425>] [<c01b3005>] [<c01d2b1f>] [<c01dd81f>] [<c01de506>] 
   [<c01d461d>] [<c01de444>] [<c01097cf>] [<c0109936>] [<c0106ba0>] [<c0106ba0>] 
   [<c0106ba0>] [<c0106ba0>] [<c0106bc3>] [<c0106c12>] [<c0105000>] [<c0105019>] 
Code: 8b 42 24 39 43 24 7d 0a 8b 42 14 c7 42 14 01 00 00 00 be 01

>>EIP; c0114aa6 <try_to_wake_up+f6/11c>   <=====
Trace; c0115424 <complete+40/60>
Trace; c01b3004 <end_that_request_last+10/1c>
Trace; c01d2b1e <ide_end_request+be/d8>
Trace; c01dd81e <cdrom_end_request+62/6c>
Trace; c01de506 <cdrom_pc_intr+c2/1ac>
Trace; c01d461c <ide_intr+b8/110>
Trace; c01de444 <cdrom_pc_intr+0/1ac>
Trace; c01097ce <handle_IRQ_event+2e/58>
Trace; c0109936 <do_IRQ+6a/a8>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106bc2 <default_idle+22/28>
Trace; c0106c12 <cpu_idle+2a/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105018 <rest_init+18/1c>
Code;  c0114aa6 <try_to_wake_up+f6/11c>
00000000 <_EIP>:
Code;  c0114aa6 <try_to_wake_up+f6/11c>   <=====
   0:   8b 42 24                  mov    0x24(%edx),%eax   <=====
Code;  c0114aa8 <try_to_wake_up+f8/11c>
   3:   39 43 24                  cmp    %eax,0x24(%ebx)
Code;  c0114aac <try_to_wake_up+fc/11c>
   6:   7d 0a                     jge    12 <_EIP+0x12> c0114ab8 <try_to_wake_up+108/11c>
Code;  c0114aae <try_to_wake_up+fe/11c>
   8:   8b 42 14                  mov    0x14(%edx),%eax
Code;  c0114ab0 <try_to_wake_up+100/11c>
   b:   c7 42 14 01 00 00 00      movl   $0x1,0x14(%edx)
Code;  c0114ab8 <try_to_wake_up+108/11c>
  12:   be 01 00 00 00            mov    $0x1,%esi

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000277
c0114aa6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0114aa6>]    Not tainted
EFLAGS: 00010007
eax: 00000082   ebx: cf326000   ecx: c02ebeb4   edx: 00000253
esi: c02eba80   edi: c02eb500   ebp: c02b3d28   esp: c02b3d14
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: cf327f84 c029c248 00000001 c02b3d24 00000046 c02b3d4c c011535f cf326000 
       00000000 fffffc0e 00000092 00000001 00000086 00000001 c029c260 c0117d63 
       c02f0741 00000046 c0117ca4 0000000f 00000000 c0114198 00000277 c0114169 
Call Trace: [<c011535f>] [<c0117d63>] [<c0117ca4>] [<c0114198>] [<c0114169>] 
   [<c0108aa0>] [<c01144e7>] [<c0114198>] [<c01d2b91>] [<c01d8b57>] [<c01d7e50>] 
   [<c01d8b57>] [<c01de5f0>] [<c01d0f16>] [<c010865c>] [<c0114aa6>] [<c0115425>] 
   [<c01b3005>] [<c01d2b1f>] [<c01dd81f>] [<c01de506>] [<c01d461d>] [<c01de444>] 
   [<c01097cf>] [<c0109936>] [<c0106ba0>] [<c0106ba0>] [<c0106ba0>] [<c0106ba0>] 
   [<c0106bc3>] [<c0106c12>] [<c0105000>] [<c0105019>] 
Code: 8b 42 24 39 43 24 7d 0a 8b 42 14 c7 42 14 01 00 00 00 be 01 

>>EIP; c0114aa6 <try_to_wake_up+f6/11c>   <=====
Trace; c011535e <__wake_up+42/64>
Trace; c0117d62 <release_console_sem+72/78>
Trace; c0117ca4 <printk+104/110>
Trace; c0114198 <do_page_fault+0/498>
Trace; c0114168 <bust_spinlocks+40/4c>
Trace; c0108aa0 <die+44/50>
Trace; c01144e6 <do_page_fault+34e/498>
Trace; c0114198 <do_page_fault+0/498>
Trace; c01d2b90 <ide_set_handler+58/64>
Trace; c01d8b56 <piix_dmaproc+22/2c>
Trace; c01d7e50 <ide_dmaproc+1cc/32c>
Trace; c01d8b56 <piix_dmaproc+22/2c>
Trace; c01de5f0 <cdrom_do_pc_continuation+0/30>
Trace; c01d0f16 <atapi_output_bytes+3e/68>
Trace; c010865c <error_code+34/3c>
Trace; c0114aa6 <try_to_wake_up+f6/11c>
Trace; c0115424 <complete+40/60>
Trace; c01b3004 <end_that_request_last+10/1c>
Trace; c01d2b1e <ide_end_request+be/d8>
Trace; c01dd81e <cdrom_end_request+62/6c>
Trace; c01de506 <cdrom_pc_intr+c2/1ac>
Trace; c01d461c <ide_intr+b8/110>
Trace; c01de444 <cdrom_pc_intr+0/1ac>
Trace; c01097ce <handle_IRQ_event+2e/58>
Trace; c0109936 <do_IRQ+6a/a8>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106bc2 <default_idle+22/28>
Trace; c0106c12 <cpu_idle+2a/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105018 <rest_init+18/1c>
Code;  c0114aa6 <try_to_wake_up+f6/11c>
00000000 <_EIP>:
Code;  c0114aa6 <try_to_wake_up+f6/11c>   <=====
   0:   8b 42 24                  mov    0x24(%edx),%eax   <=====
Code;  c0114aa8 <try_to_wake_up+f8/11c>
   3:   39 43 24                  cmp    %eax,0x24(%ebx)
Code;  c0114aac <try_to_wake_up+fc/11c>
   6:   7d 0a                     jge    12 <_EIP+0x12> c0114ab8 <try_to_wake_up+108/11c>
Code;  c0114aae <try_to_wake_up+fe/11c>
   8:   8b 42 14                  mov    0x14(%edx),%eax
Code;  c0114ab0 <try_to_wake_up+100/11c>
   b:   c7 42 14 01 00 00 00      movl   $0x1,0x14(%edx)
Code;  c0114ab8 <try_to_wake_up+108/11c>
  12:   be 01 00 00 00            mov    $0x1,%esi

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000277
c0114aa6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0114aa6>]    Not tainted
EFLAGS: 00010007
eax: 00000082   ebx: c1438000   ecx: cf32602c   edx: 00000253
esi: c02eba80   edi: c02eb500   ebp: c02b3b34   esp: c02b3b20
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: c1439fe8 c029d14c 00000001 c02b3b30 00000046 c02b3b58 c011535f c1438000 
       00000000 00000001 c02a40a4 0000f201 00000086 00000003 0000001c c0122884 
       00000002 c03064c0 c01a557a c02a40a4 c01af71f 00000001 0000009c 0000270f 
Call Trace: [<c011535f>] [<c0122884>] [<c01a557a>] [<c01af71f>] [<c01b04ca>] 
   [<c01b0523>] [<c01097cf>] [<c0109936>] [<c0114198>] [<c0114198>] [<c0108aa6>] 
   [<c01144e7>] [<c0114198>] [<c01af2bb>] [<c01af2bb>] [<c010865c>] [<c0110018>] 
   [<c0114aa6>] [<c011535f>] [<c0117d63>] [<c0117ca4>] [<c0114198>] [<c0114169>] 
   [<c0108aa0>] [<c01144e7>] [<c0114198>] [<c01d2b91>] [<c01d8b57>] [<c01d7e50>] 
   [<c01d8b57>] [<c01de5f0>] [<c01d0f16>] [<c010865c>] [<c0114aa6>] [<c0115425>] 
   [<c01b3005>] [<c01d2b1f>] [<c01dd81f>] [<c01de506>] [<c01d461d>] [<c01de444>] 
   [<c01097cf>] [<c0109936>] [<c0106ba0>] [<c0106ba0>] [<c0106ba0>] [<c0106ba0>] 
   [<c0106bc3>] [<c0106c12>] [<c0105000>] [<c0105019>] 
Code: 8b 42 24 39 43 24 7d 0a 8b 42 14 c7 42 14 01 00 00 00 be 01 

>>EIP; c0114aa6 <try_to_wake_up+f6/11c>   <=====
Trace; c011535e <__wake_up+42/64>
Trace; c0122884 <schedule_task+54/5c>
Trace; c01a557a <schedule_console_callback+a/10>
Trace; c01af71e <handle_scancode+242/24c>
Trace; c01b04ca <handle_kbd_event+132/17c>
Trace; c01b0522 <keyboard_interrupt+e/14>
Trace; c01097ce <handle_IRQ_event+2e/58>
Trace; c0109936 <do_IRQ+6a/a8>
Trace; c0114198 <do_page_fault+0/498>
Trace; c0114198 <do_page_fault+0/498>
Trace; c0108aa6 <die+4a/50>
Trace; c01144e6 <do_page_fault+34e/498>
Trace; c0114198 <do_page_fault+0/498>
Trace; c01af2ba <serial_console_write+2a/184>
Trace; c01af2ba <serial_console_write+2a/184>
Trace; c010865c <error_code+34/3c>
Trace; c0110018 <amd_set_mtrr_up+6c/98>
Trace; c0114aa6 <try_to_wake_up+f6/11c>
Trace; c011535e <__wake_up+42/64>
Trace; c0117d62 <release_console_sem+72/78>
Trace; c0117ca4 <printk+104/110>
Trace; c0114198 <do_page_fault+0/498>
Trace; c0114168 <bust_spinlocks+40/4c>
Trace; c0108aa0 <die+44/50>
Trace; c01144e6 <do_page_fault+34e/498>
Trace; c0114198 <do_page_fault+0/498>
Trace; c01d2b90 <ide_set_handler+58/64>
Trace; c01d8b56 <piix_dmaproc+22/2c>
Trace; c01d7e50 <ide_dmaproc+1cc/32c>
Trace; c01d8b56 <piix_dmaproc+22/2c>
Trace; c01de5f0 <cdrom_do_pc_continuation+0/30>
Trace; c01d0f16 <atapi_output_bytes+3e/68>
Trace; c010865c <error_code+34/3c>
Trace; c0114aa6 <try_to_wake_up+f6/11c>
Trace; c0115424 <complete+40/60>
Trace; c01b3004 <end_that_request_last+10/1c>
Trace; c01d2b1e <ide_end_request+be/d8>
Trace; c01dd81e <cdrom_end_request+62/6c>
Trace; c01de506 <cdrom_pc_intr+c2/1ac>
Trace; c01d461c <ide_intr+b8/110>
Trace; c01de444 <cdrom_pc_intr+0/1ac>
Trace; c01097ce <handle_IRQ_event+2e/58>
Trace; c0109936 <do_IRQ+6a/a8>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106ba0 <default_idle+0/28>
Trace; c0106bc2 <default_idle+22/28>
Trace; c0106c12 <cpu_idle+2a/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105018 <rest_init+18/1c>
Code;  c0114aa6 <try_to_wake_up+f6/11c>
00000000 <_EIP>:
Code;  c0114aa6 <try_to_wake_up+f6/11c>   <=====
   0:   8b 42 24                  mov    0x24(%edx),%eax   <=====
Code;  c0114aa8 <try_to_wake_up+f8/11c>
   3:   39 43 24                  cmp    %eax,0x24(%ebx)
Code;  c0114aac <try_to_wake_up+fc/11c>
   6:   7d 0a                     jge    12 <_EIP+0x12> c0114ab8 <try_to_wake_up+108/11c>
Code;  c0114aae <try_to_wake_up+fe/11c>
   8:   8b 42 14                  mov    0x14(%edx),%eax
Code;  c0114ab0 <try_to_wake_up+100/11c>
   b:   c7 42 14 01 00 00 00      movl   $0x1,0x14(%edx)
Code;  c0114ab8 <try_to_wake_up+108/11c>
  12:   be 01 00 00 00            mov    $0x1,%esi

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

