Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271936AbRHVGTV>; Wed, 22 Aug 2001 02:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271937AbRHVGTK>; Wed, 22 Aug 2001 02:19:10 -0400
Received: from smtp1.libero.it ([193.70.192.51]:54698 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S271936AbRHVGTD>;
	Wed, 22 Aug 2001 02:19:03 -0400
Message-ID: <3B834ED6.D71E7F03@iname.com>
Date: Wed, 22 Aug 2001 08:19:02 +0200
From: Luca Montecchiani <m.luca@iname.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an oops using fdupes(1) as a normal user.
I'm running a 2.4.9 kernel with the SetPageReferenced(page);
changes to mm/memory.c, investigating the oops with Daniel Philips 
seem that this is not the cause.

I can't reproduce the oops anymore :(
I'm using ext2 only file systems.

(1) fdupes scans directory for duplicate files, in my directory
    there are around 15.000 files.

Unfortunately I'd run ksymoops after recompiling the kernel :

ksymoops 2.4.1 on i586 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 21 14:46:35 localhost kernel: Unable to handle kernel paging request at virtual address 33ff08f8
Aug 21 14:46:35 localhost kernel: c012e488
Aug 21 14:46:35 localhost kernel: *pde = 00000000
Aug 21 14:46:35 localhost kernel: Oops: 0000
Aug 21 14:46:35 localhost kernel: CPU:    0
Aug 21 14:46:35 localhost kernel: EIP:    0010:[sys_read+160/196]
Aug 21 14:46:35 localhost kernel: EFLAGS: 00010206
Aug 21 14:46:35 localhost kernel: eax: 33ff080c   ebx: 00001000   ecx: 00001000   edx: 00000001
Aug 21 14:46:35 localhost kernel: esi: ccf338a0   edi: 00001000   ebp: bffffb84   esp: c7275fb4
Aug 21 14:46:35 localhost kernel: ds: 0018   es: 0018   ss: 0018
Aug 21 14:46:35 localhost kernel: Process fdupes (pid: 1401, stackpage=c7275000)
Aug 21 14:46:35 localhost kernel: Stack: c7274000 0823bad8 0823bad8 c0106be3 00000003 40015000 00001000 0823bad8
Aug 21 14:46:35 localhost kernel:        0823bad8 bffffb84 00000003 0000002b 0000002b 00000003 400dde14 00000023
Aug 21 14:46:35 localhost kernel:        00000202 bffffb6c 0000002b
Aug 21 14:46:35 localhost kernel: Call Trace: [system_call+51/64]
Aug 21 14:46:35 localhost kernel: Code: f6 80 ec 00 00 00 01 74 0b 6a 01 50 e8 e3 42 01 00 83 c4 08
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 80 ec 00 00 00 01      testb  $0x1,0xec(%eax)
Code;  00000007 Before first symbol
   7:   74 0b                     je     14 <_EIP+0x14> 00000014 Before first symbol
Code;  00000009 Before first symbol
   9:   6a 01                     push   $0x1
Code;  0000000b Before first symbol
   b:   50                        push   %eax
Code;  0000000c Before first symbol
   c:   e8 e3 42 01 00            call   142f4 <_EIP+0x142f4> 000142f4 Before first symbol
Code;  00000011 Before first symbol
  11:   83 c4 08                  add    $0x8,%esp


1 warning issued.  Results may not be reliable.


hope this help,
luca
-- 
------------------------------------------------------------------
E-mail......: Luca Montecchiani <m.luca@iname.com>
W.W.W.......: http://i.am/m.luca - http://luca.myip.org
Speakfreely.: sflwl -hlwl.fourmilab.ch luca@
I.C.Q.......: 17655604
-----------------------=(Linux since 1995)=-----------------------

Non esiste vento favorevole per il marinaio che non sa dove andare
                                                          Seneca
