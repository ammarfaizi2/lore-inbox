Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTIPTro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTIPTro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:47:44 -0400
Received: from violet.noc.ucla.edu ([169.232.47.18]:12507 "EHLO
	violet.noc.ucla.edu") by vger.kernel.org with ESMTP id S262490AbTIPTrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:47:40 -0400
Date: Tue, 16 Sep 2003 12:47:40 -0700 (PDT)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: oops with 2.4.21
Message-ID: <Pine.LNX.4.58.0309161234070.8497@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine running 2.4.21 that has been crashing relatively
regularly.  The following oops appeared in the logs this morning, shortly
before the machine locked up.  ver_linux and ksymoops out are below.

Prior to reboot, the console showed

Code: Kernel BUG in header file at line 66
Kernel BUG at panic.c: 141!



-Chris

cbs@tomato:/usr/src/linux-2.4.21 > sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux tomato 2.4.21 #1 SMP Sun Aug 3 03:07:38 PDT 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         st



cbs@tomato:~ > ksymoops < oops
ksymoops 2.4.5 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address ffffffdc
c013f553
*pde = 00003063
Oops: 0002
CPU:    1
EIP:    0010:[link_path_walk+1947/2404]    Not tainted
EFLAGS: 00010246
eax: c3f7c920   ebx: f75ed640   ecx: 00000000   edx: 00000001
esi: c3f7c920   edi: e7849cf0   ebp: e7849c48   esp: e7849c14
ds: 0018   es: 0018   ss: 0018
Process mrtg (pid: 21308, stackpage=e7849000)
Stack: e7849cf0 c3faf140 f75ed940 f78aaf84 00000001 00000000 00030002 00000001
       f75ed94b c3f7c920 f75ed940 0000000b 4057c322 e7849c64 c0141cf7 e7848000
       c3faf140 e7849cf0 0000000d 00000000 e7849c74 c0170a00 e7849cf0 f75ed940
Call Trace:    [vfs_follow_link+283/400] [ext2_follow_link+24/40] [link_path_walk+2069/2404] [path_walk+29/36] [path_lookup+30/44] [open_exec+27/188] [load_elf_binary+719/2956] [load_elf_binary+0/2956] [search_binary_handler+124/332] [do_execve+328/408] [sys_execve+47/92] [system_call+51/56]
Code: 83 49 dc 00 0f 84 b3 00 00 00 85 db 0f 84 ab 00 00 00 8b 83
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c3f7c920 <_end+3c5002c/3877d70c>
>>ebx; f75ed640 <_end+372c0d4c/3877d70c>
>>esi; c3f7c920 <_end+3c5002c/3877d70c>
>>edi; e7849cf0 <_end+2751d3fc/3877d70c>
>>ebp; e7849c48 <_end+2751d354/3877d70c>
>>esp; e7849c14 <_end+2751d320/3877d70c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 49 dc 00               orl    $0x0,0xffffffdc(%ecx)
Code;  00000004 Before first symbol
   4:   0f 84 b3 00 00 00         je     bd <_EIP+0xbd> 000000bd Before first symbol
Code;  0000000a Before first symbol
   a:   85 db                     test   %ebx,%ebx
Code;  0000000c Before first symbol
   c:   0f 84 ab 00 00 00         je     bd <_EIP+0xbd> 000000bd Before first symbol
Code;  00000012 Before first symbol
  12:   8b 83 00 00 00 00         mov    0x0(%ebx),%eax


1 warning issued.  Results may not be reliable.

