Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTDFKva (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbTDFKva (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:51:30 -0400
Received: from kestrel.vispa.uk.net ([62.24.228.12]:47122 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id S262914AbTDFKv2 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 06:51:28 -0400
Message-ID: <3E9016FE.5030806@walrond.org>
Date: Sun, 06 Apr 2003 13:01:02 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops 2.4-bk : kernel BUG at dcache.c:653!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've not used ksymoops before, so tell me if I can do something better...

ksymoops 2.4.9 on i686 2.4.21-pre7.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.21-pre7/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid 
lsmod file?
Warning (compare_maps): ksyms_base symbol 
__io_virt_debug_R__ver___io_virt_debug not found in System.map. 
Ignoring ksyms_base entry
kernel BUG at dcache.c:653!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0162b3d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c2841294   ebx: c28412c4   ecx: 00000500   edx: 000021b6
esi: f6e6d63c   edi: c2841294   ebp: f6e83e70   esp: f6e83e54
ds: 0018   es: 0018   ss: 0018
Process urandom (pid: 12, stackpage=f6e83000)
Stack: f6e87908 080c5766 f6e83f28 00000001 c036b300 00000000 c284261c 
f6e83eb8
        c019c74f c2841294 f6e6d63c c2841294 f6e8de28 c28347ac 00000000 
f6e82000
        00000000 00000000 00000000 f6e82000 00000000 00000000 c2841294 
f79b6008
Call Trace:    [<c019c74f>] [<c0156e83>] [<c01576cc>] [<c0157cda>] 
[<c01582da>]
   [<c0148191>] [<c0156a03>] [<c01485a1>] [<c0107bff>]
Code: 0f 0b 8d 02 c1 b5 31 c0 81 3d 04 17 3d c0 ad 4e ad de 74 1c


 >>EIP; c0162b3d <d_instantiate+1d/b0>   <=====

Trace; c019c74f <devfs_d_revalidate_wait+bf/190>
Trace; c0156e83 <cached_lookup+43/60>
Trace; c01576cc <link_path_walk+45c/840>
Trace; c0157cda <path_lookup+3a/40>
Trace; c01582da <open_namei+6a/610>
Trace; c0148191 <filp_open+41/70>
Trace; c0156a03 <getname+93/d0>
Trace; c01485a1 <sys_open+51/d0>
Trace; c0107bff <system_call+33/38>

Code;  c0162b3d <d_instantiate+1d/b0>
00000000 <_EIP>:
Code;  c0162b3d <d_instantiate+1d/b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0162b3f <d_instantiate+1f/b0>
    2:   8d 02                     lea    (%edx),%eax
Code;  c0162b41 <d_instantiate+21/b0>
    4:   c1                        (bad)
Code;  c0162b42 <d_instantiate+22/b0>
    5:   b5 31                     mov    $0x31,%ch
Code;  c0162b44 <d_instantiate+24/b0>
    7:   c0 81 3d 04 17 3d c0      rolb   $0xc0,0x3d17043d(%ecx)
Code;  c0162b4b <d_instantiate+2b/b0>
    e:   ad                        lods   %ds:(%esi),%eax
Code;  c0162b4c <d_instantiate+2c/b0>
    f:   4e                        dec    %esi
Code;  c0162b4d <d_instantiate+2d/b0>
   10:   ad                        lods   %ds:(%esi),%eax
Code;  c0162b4e <d_instantiate+2e/b0>
   11:   de 74 1c 00               fidiv  0x0(%esp,%ebx,1)


3 warnings issued.  Results may not be reliable.

