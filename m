Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319646AbSH3STb>; Fri, 30 Aug 2002 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319647AbSH3STa>; Fri, 30 Aug 2002 14:19:30 -0400
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:64845 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S319646AbSH3ST3>; Fri, 30 Aug 2002 14:19:29 -0400
Message-Id: <200208301742.TAA22195@delphin.mathe.tu-freiberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac2 pcmcia panic + OOPS
Date: Fri, 30 Aug 2002 20:24:14 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

finally I was able to catch the oops related to this problem.
(handcopied)


ksymoops 2.4.3 on i586 2.4.20-pre2-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre2-ac2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in 
System.map.  Ignoring ksyms_base entry
Oops:     0000
CPU:        0
EIP:     0010:[<c01c6e28>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS:  00010046
eax: 00000000  ebx: ccf7de88  ecx: 00000000  edx: 00000180
esi: c033f474  edi: 00000082  ebp: c033f430  esp: ce811d2c
ds: 0018  es: 0018  ss: 0018
Process syslogd (pid: 268, stackpage=ce8110000)
Stack: c033f474  00000001  c033f474  ccfd6880  c01caa97  c033f474  ce23b320  
24000001
       00000003  ce811da0  c01c6d65  c0107cd7  00000003  ccfd6880  ce811da0  
00000060
       c0319960  00000003  cd811d98  c0107e5a  00000003  ce811da0  ce23b320  
ce7cb5b4
Call Trace:  [<c01caa97>] [<c01c6d65>] [<c0107cd7>] [<c0107e5a>] [<c0109e7c>]
[<c0151d9c>] [<c01520d4>] [<c01521d3>] [<c0152294>] [<c01410f9>] [<c013376d>]
[<c0150702>] [<c0125988>] [<c014e21c>] [<c01311cb>] [<c014e1f9>] [<c01312f0>]
[<c0106ae3>]
Code:  8b 40 24 ff d0 83 c4 08 85 c0 75 04 31 c0 eb 28 8b 86 e4 00

>>EIP; c01c6e28 <task_in_intr+c4/fe>   <=====
Trace; c01caa96 <ide_intr+bc/10e>
Trace; c01c6d64 <task_in_intr+0/fe>
Trace; c0107cd6 <handle_IRQ_event+2e/58>
Trace; c0107e5a <do_IRQ+94/ce>
Trace; c0109e7c <call_do_IRQ+6/e>
Trace; c0151d9c <ext3_do_update_inode+2d4/382>
Trace; c01520d4 <ext3_mark_iloc_dirty+22/4e>
Trace; c01521d2 <ext3_mark_inode_dirty+28/32>
Trace; c0152294 <ext3_dirty_inode+b8/f4>
Trace; c01410f8 <__mark_inode_dirty+2e/76>
Trace; c013376c <generic_commit_write+52/5c>
Trace; c0150702 <ext3_commit_write+132/1be>
Trace; c0125988 <generic_file_write+4de/6f8>
Trace; c014e21c <ext3_file_write+24/b0>
Trace; c01311ca <do_readv_writev+1ac/23e>
Trace; c014e1f8 <ext3_file_write+0/b0>
Trace; c01312f0 <sys_writev+42/52>
Trace; c0106ae2 <system_call+2e/34>
Code;  c01c6e28 <task_in_intr+c4/fe>
00000000 <_EIP>:
Code;  c01c6e28 <task_in_intr+c4/fe>   <=====
   0:   8b 40 24                  mov    0x24(%eax),%eax   <=====
Code;  c01c6e2a <task_in_intr+c6/fe>
   3:   ff d0                     call   *%eax
Code;  c01c6e2c <task_in_intr+c8/fe>
   5:   83 c4 08                  add    $0x8,%esp
Code;  c01c6e30 <task_in_intr+cc/fe>
   8:   85 c0                     test   %eax,%eax
Code;  c01c6e32 <task_in_intr+ce/fe>
   a:   75 04                     jne    10 <_EIP+0x10> c01c6e38 
<task_in_intr+d4/fe>
Code;  c01c6e34 <task_in_intr+d0/fe>
   c:   31 c0                     xor    %eax,%eax
Code;  c01c6e36 <task_in_intr+d2/fe>
   e:   eb 28                     jmp    38 <_EIP+0x38> c01c6e60 
<task_in_intr+fc/fe>
Code;  c01c6e38 <task_in_intr+d4/fe>
  10:   8b 86 e4 00 00 00         mov    0xe4(%esi),%eax

 <0>Kernel panic: Aiee, Killing interrupt handler!

2 warnings issued.  Results may not be reliable.



> somehow IDE over PCMCIA has stopped working.
> 
> 2.4.20-pre2 with pcmcia-cs-3.2.1 is OK (dmesg and lspci -v are attached).
> 2.4.20-pre2-ac2 with pcmcia-cs-3.2.1 locks the box and makes 2 LEDs blink.
> 
> 2.4.19-ac4 with pcmcia-cs-3.1.33 shows the same symptoms.
> 2.4.19-ac4 with pcmcia-cs-3.1.34 does not lock up, but also does not work.
>
> Kernel pcmcia never worked on this box, so I had to resort to the version of
> David Hinds.

Best regards,
Michael
