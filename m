Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRBWTf2>; Fri, 23 Feb 2001 14:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRBWTfS>; Fri, 23 Feb 2001 14:35:18 -0500
Received: from xanadu.kublai.com ([166.84.169.10]:48001 "HELO
	xanadu.kublai.com") by vger.kernel.org with SMTP id <S129093AbRBWTfA>;
	Fri, 23 Feb 2001 14:35:00 -0500
Date: Fri, 23 Feb 2001 14:34:58 -0500
From: Brendan Cully <brendan@kublai.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: regular lockup on 2.4.2 (w/oops)
Message-ID: <20010223143458.A596@xanadu.kublai.com>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Operating-System: Linux 2.4.1 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since running 2.4.2 I've been getting regular lockups, usually during
the boot process but occasionally during regular usage too. I've
copied down an oops by hand from the console (it seems to be always
the same oops, except ESI varies).

I wonder if it's related to ACPI and/or IDE - I seem to get on
occasion one ide_dmaproc: lost interrupt message during fsck - after a
few seconds it recovers only to hang for good some 10-15 seconds
later.

My system: dual PIII/550 on a 440 BX (Gigabyte 6bxds), 256 MB RAM.

The oops is generated after I do SysRq-S,U,B. If I don't try to reboot
with SysRq it just hangs indefinitely.

I've rolled back to 2.4.1, although I'm a bit afraid since I've heard
reports of FS corruption under it...?

Here's the oops report:

------
ksymoops 2.3.7 on i686 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map-2.4.2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c0111f50>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000097
eax: 00000000 ebx: 00000000 ecx: 00000001 edx: c031050c
esi: c1582000 edi: 00000007 ebp: 00000062 esp: c02dbec0
Process swapper (pid: 0 stackpage=c02db000)
Stack: c0325660 c0111f88 00000000 00000000 c02f83cd 00000000 c0111fc8 c0111f88
       00000000 00000001 00000000 c01072de c0325660 c0193e91 00000000 c027e711
       00000030 00000000 0000270f c02d9000 c0192304 00000062 c02dbfa8 c0325660
Call Trace: [<c0111f88>] [<c0111fc8>] [<c0111f88>] [<c01072de>] [<c01072de>] [<c0193e91>] [<c0192634>] [<c019378d>]
        [<c0193818>] [<c01096c1>] [<c010a8a6>] [<c0107170>] [<c0107170>] [<c010901c>] [<c0107170>] [<c0107170>]
        [<c0100018>] [<c0107196>] [<c0107202>] [<c0105000>] [<c01001cf>]
Code: 8b 44 24 0c 39 c8 75 f8 85 db 74 0c eb 02 89 f6 8b 44 24 10

>>EIP; c0111f50 <smp_call_function+8c/c4>   <=====
Trace; c0111f88 <stop_this_cpu+0/30>
Trace; c0111fc8 <smp_send_stop+10/28>
Trace; c0111f88 <stop_this_cpu+0/30>
Trace; c01072de <machine_restart+6/8c>
Trace; c01072de <machine_restart+6/8c>
Trace; c0193e91 <handle_sysrq+b1/230>
Trace; c0192634 <handle_scancode+1a8/2e8>
Trace; c019378d <handle_kbd_event+121/190>
Trace; c0193818 <keyboard_interrupt+1c/28>
Trace; c01096c1 <do_invalid_op+1d/88>
Trace; c010a8a6 <do_IRQ+a6/f4>
Trace; c0107170 <default_idle+0/34>
Trace; c0107170 <default_idle+0/34>
Trace; c010901c <ret_from_intr+0/20>
Trace; c0107170 <default_idle+0/34>
Trace; c0107170 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c0107196 <default_idle+26/34>
Trace; c0107202 <cpu_idle+3e/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01001cf <L6+0/2>
Code;  c0111f50 <smp_call_function+8c/c4>
00000000 <_EIP>:
Code;  c0111f50 <smp_call_function+8c/c4>   <=====
   0:   8b 44 24 0c               mov    0xc(%esp,1),%eax   <=====
Code;  c0111f54 <smp_call_function+90/c4>
   4:   39 c8                     cmp    %ecx,%eax
Code;  c0111f56 <smp_call_function+92/c4>
   6:   75 f8                     jne    0 <_EIP>
Code;  c0111f58 <smp_call_function+94/c4>
   8:   85 db                     test   %ebx,%ebx
Code;  c0111f5a <smp_call_function+96/c4>
   a:   74 0c                     je     18 <_EIP+0x18> c0111f68 <smp_call_function+a4/c4>
Code;  c0111f5c <smp_call_function+98/c4>
   c:   eb 02                     jmp    10 <_EIP+0x10> c0111f60 <smp_call_function+9c/c4>
Code;  c0111f5e <smp_call_function+9a/c4>
   e:   89 f6                     mov    %esi,%esi
Code;  c0111f60 <smp_call_function+9c/c4>
  10:   8b 44 24 10               mov    0x10(%esp,1),%eax


1 warning issued.  Results may not be reliable.
