Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268556AbRGYLNZ>; Wed, 25 Jul 2001 07:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268557AbRGYLNF>; Wed, 25 Jul 2001 07:13:05 -0400
Received: from hertz.ikp.physik.tu-darmstadt.de ([130.83.24.91]:640 "EHLO
	hertz.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S268556AbRGYLM4>; Wed, 25 Jul 2001 07:12:56 -0400
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15198.43454.169933.27008@hertz.ikp.physik.tu-darmstadt.de>
Date: Wed, 25 Jul 2001 13:13:02 +0200
To: linux-kernel@vger.kernel.org
Subject: Oops in IDE with PCMCIA and 2.4.7
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hallo,

running on pristine 2.4.7 with  pcmcia-cs.16-Jul-01.tar.gz
configured and compiled for 2.4.7, inserting a compact flash card triggers
following oops reproducable:
hertz:/spare/bon/pcmcia-cs-3.1.28 # ksymoops /tmp/oops
ksymoops 2.4.0 on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /boot/System.map-2.4.7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol icmpv6_socket  , ipv6 says
d09d2ec0, ...
Unable to handle kernel NULL pointer dereference at virtual address 00000028
c01d80dd
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01d80dd>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000000   ebx: 00000016   ecx: 00001600   edx: 0000000d
esi: 000003f0   edi: c031f2b0   ebp: 00000040   esp: ca3df6ac
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 1163, stackpage=ca3df000)
Stack: c031f2b0 00000000 c031f270 00000002 c031f38c 160018d4 00000000 c01d8164 
       00001600 00000000 ca3df73c c031f2b0 ca3df718 c01d81d1 c031f270 c01d8b6f 
       0000010e ca3df718 00000100 cc7ebda0 c031f28c 00000001 c01d8bf5 ca3df718 
Call Trace: [<c01d8164>] [<c01d81d1>] [<c01d8b6f>] [<c01d8bf5>] [<c0111e1b>] [<c01f2782>] [<c0228d0e>] 
       [<c01efb85>] [<c012c643>] [<c01124f6>] [<c01230a2>] [<c0123465>] [<c0140a97>] [<c0106f23>] 
Code: 83 78 28 00 74 09 57 8b 40 28 ff d0 83 c4 04 80 a7 ac 00 00 

>>EIP; c01d80dd <ide_revalidate_disk+101/134>   <=====
Trace; c01d8164 <revalidate_drives+54/70>
Trace; c01d81d1 <ide_driver_module+3d/40>
Trace; c01d8b6f <ide_register_hw+14b/17c>
Trace; c01d8bf5 <ide_register+55/60>
Trace; c0111e1b <reschedule_idle+63/21c>
Trace; c01f2782 <sock_def_readable+36/60>
Trace; c0228d0e <unix_dgram_sendmsg+396/400>
Trace; c01efb85 <sock_sendmsg+69/88>
Trace; c012c643 <__alloc_pages+73/27c>
Trace; c01124f6 <schedule+39e/5a8>
Trace; c01230a2 <unmap_fixup+62/158>
Trace; c0123465 <do_munmap+249/258>
Trace; c0140a97 <sys_ioctl+1bb/214>
Trace; c0106f23 <system_call+33/38>
Code;  c01d80dd <ide_revalidate_disk+101/134>
00000000 <_EIP>:
Code;  c01d80dd <ide_revalidate_disk+101/134>   <=====
   0:   83 78 28 00               cmpl   $0x0,0x28(%eax)   <=====
Code;  c01d80e1 <ide_revalidate_disk+105/134>
   4:   74 09                     je     f <_EIP+0xf> c01d80ec <ide_revalidate_disk+110/134>
Code;  c01d80e3 <ide_revalidate_disk+107/134>
   6:   57                        push   %edi
Code;  c01d80e4 <ide_revalidate_disk+108/134>
   7:   8b 40 28                  mov    0x28(%eax),%eax
Code;  c01d80e7 <ide_revalidate_disk+10b/134>
   a:   ff d0                     call   *%eax
Code;  c01d80e9 <ide_revalidate_disk+10d/134>
   c:   83 c4 04                  add    $0x4,%esp
Code;  c01d80ec <ide_revalidate_disk+110/134>
   f:   80 a7 ac 00 00 00 00      andb   $0x0,0xac(%edi)


-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
