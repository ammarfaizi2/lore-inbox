Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTDPGbK (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 02:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264249AbTDPGbJ 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 02:31:09 -0400
Received: from qwws.net ([213.133.103.108]:7661 "HELO qwwsII.qwws.net")
	by vger.kernel.org with SMTP id S264248AbTDPGbG 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 02:31:06 -0400
From: Tom Winkler <tom@qwws.net>
Reply-To: tom@qwws.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre7(ac1) - BUG at filemap.c:81
Date: Wed, 16 Apr 2003 08:42:56 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304160842.56620.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a followup message to my previous report with more detailed
information this time.


summary:

Kernel reports BUG in filemap.c


full description:

The bug message shows up "from time to time" but can also be
reproduced on my system (see below).
After such a message gets displayed the system keeps running
without noticeable problems.

kernel version:

Linux version 2.4.21-pre7-ac1 (tom@thunder) (gcc version 3.2.3 20030331 
(Debian prerelease))


additional patches applied to the kernel:

acpi-20030328 [ url: 
http://sourceforge.net/project/showfiles.php?group_id=36832 ]
i810fb (0.0.35-lite) [ url: http://i810fb.sourceforge.net/ ]


output of Oops:

ksymoops 2.4.8 on i686 2.4.21-pre7-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre7-ac1/ (default)
     -m /boot/System.map-2.4.21-pre7-ac1 (specified)

kernel BUG at filemap.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d03e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0a610000   ebx: 00000000   ecx: c11a5fe0   edx: cfe75c5c
esi: c11a5fe0   edi: cfe75c5c   ebp: cd98a820   esp: cd66feb4
ds: 0018   es: 0018   ss: 0018
Process hdparm (pid: 248, stackpage=cd66f000)
Stack: 00000000 c012da32 cd6767e4 00003643 cfe75c5c c012dad6 c11a5fe0 cd6767e4
       00003643 cfe75c5c c11a5fe0 00000004 0000363f cd98a820 004a8530 c012e119
       0000001f 00000020 00003621 cd98a820 c11a663c cd6767e4 00003621 c012e50c
Call Trace:    [<c012da32>] [<c012dad6>] [<c012e119>] [<c012e50c>] 
[<c012e8d0>]
  [<c012ea18>] [<c012e8d0>] [<c013be03>] [<c010740f>]
Code: 0f 0b 51 00 3d 55 2e c0 ff 05 64 a2 32 c0 5b c3 89 f6 83 ec


>>EIP; c012d03e <do_readahead+7e/a0>   <=====

>>ecx; c11a5fe0 <_end+de47fc/145b287c>
>>edx; cfe75c5c <_end+fab4478/145b287c>
>>esi; c11a5fe0 <_end+de47fc/145b287c>
>>edi; cfe75c5c <_end+fab4478/145b287c>
>>ebp; cd98a820 <_end+d5c903c/145b287c>
>>esp; cd66feb4 <_end+d2ae6d0/145b287c>

Trace; c012da32 <madvise_fixup_middle+a2/190>
Trace; c012dad6 <madvise_fixup_middle+146/190>
Trace; c012e119 <sys_mincore+79/140>
Trace; c012e50c <generic_file_write+27c/760>
Trace; c012e8d0 <generic_file_write+640/760>
Trace; c012ea18 <remove_suid+28/70>
Trace; c012e8d0 <generic_file_write+640/760>
Trace; c013be03 <write_some_buffers+13/e0>
Trace; c010740f <simd_coprocessor_error+3/c>

Code;  c012d03e <do_readahead+7e/a0>
00000000 <_EIP>:
Code;  c012d03e <do_readahead+7e/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d040 <do_readahead+80/a0>
   2:   51                        push   %ecx
Code;  c012d041 <do_readahead+81/a0>
   3:   00 3d 55 2e c0 ff         add    %bh,0xffc02e55
Code;  c012d047 <do_readahead+87/a0>
   9:   05 64 a2 32 c0            add    $0xc032a264,%eax
Code;  c012d04c <do_readahead+8c/a0>
   e:   5b                        pop    %ebx
Code;  c012d04d <do_readahead+8d/a0>
   f:   c3                        ret
Code;  c012d04e <do_readahead+8e/a0>
  10:   89 f6                     mov    %esi,%esi
Code;  c012d050 <do_readahead+90/a0>
  12:   83 ec 00                  sub    $0x0,%esp


problem can be triggered by:

hdparm -tT


software:

Debian Sid (unstable)

ver_linux script reports:

Linux thunder 2.4.21-pre7-ac1 #2 Die Apr 15 23:02:39 CEST 2003 i686 unknown 
unknown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
pcmcia-cs              3.2.2
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.9
Modules Loaded         nls_iso8859-15 nls_cp437 sonypi rtc



processor information:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 695.567
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse
bogomips        : 1389.36



lspci output:

http://www.wnk.at/tmp/lspci.txt


dmesg output:

http://www.wnk.at/tmp/dmesg.txt


bye,
-- 
Tom Winkler
e-mail: tom@qwws.net
