Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbQKTKIs>; Mon, 20 Nov 2000 05:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131548AbQKTKIi>; Mon, 20 Nov 2000 05:08:38 -0500
Received: from wg.redhat.de ([193.103.254.4]:45385 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S131488AbQKTKIU>;
	Mon, 20 Nov 2000 05:08:20 -0500
Date: Mon, 20 Nov 2000 10:38:19 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.0-test11-pre4 (SMP x86)
Message-ID: <Pine.LNX.4.30.0011201035170.6034-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got this on a dual Pentium III-700 system, running
2.4.0-test11-pre4; no special patches applied except for commenting out
the printk line generating the tons of "APIC error on CPU0" messages
generated on Gigabyte P2D boards:

Unexpected IRQ trap at vector 6c
kernel BUG at smp.c:281

ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map-2.4.0-test11 (specified)

invalid operand: 0000
CPU:    1
EIP:    0010:[<c0177cdd>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000019   ebx: 00000001   ecx: dbff6000   edx: 00000001
esi: c010b130   edi: dbff6000   ebp: ffffe000   esp: dbff7f64
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=dbff7000)
Stack: c02090c5 c0209225 00000119 dbff6000 c010b130 c0206d31 dbff6000 dbff6000
       00000001 c010b130 dbff6000 ffffe000 00000000 c0100018 dbff0018 0000008d
       c010b15e 00000010 00000246 c010af72 00000002 00000000 00000000 00000000
Call Trace: [<c02090c5>] [<c0209225>] [<c010b130>] [<c0206d31>] [<c010b130>]
            [<c0100018>] [<c010b15e>] [<c010af72>] [<c012693f>]
Code: 0f 0b 83 c4 0c 8d 34 dd 00 00 00 00 8b 86 40 8d 23 c0 39 05

>>EIP; c0177cdd <shm_put_super+8d/e0>   <=====
Trace; c02090c5 <stext_lock+5f4d/5f7c>
Trace; c0209225 <vide+131/13c0>
Trace; c010b130 <sys_execve+20/60>
Trace; c0206d31 <stext_lock+3bb9/5f7c>
Trace; c010b130 <sys_execve+20/60>
Trace; c0100018 <startup_32+18/cc>
Trace; c010b15e <sys_execve+4e/60>
Trace; c010af72 <cpu_idle+12/70>
Trace; c012693f <printk+14f/1a0>
Code;  c0177cdd <shm_put_super+8d/e0>
00000000 <_EIP>:
Code;  c0177cdd <shm_put_super+8d/e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0177cdf <shm_put_super+8f/e0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0177ce2 <shm_put_super+92/e0>
   5:   8d 34 dd 00 00 00 00      lea    0x0(,%ebx,8),%esi
Code;  c0177ce9 <shm_put_super+99/e0>
   c:   8b 86 40 8d 23 c0         mov    0xc0238d40(%esi),%eax
Code;  c0177cef <shm_put_super+9f/e0>
  12:   39 05 00 00 00 00         cmp    %eax,0x0

Kernel panic: Attempted to kill the idle task!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
