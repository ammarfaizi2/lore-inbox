Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLGSs5>; Thu, 7 Dec 2000 13:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131755AbQLGSss>; Thu, 7 Dec 2000 13:48:48 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:63873 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S129340AbQLGSsa>;
	Thu, 7 Dec 2000 13:48:30 -0500
Message-ID: <3A2FD459.B292F1A4@pobox.com>
Date: Thu, 07 Dec 2000 10:18:01 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12-pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel oops: test12-pre7, xmms, emu10k
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

2.4.0-test12-preXX has been pretty stable here on
a K6/2-450 running ipchains and various net services
in addition to workstation use.

I went to bed last night while others were listening to
xmms on my workstation while working in the room.

This morning I found that xmms was frozen, and there
were several oopsen in the logs.

After restarting X, everything is functional, and xmms
is working again -

I dimly perceive that xmms and the emu10k sound
driver seem to be involved, perhaps someone more
astute can see something more definite?

Here are the decoded oops:

ksymoops 2.3.4 on i586 2.4.0-test12-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12-pre7/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address ec4b6b63
c013c668
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013c668>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 97249ff3   ebx: 00000000   ecx: 00000000   edx: 00000001
esi: c56ba000   edi: ec4b6b57   ebp: 00000000   esp: c56bbf70
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 1391, stackpage=c56bb000)
Stack: c56ba000 00000000 befffcf4 befffcf4 ffffffea c876ace0 ffffffea
befffc8c
       c56bbf9c 00000000 c56ba000 befffcfc 8010500c 00000001 c56ba000
000188d0
       00001000 0003b000 d18233cc cf448900 c010a883 0000000b 00000000
befffd0c
Call Trace: [<d18233cc>] [<c010a883>]
Code: 8b 57 0c 39 54 24 54 7e 04 89 54 24 54 8b 6c 24 54 83 c5 1f

>>EIP; c013c668 <sys_select+ec/5a8>   <=====
Trace; d18233cc <[emu10k1]emu10k1_audio_ioctl+0/f4>
Trace; c010a883 <system_call+33/40>
Code;  c013c668 <sys_select+ec/5a8>
00000000 <_EIP>:
Code;  c013c668 <sys_select+ec/5a8>   <=====
   0:   8b 57 0c                  movl   0xc(%edi),%edx   <=====
Code;  c013c66b <sys_select+ef/5a8>
   3:   39 54 24 54               cmpl   %edx,0x54(%esp,1)
Code;  c013c66f <sys_select+f3/5a8>
   7:   7e 04                     jle    d <_EIP+0xd> c013c675
<sys_select+f9/5a8>
Code;  c013c671 <sys_select+f5/5a8>
   9:   89 54 24 54               movl   %edx,0x54(%esp,1)
Code;  c013c675 <sys_select+f9/5a8>
   d:   8b 6c 24 54               movl   0x54(%esp,1),%ebp
Code;  c013c679 <sys_select+fd/5a8>
  11:   83 c5 1f                  addl   $0x1f,%ebp

Unable to handle kernel paging request at virtual address ec4b6b57
c011983c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011983c>]
EFLAGS: 00010282
eax: ec4b6b57   ebx: cec11640   ecx: 00000206   edx: 00000044
esi: c56ba000   edi: ec4b6b57   ebp: ec4b6b63   esp: c56bbe58
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 1391, stackpage=c56bb000)
Stack: cec11640 c56ba000 0000000b ec4b6b63 c0119e71 ec4b6b57 00000000
000003b1
       c0110a84 c010adae 0000000b c0110db2 c01e929e c56bbf3c 00000000
c56ba000
       00000000 c0110a84 00000000 c023a260 c0115198 c56bbefc c56ba000
c7102000
Call Trace: [<ec4b6b63>] [<c0119e71>] [<ec4b6b57>] [<c0110a84>]
[<c010adae>] [<c0110db2>] [<c01e929e>]
       [<c0110a84>] [<c0115198>] [<d1826fdf>] [<c013c539>] [<c010a9c4>]
[<ec4b6b57>] [<c013c668>] [<d18233cc>]
       [<c010a883>]
Code: ff 0f 0f 94 c0 84 c0 0f 84 99 00 00 00 31 ed 31 f6 8b 57 0c

>>EIP; c011983c <put_files_struct+8/b4>   <=====
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; c0119e71 <do_exit+b9/1f4>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c010adae <die+42/44>
Trace; c0110db2 <do_page_fault+32e/40c>
Trace; c01e929e <IRQ0x0f_interrupt+2a6e/54b8>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c0115198 <schedule+2d8/430>
Trace; d1826fdf <[emu10k1]copy_block+f3/100>
Trace; c013c539 <do_select+1f9/214>
Trace; c010a9c4 <error_code+34/40>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c013c668 <sys_select+ec/5a8>
Trace; d18233cc <[emu10k1]emu10k1_audio_ioctl+0/f4>
Trace; c010a883 <system_call+33/40>
Code;  c011983c <put_files_struct+8/b4>
00000000 <_EIP>:
Code;  c011983c <put_files_struct+8/b4>   <=====
   0:   ff 0f                     decl   (%edi)   <=====
Code;  c011983e <put_files_struct+a/b4>
   2:   0f 94 c0                  sete   %al
Code;  c0119841 <put_files_struct+d/b4>
   5:   84 c0                     testb  %al,%al
Code;  c0119843 <put_files_struct+f/b4>
   7:   0f 84 99 00 00 00         je     a6 <_EIP+0xa6> c01198e2
<put_files_struct+ae/b4>
Code;  c0119849 <put_files_struct+15/b4>
   d:   31 ed                     xorl   %ebp,%ebp
Code;  c011984b <put_files_struct+17/b4>
   f:   31 f6                     xorl   %esi,%esi
Code;  c011984d <put_files_struct+19/b4>
  11:   8b 57 0c                  movl   0xc(%edi),%edx

Unable to handle kernel paging request at virtual address ec0dc836
c0119e8c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0119e8c>]
EFLAGS: 00010286
eax: 00000000   ebx: ec0dc836   ecx: 00000206   edx: 00000000
esi: c56ba000   edi: 0000000b   ebp: ec4b6b57   esp: c56bbd58
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 1391, stackpage=c56bb000)
Stack: 00000000 000003b1 c0110a84 c010adae 0000000b c0110db2 c01e929e
c56bbe24
       00000002 c56ba000 00000002 c0110a84 ec4b6b63 c021bd00 30003662
c56b3166
       00000000 00000000 00000000 00000000 00000000 c021bd00 30000007
c021bd30
Call Trace: [<c0110a84>] [<c010adae>] [<c0110db2>] [<c01e929e>]
[<c0110a84>] [<ec4b6b63>] [<c021bd00>]
       [<c021bd00>] [<c021bd30>] [<c01e1c39>] [<c01e1c39>] [<c010a883>]
[<c016bd09>] [<c01e1c39>] [<c016bd09>]
       [<c016bd09>] [<c010a9c4>] [<ec4b6b57>] [<ec4b6b63>] [<ec4b6b57>]
[<c011983c>] [<ec4b6b63>] [<c0119e71>]
       [<ec4b6b57>] [<c0110a84>] [<c010adae>] [<c0110db2>] [<c01e929e>]
[<c0110a84>] [<c0115198>] [<d1826fdf>]
       [<c013c539>] [<c010a9c4>] [<ec4b6b57>] [<c013c668>] [<d18233cc>]
[<c010a883>]
Code: ff 0b 0f 94 c0 84 c0 0f 84 b6 00 00 00 8b 43 0c 50 e8 de 58

>>EIP; c0119e8c <do_exit+d4/1f4>   <=====
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c010adae <die+42/44>
Trace; c0110db2 <do_page_fault+32e/40c>
Trace; c01e929e <IRQ0x0f_interrupt+2a6e/54b8>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; c021bd00 <msstab+d4e/f4e>
Trace; c021bd00 <msstab+d4e/f4e>
Trace; c021bd30 <msstab+d7e/f4e>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c010a883 <system_call+33/40>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c010a9c4 <error_code+34/40>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c011983c <put_files_struct+8/b4>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; c0119e71 <do_exit+b9/1f4>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c010adae <die+42/44>
Trace; c0110db2 <do_page_fault+32e/40c>
Trace; c01e929e <IRQ0x0f_interrupt+2a6e/54b8>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c0115198 <schedule+2d8/430>
Trace; d1826fdf <[emu10k1]copy_block+f3/100>
Trace; c013c539 <do_select+1f9/214>
Trace; c010a9c4 <error_code+34/40>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c013c668 <sys_select+ec/5a8>
Trace; d18233cc <[emu10k1]emu10k1_audio_ioctl+0/f4>
Trace; c010a883 <system_call+33/40>
Code;  c0119e8c <do_exit+d4/1f4>
00000000 <_EIP>:
Code;  c0119e8c <do_exit+d4/1f4>   <=====
    0:   ff 0b                     decl   (%ebx)   <=====
Code;  c0119e8e <do_exit+d6/1f4>
   2:   0f 94 c0                  sete   %al
Code;  c0119e91 <do_exit+d9/1f4>
   5:   84 c0                     testb  %al,%al
Code;  c0119e93 <do_exit+db/1f4>
   7:   0f 84 b6 00 00 00         je     c3 <_EIP+0xc3> c0119f4f
<do_exit+197/1f4>
Code;  c0119e99 <do_exit+e1/1f4>
   d:   8b 43 0c                  movl   0xc(%ebx),%eax
Code;  c0119e9c <do_exit+e4/1f4>
  10:   50                        pushl  %eax
Code;  c0119e9d <do_exit+e5/1f4>
  11:   e8 de 58 00 00            call   58f4 <_EIP+0x58f4> c011f780
<remap_page_range+274/350>

Unable to handle kernel NULL pointer dereference at virtual address
00000018
c0111340
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0111340>]
EFLAGS: 00010006
eax: c56ba558   ebx: c56ba000   ecx: 00000206   edx: 00000018
esi: c56ba000   edi: 0000000b   ebp: ec0dc836   esp: c56bbc40
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 1391, stackpage=c56bb000)
Stack: c56ba000 c01113c3 c56ba558 00000000 c0119f55 c56ba000 00000000
000003b0
       c0110a84 c010adae 0000000b c0110db2 c01e929e c56bbd24 00000002
c56ba000
       00000002 c0110a84 ec4b6b57 00000000 00000000 c021bd00 30000007
c021bd32
Call Trace: [<c01113c3>] [<c0119f55>] [<c0110a84>] [<c010adae>]
[<c0110db2>] [<c01e929e>] [<c0110a84>]
       [<ec4b6b57>] [<c021bd00>] [<c021bd32>] [<c01e1c39>] [<c01e1c39>]
[<c010a883>] [<c016bd09>] [<c01e1c39>]
       [<c016bd09>] [<c016bd09>] [<c011776a>] [<c010a9c4>] [<ec0dc836>]
[<ec4b6b57>] [<c0119e8c>] [<c0110a84>]
       [<c010adae>] [<c0110db2>] [<c01e929e>] [<c0110a84>] [<ec4b6b63>]
[<c021bd00>] [<c021bd00>] [<c021bd30>]
       [<c01e1c39>] [<c01e1c39>] [<c010a883>] [<c016bd09>] [<c01e1c39>]
[<c016bd09>] [<c016bd09>] [<c010a9c4>]
       [<ec4b6b57>] [<ec4b6b63>] [<ec4b6b57>] [<c011983c>] [<ec4b6b63>]
[<c0119e71>] [<ec4b6b57>] [<c0110a84>]
       [<c010adae>] [<c0110db2>] [<c01e929e>] [<c0110a84>] [<c0115198>]
[<d1826fdf>] [<c013c539>] [<c010a9c4>]
       [<ec4b6b57>] [<c013c668>] [<d18233cc>] [<c010a883>]
Code: 8b 1a 52 a1 c0 6f 27 c0 50 e8 3e 5e 01 00 83 c4 08 ff 0d b4

>>EIP; c0111340 <flush_sigqueue+24/44>   <=====
Trace; c01113c3 <exit_sighand+47/50>
Trace; c0119f55 <do_exit+19d/1f4>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c010adae <die+42/44>
Trace; c0110db2 <do_page_fault+32e/40c>
Trace; c01e929e <IRQ0x0f_interrupt+2a6e/54b8>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c021bd00 <msstab+d4e/f4e>
Trace; c021bd32 <msstab+d80/f4e>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c010a883 <system_call+33/40>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c011776a <printk+18e/19c>
Trace; c010a9c4 <error_code+34/40>
Trace; ec0dc836 <END_OF_CODE+1a872213/????>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c0119e8c <do_exit+d4/1f4>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c010adae <die+42/44>
Trace; c0110db2 <do_page_fault+32e/40c>
Trace; c01e929e <IRQ0x0f_interrupt+2a6e/54b8>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; c021bd00 <msstab+d4e/f4e>
Trace; c021bd00 <msstab+d4e/f4e>
Trace; c021bd30 <msstab+d7e/f4e>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c010a883 <system_call+33/40>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c010a9c4 <error_code+34/40>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c011983c <put_files_struct+8/b4>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; c0119e71 <do_exit+b9/1f4>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c010adae <die+42/44>
Trace; c0110db2 <do_page_fault+32e/40c>
Trace; c01e929e <IRQ0x0f_interrupt+2a6e/54b8>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; c021bd00 <msstab+d4e/f4e>
Trace; c021bd00 <msstab+d4e/f4e>
Trace; c021bd30 <msstab+d7e/f4e>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c010a883 <system_call+33/40>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c01e1c39 <vsprintf+3ad/3e8>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c016bd09 <vt_console_print+79/2f0>
Trace; c010a9c4 <error_code+34/40>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c011983c <put_files_struct+8/b4>
Trace; ec4b6b63 <END_OF_CODE+1ac4c540/????>
Trace; c0119e71 <do_exit+b9/1f4>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c010adae <die+42/44>
Trace; c0110db2 <do_page_fault+32e/40c>
Trace; c01e929e <IRQ0x0f_interrupt+2a6e/54b8>
Trace; c0110a84 <do_page_fault+0/40c>
Trace; c0115198 <schedule+2d8/430>
Trace; d1826fdf <[emu10k1]copy_block+f3/100>
Trace; c013c539 <do_select+1f9/214>
Trace; c010a9c4 <error_code+34/40>
Trace; ec4b6b57 <END_OF_CODE+1ac4c534/????>
Trace; c013c668 <sys_select+ec/5a8>
Trace; d18233cc <[emu10k1]emu10k1_audio_ioctl+0/f4>
Trace; c010a883 <system_call+33/40>
Code;  c0111340 <flush_sigqueue+24/44>
00000000 <_EIP>:
Code;  c0111340 <flush_sigqueue+24/44>   <=====
   0:   8b 1a                     movl   (%edx),%ebx   <=====
Code;  c0111342 <flush_sigqueue+26/44>
   2:   52                        pushl  %edx
Code;  c0111343 <flush_sigqueue+27/44>
   3:   a1 c0 6f 27 c0            movl   0xc0276fc0,%eax
Code;  c0111348 <flush_sigqueue+2c/44>
   8:   50                        pushl  %eax
Code;  c0111349 <flush_sigqueue+2d/44>
   9:   e8 3e 5e 01 00            call   15e4c <_EIP+0x15e4c> c012718c
<kmem_cache_free+0/b8>
Code;  c011134e <flush_sigqueue+32/44>
   e:   83 c4 08                  addl   $0x8,%esp
Code;  c0111351 <flush_sigqueue+35/44>
  11:   ff 0d b4 00 00 00         decl   0xb4


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
