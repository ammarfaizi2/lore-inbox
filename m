Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263052AbREWLo3>; Wed, 23 May 2001 07:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263053AbREWLoS>; Wed, 23 May 2001 07:44:18 -0400
Received: from apus.ing.iac.es ([161.72.6.2]:57560 "EHLO apus.ing.iac.es")
	by vger.kernel.org with ESMTP id <S263052AbREWLoJ>;
	Wed, 23 May 2001 07:44:09 -0400
Date: Wed, 23 May 2001 12:44:03 +0100 (BST)
Message-Id: <200105231144.MAA01835@lpss33.ing-slo.iac.es>
From: greimel@ing.iac.es (Robert Greimel)
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.4-ac7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following oops happened with kernel 2.4.4-ac7.

The motherboard (Micron PTSAM-04. It's a dual board but I only have one
processor running a UP kernel) is unfortunately not completely above
suspicion, although it has not caused problems in the past ...
In order to get the kernel to boot at all I have to prevent the on-board
Samurai IDE chip from being initialized which I do by setting MAX_HWIFS to 2
in include/asm/ide.h (this has worked fine for nearly two years now).

Let me know if the oops is interesting and you need more info.

Greetings

Robert

ksymoops 2.4.1 on i686 2.4.4-ac7-PII.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-ac7-PII/ (default)
     -m /lib/modules/2.4.4-ac7-PII/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 412da078
printing eip:
c01195cc
pgd entry c35f9410: 0000000000000000
pmd entry c35f9410: 0000000000000000
... pmd not present!
Oops: 0000
CPU: 0
EIP: 0010:[<c01195cc>]
EFLAGS: 00010086
eax: c0264ba4 ebx: 412da078 ecx: 00000086 edx: c0264ba4
esi: 412da060 edi: 00000000 ebp: 412da078 esp: c2a65f34
ds: 0018 es: 0018 ss: 0018
Process tycho_usno_slav (pid: 253, stackpage=c2a65000)
Stack 412da060 c018ff12 412da078 412da060 c018fef8 00000000 c2a65fbc 00000286
      c0119ce2 412da060 00000000 c025d5a0 00000000 c2a65fbc c02757c8 00000001
      c025d5c0 c0116c8b 00000000 c0116bc4 00000000 00000001 c025d5c0 0000000e
Call Trace: [<c018ff12>] [<c018fef8>] [<c0119ce2>] [<c0116c8b>] [<c0116bc4>]
   [<c0116ace>] [<c0107e49>] [<c0106b18>] [<c010002b>]

Code: 8b 13 85 d2 75 06 31 c0 eb 0f 89 f6 8b 43 04 89 42 04 89 10
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
Unable to handle kernel paging request at virtual address 412da078
c01195cc
Oops: 0000
CPU: 0
EIP: 0010:[<c01195cc>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: c0264ba4 ebx: 412da078 ecx: 00000086 edx: c0264ba4
esi: 412da060 edi: 00000000 ebp: 412da078 esp: c2a65f34
ds: 0018 es: 0018 ss: 0018
Process tycho_usno_slav (pid: 253, stackpage=c2a65000)
      c0119ce2 412da060 00000000 c025d5a0 00000000 c2a65fbc c02757c8 00000001
      c025d5c0 c0116c8b 00000000 c0116bc4 00000000 00000001 c025d5c0 0000000e
Call Trace: [<c018ff12>] [<c018fef8>] [<c0119ce2>] [<c0116c8b>] [<c0116bc4>]
   [<c0116ace>] [<c0107e49>] [<c0106b18>] [<c010002b>]
Code: 8b 13 85 d2 75 06 31 c0 eb 0f 89 f6 8b 43 04 89 42 04 89 10

>>EIP; c01195cc <del_timer+8/34>   <=====
Trace; c018ff12 <ide_timer_expiry+1a/204>
Trace; c018fef8 <ide_timer_expiry+0/204>
Trace; c0119ce2 <timer_bh+20e/248>
Trace; c0116c8b <bh_action+1b/60>
Trace; c0116bc4 <tasklet_hi_action+38/5c>
Trace; c0116ace <do_softirq+42/64>
Trace; c0107e49 <do_IRQ+9d/b0>
Trace; c0106b18 <ret_from_intr+0/20>
Trace; c010002b <startup_32+2b/a5>
Code;  c01195cc <del_timer+8/34>
00000000 <_EIP>:
Code;  c01195cc <del_timer+8/34>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c01195ce <del_timer+a/34>
   2:   85 d2                     test   %edx,%edx
Code;  c01195d0 <del_timer+c/34>
   4:   75 06                     jne    c <_EIP+0xc> c01195d8 <del_timer+14/34>
Code;  c01195d2 <del_timer+e/34>
   6:   31 c0                     xor    %eax,%eax
Code;  c01195d4 <del_timer+10/34>
   8:   eb 0f                     jmp    19 <_EIP+0x19> c01195e5 <del_timer+21/34>
Code;  c01195d6 <del_timer+12/34>
   a:   89 f6                     mov    %esi,%esi
Code;  c01195d8 <del_timer+14/34>
   c:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c01195db <del_timer+17/34>
   f:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c01195de <del_timer+1a/34>
  12:   89 10                     mov    %edx,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.
