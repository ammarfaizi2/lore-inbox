Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbSJBFsl>; Wed, 2 Oct 2002 01:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262979AbSJBFsl>; Wed, 2 Oct 2002 01:48:41 -0400
Received: from angband.namesys.com ([212.16.7.85]:48821 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262977AbSJBFsj>; Wed, 2 Oct 2002 01:48:39 -0400
Date: Wed, 2 Oct 2002 09:54:01 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: James Stevenson <james@stev.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.5.39
Message-ID: <20021002095401.A13850@namesys.com>
References: <20021001114454.A27039@namesys.com> <200210011819.NAA02853@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200210011819.NAA02853@ccure.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Oct 01, 2002 at 01:19:36PM -0500, Jeff Dike wrote:

> > And then kernel mode fault at 0x5a5a5a5e 
> Can you get a stack trace from that crash?

Sure.

#0  panic (fmt=0xa0240900 "Kernel mode fault at addr 0x%lx, ip 0x%lx")
    at panic.c:45
#1  0xa00164e5 in segv (address=1515870814, ip=2684410784, is_write=0, 
    is_user=0, sc=0xaeeb33a0) at trap_kern.c:129
#2  0xa0017466 in segv_handler (sig=11, regs=0xaeea4390) at trap_user.c:437
#3  0xa001751b in sig_handler_common (sig=11, sc=0xaeeb33a0) at trap_user.c:488
#4  0xa0017596 in sig_handler (sig=11, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 10, esi = 872415233, ebp = 2934650508, esp = 2934650484, ebx = 1515870810, edx = 0, ecx = 2934650172, eax = 1, trapno = 14, err = 4, eip = 2684410784, cs = 35, __csh = 0, eflags = 66054, esp_at_signal = 2934650484, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 469827584, cr2 = 1515870814}) at trap_user.c:504
#5  <signal handler called>
#6  handle_IRQ_event (irq=10, regs=0xaeea4390, action=0xa03cc604) at irq.c:153
#7  0xa000dd81 in do_IRQ (irq=10, regs=0xaeea4390) at irq.c:324
#8  0xa000e4ac in sigio_handler (sig=29, regs=0xaeea4390) at irq_user.c:73
#9  0xa001751b in sig_handler_common (sig=29, sc=0xaeeb3788) at trap_user.c:488
#10 0xa0017596 in sig_handler (sig=29, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2934651928, esi = 672274793, ebp = 2934651532, esp = 2934651488, ebx = 66, edx = 2688339692, ecx = 2934651356, eax = 0, trapno = 14, err = 4, eip = 2686504781, cs = 35, __csh = 0, eflags = 643, esp_at_signal = 2934651488, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 201392128, cr2 = 1074026496})
    at trap_user.c:504
#11 <signal handler called>
#12 0xa020cf4d in __libc_close ()
#13 0xa001fe51 in winch_cleanup () at line.c:441
#14 0xa0011268 in do_uml_exitcalls () at process_kern.c:622
#15 0xa0011feb in machine_power_off () at reboot.c:42
#16 0xa001201b in machine_halt () at reboot.c:50
#17 0xa0035eb5 in sys_reboot (magic1=-18751827, magic2=672274793, 
    cmd=3454992675, arg=0x8049644) at sys.c:386
#18 0xa001509d in execute_syscall (r=0xaeea4390) at syscall_kern.c:405
#19 0xa00151e0 in syscall_handler (sig=12, regs=0xaeea4390)
    at syscall_user.c:63
#20 0xa001751b in sig_handler_common (sig=12, sc=0xaeeb3d28) at trap_user.c:488
#21 0xa0017596 in sig_handler (sig=12, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 4276215469, esi = 134518340, ebp = 2684353868, esp = 2684353840, ebx = 4276215469, edx = 3454992675, ecx = 672274793, eax = 4294967258, trapno = 14, err = 4, eip = 1074697900, cs = 35, __csh = 0, eflags = 534, esp_at_signal = 2684353840, ss = 43, __ssh = 0, fpstate = 0xaeeb3d80, oldmask = 469827584, cr2 = 1074026496}) at trap_user.c:504
#22 <signal handler called>
#23 0x400e96ac in ?? ()
...
(gdb) 
#6  handle_IRQ_event (irq=10, regs=0xaeea4390, action=0xa03cc604) at irq.c:153
153                     status |= action->flags;
(gdb) p action
$1 = (struct irqaction *) 0x5a5a5a5a
(gdb) 

> > Just before the crash it warns about winch_interrupt : read failed,
> > errno = 9 fd 57 is losing SIGWINCH support 
> This looks different.  Is it consistently the same file descriptor?  If so,

No.
I just tried twice and got 65 for the first time and 53 for the second.

> put a breakpoint on close and see who's closing it who isn't supposed to.

Hm. May be I'll do it later.

Bye,
    Oleg
