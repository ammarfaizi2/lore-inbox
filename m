Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBGE0p>; Tue, 6 Feb 2001 23:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129089AbRBGE0f>; Tue, 6 Feb 2001 23:26:35 -0500
Received: from mail.inconnect.com ([209.140.64.7]:5336 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S129051AbRBGE0X>; Tue, 6 Feb 2001 23:26:23 -0500
Date: Tue, 6 Feb 2001 21:26:21 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: 2.4.1-ac3 oops decoded with ksymoops
In-Reply-To: <E14QEjh-0006Vq-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.30.0102062122040.10046-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is an oops I got on one of my computers.  It came about 5 mins after
I forcibly ejected a PCMCIA card (A Spectrum24t 802.11b card), I don't
know if it is related.

The oops:
======================
kernel BUG at sched.c:714!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111634>]
EFLAGS: 00010286
eax:  0000001b  ebx:  c1167de0  ecx:  c3602000  edx:  c0227c08
esi:  c1167d70  edi:  c1166000  ebp:  c1167d5c  esp:  c1167d2c
ds:  0018       es:  0018       ss:  0018
Process kapmd-idled (pid: 3, stackpage=c1167000)
Stack:  c01eaee5 c01eb036 000002ca c1167de0 c1167d70 c1166000 c3a16c80
c3dbb380
                c0231a80 c0228b40 00000000 c1167de0 c1167de0 c010792d
c1167dcc c1167db8
                c1167dcc 00000001 c1166000 c1167dec c1167dec c0107a78
c1167de0 00000000
Call Trace: [<c010792d>] [<c0107a78>] [<c01e41c5>] [<c011d4e0>]
[<c011d4e0>] [<c01a574d>]
[<c0181f66>]
        [<c01853b1>] [<c01a55bd>] [<c018ca48>] [<c48cd52e>] [<c48d31c4>]
[<c48cd468>] [<c01199bd>]
[<c0119897>]
        [<c0119ca2>] [<c010ccd6>] [<c0117123>] [<c0117058>] [<c0116f60>]
[<c010a161>] [<c0108e60>]
[<c010f26a>]
        [<c0100018>] [<c010f340>] [<c010faad>] [<c01103e7>] [<c0107423>]
[<c010742c>]

Code:  0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 55 89 e5 83 ec 10 57 56
Kernel panic:  Aiee, killing interrupt handler!
In interrupt handler - not syncing
========================

ksymoops output:

=======================
ksymoops 2.3.4 on i586 2.4.1-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac3/ (default)
     -m /usr/src/linux/System.map (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111634>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax:  0000001b  ebx:  c1167de0  ecx:  c3602000  edx:  c0227c08
esi:  c1167d70  edi:  c1166000  ebp:  c1167d5c  esp:  c1167d2c
ds:  0018       es:  0018       ss:  0018
Process kapmd-idled (pid: 3, stackpage=c1167000)
Stack:  c01eaee5 c01eb036 000002ca c1167de0 c1167d70 c1166000 c3a16c80
c3dbb380
                c0231a80 c0228b40 00000000 c1167de0 c1167de0 c010792d
c1167dcc c1167db8
                c1167dcc 00000001 c1166000 c1167dec c1167dec c0107a78
c1167de0 00000000
Call Trace: [<c010792d>] [<c0107a78>] [<c01e41c5>] [<c011d4e0>]
[<c011d4e0>] [<c01a574d>]
[<c0181f66>]
        [<c01853b1>] [<c01a55bd>] [<c018ca48>] [<c48cd52e>] [<c48d31c4>]
[<c48cd468>] [<c01199bd>]
[<c0119897>]
        [<c0119ca2>] [<c010ccd6>] [<c0117123>] [<c0117058>] [<c0116f60>]
[<c010a161>] [<c0108e60>]
[<c010f26a>]
        [<c0100018>] [<c010f340>] [<c010faad>] [<c01103e7>] [<c0107423>]
[<c010742c>]
Code:  0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 55 89 e5 83 ec 10 57 56

>>EIP; c0111634 <schedule+388/394>   <=====
Trace; c010792d <__down+55/9c>
Trace; c0107a78 <__down_failed+8/c>
Trace; c01e41c5 <stext_lock+195/10c2>
Trace; c011d4e0 <__call_usermodehelper+0/2c>
Trace; c011d4e0 <__call_usermodehelper+0/2c>
Trace; c01a574d <net_run_sbin_hotplug+79/8c>
Trace; c0181f66 <set_cursor+6e/88>
Trace; c01853b1 <vt_console_print+2c1/2d8>
Trace; c01a55bd <unregister_netdevice+b5/1cc>
Trace; c018ca48 <unregister_netdev+10/28>
Trace; c48cd52e <[spectrum24t_cs]adapter_release+c6/188>
Trace; c48d31c4 <[spectrum24t_cs]__FUNC__.1131+10/60>
Trace; c48cd468 <[spectrum24t_cs]adapter_release+0/188>
Trace; c01199bd <update_process_times+1d/8c>
Trace; c0119897 <update_wall_time+b/3c>
Trace; c0119ca2 <timer_bh+23e/27c>
Trace; c010ccd6 <timer_interrupt+62/110>
Trace; c0117123 <bh_action+1b/5c>
Trace; c0117058 <tasklet_hi_action+3c/60>
Trace; c0116f60 <do_softirq+40/64>
Trace; c010a161 <do_IRQ+a1/b0>
Trace; c0108e60 <ret_from_intr+0/20>
Trace; c010f26a <apm_bios_call_simple+4e/58>
Trace; c0100018 <startup_32+18/139>
Trace; c010f340 <apm_do_idle+14/30>
Trace; c010faad <apm_mainloop+8d/f4>
Trace; c01103e7 <apm+27b/294>
Trace; c0107423 <kernel_thread+1f/38>
Trace; c010742c <kernel_thread+28/38>
Code;  c0111634 <schedule+388/394>
00000000 <_EIP>:
Code;  c0111634 <schedule+388/394>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0111636 <schedule+38a/394>
   2:   8d 65 dc                  lea    0xffffffdc(%ebp),%esp
Code;  c0111639 <schedule+38d/394>
   5:   5b                        pop    %ebx
Code;  c011163a <schedule+38e/394>
   6:   5e                        pop    %esi
Code;  c011163b <schedule+38f/394>
   7:   5f                        pop    %edi
Code;  c011163c <schedule+390/394>
   8:   89 ec                     mov    %ebp,%esp
Code;  c011163e <schedule+392/394>
   a:   5d                        pop    %ebp
Code;  c011163f <schedule+393/394>
   b:   c3                        ret
Code;  c0111640 <__wake_up+0/98>
   c:   55                        push   %ebp
Code;  c0111641 <__wake_up+1/98>
   d:   89 e5                     mov    %esp,%ebp
Code;  c0111643 <__wake_up+3/98>
   f:   83 ec 10                  sub    $0x10,%esp
Code;  c0111646 <__wake_up+6/98>
  12:   57                        push   %edi
Code;  c0111647 <__wake_up+7/98>
  13:   56                        push   %esi

Kernel panic:  Aiee, killing interrupt handler!

Dax Kelson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
