Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285631AbRLGW7W>; Fri, 7 Dec 2001 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285637AbRLGW7S>; Fri, 7 Dec 2001 17:59:18 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:1667 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S285631AbRLGW7G>; Fri, 7 Dec 2001 17:59:06 -0500
Message-ID: <001701c17f72$afb02340$0801a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.14 opps in ide-scsi
Date: Fri, 7 Dec 2001 22:57:47 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

the only scsi i have on this is the ide-scsi emulation
for a cd writer and also a normall drive.

i was doing a
mount cdrom
dd if=cdrom/filename of=otherfilename bs=8192k

the file on the disk was about 640 MB
and then this arrived. this worked fine early on another cd
i have not tried to reproduce yet but i will try.

dont suppose anyone knows where i can find a ksymopps tutorial
other that the one in Documents/ksymoops.txt i have read it many times and
never really learnt anything
from it.

ksymoops 2.4.1 on i586 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map-2.4.14 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Error (fopen_local): read_system_map fopen '/boot/System.map-2.4.14' failed
*pde = 00000000
Oops: 000
CPU: 0
EIP: 0010:[<c01d12f6>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 695aee4f   ebx: c1ddf800     ecx: c03370f0       edx: c0310177
esi: 00000001   edi: cbfea400     ebp: c0337254       esp: c02cdf24
ds: 0018        es: 0018       ss:0018
Process swapper (pid: 0, stackpage=c02cd000)
Stack:  695aee4f c0337254 c13d1260 00000202 c03370f0 c01bcb70 c0337254
c01d1280
        c131faa0 04000001 0000000f c02cdf98 c010810a 0000000f c13d1260
c02cdf98
        c02cdf98 0000000f c030aae0 c131faa0 c010828d 0000000f c02cdf98
c131faa0
Call Trace: [<c01bcb70>] [<c01d1280>] [<c010810a>] [<c010828d>] [<c01051a0>]
[<c01051a0>] [<c01051c4>] [<c0105232>] [<c0105000>]
Code: 8b 50 18 42 89 50 18 8b 85 c8 00 00 00 8b 68 04 55 6a 01 e8

>>EIP; c01d12f6 <scsi_free+1896/aba0>   <=====
Trace; c01bcb70 <ide_intr+f0/150>
Trace; c01d1280 <scsi_free+1820/aba0>
Trace; c010810a <__up_wakeup+253e/2574>
Trace; c010828d <enable_irq+ed/130>
Trace; c01051a0 <enable_hlt+10/160>
Trace; c01051a0 <enable_hlt+10/160>
Trace; c01051c4 <enable_hlt+34/160>
Trace; c0105232 <enable_hlt+a2/160>
Trace; c0105000 <gdt+4db4/4f34>
Code;  c01d12f6 <scsi_free+1896/aba0>
00000000 <_EIP>:
Code;  c01d12f6 <scsi_free+1896/aba0>   <=====
   0:   8b 50 18                  mov    0x18(%eax),%edx   <=====
Code;  c01d12f9 <scsi_free+1899/aba0>
   3:   42                        inc    %edx
Code;  c01d12fa <scsi_free+189a/aba0>
   4:   89 50 18                  mov    %edx,0x18(%eax)
Code;  c01d12fd <scsi_free+189d/aba0>
   7:   8b 85 c8 00 00 00         mov    0xc8(%ebp),%eax
Code;  c01d1303 <scsi_free+18a3/aba0>
   d:   8b 68 04                  mov    0x4(%eax),%ebp
Code;  c01d1306 <scsi_free+18a6/aba0>
  10:   55                        push   %ebp
Code;  c01d1307 <scsi_free+18a7/aba0>
  11:   6a 01                     push   $0x1
Code;  c01d1309 <scsi_free+18a9/aba0>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c01d130e
<scsi_free+18ae/aba0>


2 warnings and 1 error issued.  Results may not be reliable.


thanks
    James

--------------------------
Mobile: +44 07779080838
http://www.stev.org
 10:50pm  up 24 min,  5 users,  load average: 6.26, 4.92, 2.68



