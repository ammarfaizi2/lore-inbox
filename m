Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbRCTSid>; Tue, 20 Mar 2001 13:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130721AbRCTSiX>; Tue, 20 Mar 2001 13:38:23 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:10966 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S130686AbRCTSiK>; Tue, 20 Mar 2001 13:38:10 -0500
Date: Tue, 20 Mar 2001 10:37:20 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: "William A. Stein" <was@math.harvard.edu>
Subject: kernel 2.4.2 OOPS (in add_entropy_words ?)
Message-ID: <Pine.LNX.4.30.0103201029050.18265-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got the following OOPS yesterday while simultaneously doing a big 'rpm
-U' and a big computation (magma.exe) on an SMP i686 machine.  I copied
the OOPS down by hand from the console, but it should be accurate.  When
running ksymooops, I don't know that I reconstructed the module stack
completely, but I don't believe any modules are implicated in the trace.

Any suggestions would be welcome.  Of particular interest is how to tell
whether this is an 'off by one bit' error implicating the memory.  More
information about the machine is obviously available, I just thought this
is the relevant part.

Cheers,
Wayne

ksymoops 2.4.1 on i686 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol pcmcia_lookup_bus_R__ver_pcmcia_lookup_bus not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000100
c0193d4b
Oops: 0000
CPU: 1
EIP: 0010:[<c0193d4b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000040 ebx: c000077c ecx: 00000040 edx: 00000000
esi: 0000007f edi: c322fc20 ebp: 00000000 esp: d1f15f10
ds: 0018 es: 0018 ss: 0018
Process magma.exe (pid: 5487, stackpage=d1f15000)
Stack: c322fe20 00001000 00000009 c02f8ea0 c0193f5c c322fe20 c3268948 00000002
       d1f15f44 d1f15f44 00000020 c0119f9d c322fe20 c02f22ec c02f22ec 00000001
       00000000 c011c889 c028d2c0 00000086 c010de9f d1f15fc4 d1f14000 c0119e8c
Call Trace: [<c0193f5c>] [<c0119f9d>] [<c011c889>] [<c010de9f>] [<c0119e8c>] [<c0119d43>] [<c0119bcb>]
        [<c010aca5>] [<c01091a8>] [<c010002b>]
Code: 33 1c 82 89 c8 03 47 18 21 f0 33 1c 82 89 c8 03 47 1c 21 f0

>>EIP; c0193d4b <add_entropy_words+5b/b0>   <=====
Trace; c0193f5c <batch_entropy_process+3c/c0>
Trace; c0119f9d <__run_task_queue+5d/70>
Trace; c011c889 <tqueue_bh+19/20>
Trace; c010de9f <timer_interrupt+af/140>
Trace; c0119e8c <bh_action+4c/b0>
Trace; c0119d43 <tasklet_hi_action+53/90>
Trace; c0119bcb <do_softirq+6b/a0>
Trace; c010aca5 <do_IRQ+e5/f0>
Trace; c01091a8 <ret_from_intr+0/20>
Trace; c010002b <startup_32+2b/cb>
Code;  c0193d4b <add_entropy_words+5b/b0>
00000000 <_EIP>:
Code;  c0193d4b <add_entropy_words+5b/b0>   <=====
   0:   33 1c 82                  xor    (%edx,%eax,4),%ebx   <=====
Code;  c0193d4e <add_entropy_words+5e/b0>
   3:   89 c8                     mov    %ecx,%eax
Code;  c0193d50 <add_entropy_words+60/b0>
   5:   03 47 18                  add    0x18(%edi),%eax
Code;  c0193d53 <add_entropy_words+63/b0>
   8:   21 f0                     and    %esi,%eax
Code;  c0193d55 <add_entropy_words+65/b0>
   a:   33 1c 82                  xor    (%edx,%eax,4),%ebx
Code;  c0193d58 <add_entropy_words+68/b0>
   d:   89 c8                     mov    %ecx,%eax
Code;  c0193d5a <add_entropy_words+6a/b0>
   f:   03 47 1c                  add    0x1c(%edi),%eax
Code;  c0193d5d <add_entropy_words+6d/b0>
  12:   21 f0                     and    %esi,%eax

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

