Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbRG2CU5>; Sat, 28 Jul 2001 22:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbRG2CUj>; Sat, 28 Jul 2001 22:20:39 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:26870 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S267505AbRG2CU0>; Sat, 28 Jul 2001 22:20:26 -0400
Date: Sat, 28 Jul 2001 22:20:20 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: Gerard Roudier <groudier@club-internet.fr>
Subject: 2.4.7 oops + panic in ncr53c8xx (ncr_wakeup_done)
Message-ID: <Pine.LNX.4.20.0107282207180.316-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Please CC me in any replies, as I'm not subscribed to this list.  Thank
you.

I'm back again with yet another 2.4 kernel panic.  Looks like it's
happening in the same function as the last report.

If I didn't mention this before: HELP!


Analysis of oops by ksymoops:

ksymoops 2.4.1 on i586 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol lp_table  , lp says c5a5d260, /lib/modules/2.4.7/kernel/drivers/char/lp.o says c5a5d0a0.  Ignoring /lib/modules/2.4.7/kernel/drivers/char/lp.o entry
Unable to handle kernel NULL pointer dereference at virtual address 0000001d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01abd73>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c11987d8   ebx: 00000000     ecx: 0119a2cc       edx: 00000054
esi: 00000011   edi: c119c000     ebp: 0119a2c4       esp: c2fc3e9c
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 89, stackpage=c2fc3000)
Stack: c119c000 c119c000 0000000b c2fc3f2c c01acc07 c119c000 c119c000 00000246
       0000000b c2fc3f2c c2fc3ee8 00000286 c2fd4308 c01aec1e c119c000 c11e7460
       04000001 0000000b c0107d0f 0000000b c119c000 c2fc3f2c 00000160 c029fa60
Call Trace: [<c01acc07>] [<c01aec1e>] [<c0107d0f>] [<c0107e6e>] [<c0106be0>] [<c01100e7>] [<c0146975>]
       [<c012b866>] [<c0106b43>]
Code: 8a 43 1d 84 c0 7d 09 53 57 e8 5f f9 ff ff eb 0e a9 20 00 00

>>EIP; c01abd73 <ncr_wakeup_done+53/a4>   <=====
Trace; c01acc07 <ncr_exception+4f/314>
Trace; c01aec1e <ncr53c8xx_intr+26/7c>
Trace; c0107d0f <handle_IRQ_event+2f/58>
Trace; c0107e6e <do_IRQ+6e/b0>
Trace; c0106be0 <ret_from_intr+0/7>
Trace; c01100e7 <do_syslog+c7/304>
Trace; c0146975 <kmsg_read+11/18>
Trace; c012b866 <sys_read+96/cc>
Trace; c0106b43 <system_call+33/40>
Code;  c01abd73 <ncr_wakeup_done+53/a4>
0000000000000000 <_EIP>:
Code;  c01abd73 <ncr_wakeup_done+53/a4>   <=====
   0:   8a 43 1d                  mov    0x1d(%ebx),%al   <=====
Code;  c01abd76 <ncr_wakeup_done+56/a4>
   3:   84 c0                     test   %al,%al
Code;  c01abd78 <ncr_wakeup_done+58/a4>
   5:   7d 09                     jge    10 <_EIP+0x10> c01abd83 <ncr_wakeup_done+63/a4>
Code;  c01abd7a <ncr_wakeup_done+5a/a4>
   7:   53                        push   %ebx
Code;  c01abd7b <ncr_wakeup_done+5b/a4>
   8:   57                        push   %edi
Code;  c01abd7c <ncr_wakeup_done+5c/a4>
   9:   e8 5f f9 ff ff            call   fffff96d <_EIP+0xfffff96d> c01ab6e0 <ncr_complete+0/5a0>
Code;  c01abd81 <ncr_wakeup_done+61/a4>
   e:   eb 0e                     jmp    1e <_EIP+0x1e> c01abd91 <ncr_wakeup_done+71/a4>
Code;  c01abd83 <ncr_wakeup_done+63/a4>
  10:   a9 20 00 00 00            test   $0x20,%eax

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

