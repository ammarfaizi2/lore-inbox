Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTLDDqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLDDqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:46:30 -0500
Received: from outbound1.mail.tds.net ([216.170.230.91]:40849 "EHLO
	outbound1.mail.tds.net") by vger.kernel.org with ESMTP
	id S262965AbTLDDqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:46:22 -0500
Message-Id: <200312040346.hB43kLDC008069@outbound1.mail.tds.net>
Content-Type: text/plain; charset=US-ASCII
From: Erik Meitner <lists@erik.wanderings.us>
Subject: 2.4.22-pac1 Oops when using /proc/cpufreq
Date: Wed, 3 Dec 2003 21:49:43 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops's occurr when trying to change CPU frequency(writing to /proc/cpufreq):

nx9:~# ksymoops < pac1-cpufreq-oops.txt 
ksymoops 2.4.5 on i686 2.4.22-pac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pac1/ (default)
     -m /boot/System.map-2.4.22-pac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01baf43
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01baf43>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: ffffffff   ecx: 00000000   edx: c9e5ff38
esi: 00000000   edi: 00000000   ebp: 00000014   esp: c9e5fee8
ds: 0018   es: 0018   ss: 0018
Process cpufreqd (pid: 525, stackpage=c9e5f000)
Stack: 00000000 c9e5ff38 c9e5ff38 c0111dc0 c9e5ff38 00000000 c0122b75 c9e5ff38
       00000000 c9e5ff38 c9e5ff38 00000014 c031959c c01bb3d3 c01bb416 c9e5ff38
       00000000 cd7182c0 ffffffea 00000014 00000000 00000000 00000000 00000001
Call Trace:    [<c0111dc0>] [<c0122b75>] [<c01bb3d3>] [<c01bb416>] [<c015279a>]
  [<c0134736>] [<c0106c5b>]
Code: 83 7e 04 fe 74 2f 8d b4 26 00 00 00 00 8b 44 ce 04 83 f8 ff


>>EIP; c01baf43 <cpufreq_frequency_table_verify+53/d0>   <=====

>>ebx; ffffffff <END_OF_CODE+3141ef00/????>
>>edx; c9e5ff38 <_end+9aab03c/e813104>
>>esp; c9e5fee8 <_end+9aaafec/e813104>

Trace; c0111dc0 <powernow_verify+10/20>
Trace; c0122b75 <cpufreq_set_policy+75/210>
Trace; c01bb3d3 <cpufreq_proc_write+53/b0>
Trace; c01bb416 <cpufreq_proc_write+96/b0>
Trace; c015279a <proc_file_write+2a/40>
Trace; c0134736 <sys_write+96/f0>
Trace; c0106c5b <system_call+33/38>

Code;  c01baf43 <cpufreq_frequency_table_verify+53/d0>
00000000 <_EIP>:
Code;  c01baf43 <cpufreq_frequency_table_verify+53/d0>   <=====
   0:   83 7e 04 fe               cmpl   $0xfffffffe,0x4(%esi)   <=====
Code;  c01baf47 <cpufreq_frequency_table_verify+57/d0>
   4:   74 2f                     je     35 <_EIP+0x35> c01baf78 <cpufreq_frequency_table_verify+88/d0>
Code;  c01baf49 <cpufreq_frequency_table_verify+59/d0>
   6:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01baf50 <cpufreq_frequency_table_verify+60/d0>
   d:   8b 44 ce 04               mov    0x4(%esi,%ecx,8),%eax
Code;  c01baf54 <cpufreq_frequency_table_verify+64/d0>
  11:   83 f8 ff                  cmp    $0xffffffff,%eax


1 warning issued.  Results may not be reliable.

nx9:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : mobile AMD Athlon(tm) XP2400+
stepping        : 0
cpu MHz         : 1788.929
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3565.15

Please let me know if you need any more info.

