Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTCCPtD>; Mon, 3 Mar 2003 10:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTCCPtD>; Mon, 3 Mar 2003 10:49:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:8655 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266064AbTCCPs6>; Mon, 3 Mar 2003 10:48:58 -0500
Date: Mon, 03 Mar 2003 07:59:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 431] New: kernel BUG at include/linux/smp_lock.h:53!
Message-ID: <24420000.1046707162@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=431

           Summary: kernel BUG at include/linux/smp_lock.h:53!
    Kernel Version: 2.5.60 (gcc version 2.96 20000731 (Red Hat Linux 7.3
                    2.96-113))
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: theo@arum.et.tudelft.nl


Distribution: Redhat 7.3
Hardware Environment:

[root@salta linux-2.5.60]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 798.566
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1572.86

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 798.566
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1593.34


Software Environment:


[root@salta linux-2.5.60]# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux salta.et.tudelft.nl 2.5.60 #4 SMP Thu Feb 20 14:11:27 CET 2003 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      implemented
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11




Problem Description:

I have a smp server which crashes frequently ( once every few days).
At first i thought it must be hardware-related but i couldn't find anything. 
Finally, i learned that the switching off smp-support cures the problems.
I then tried a few different kernel-verions (they all crash) but the 2.5.60
kernel logs something which may be useful. 

This is in the logs, just before it crashes:


Feb 28 23:25:05 salta kernel: ------------[ cut here ]------------
Feb 28 23:25:05 salta kernel: kernel BUG at include/linux/smp_lock.h:53!
Feb 28 23:25:05 salta kernel: invalid operand: 0000
Feb 28 23:25:05 salta kernel: CPU:    1
Feb 28 23:25:05 salta kernel: EIP:    0060:[<c0207372>]    Not tainted
Feb 28 23:25:05 salta kernel: EFLAGS: 00010286
Feb 28 23:25:05 salta kernel: EIP is at sem_exit+0xe2/0x260
Feb 28 23:25:05 salta kernel: eax: f0000000   ebx: 00000000   ecx: e16306c0  
edx: c4b30000
Feb 28 23:25:05 salta kernel: esi: c4b30000   edi: f0000000   ebp: c4b31f44  
esp: c4b31f20
Feb 28 23:25:05 salta kernel: ds: 007b   es: 007b   ss: 0068
Feb 28 23:25:05 salta kernel: Process sshd (pid: 6289, threadinfo=c4b30000
task=e16306c0)
Feb 28 23:25:05 salta kernel: Stack: c93e76a0 c93e76a0 c4b30000 e16306c0
c4b31f40 c011ea57 c93e76a0 c4b30000
Feb 28 23:25:05 salta kernel:        e16306c0 c4b31fbc c012284c c4b31f64
c01423da f7ffc318 ceac9ae0 c4b30000
Feb 28 23:25:05 salta kernel:        ceac9ae0 c4b31f84 c01427ae c93e76a0
ceac9ae0 f7386260 00031000 c93e76a0
Feb 28 23:25:05 salta kernel: Call Trace:
Feb 28 23:25:05 salta kernel:  [<c011ea57>] mmput+0x57/0x80
Feb 28 23:25:05 salta kernel:  [<c012284c>] do_exit+0x18c/0x400
Feb 28 23:25:05 salta kernel:  [<c01423da>] unmap_vma_list+0x1a/0x30
Feb 28 23:25:05 salta kernel:  [<c01427ae>] do_munmap+0x12e/0x140
Feb 28 23:25:05 salta kernel:  [<c01413ee>] sys_brk+0x7e/0x100
Feb 28 23:25:05 salta kernel:  [<c014d16e>] sys_close+0x9e/0xd0
Feb 28 23:25:05 salta kernel:  [<c010aef7>] syscall_call+0x7/0xb
Feb 28 23:25:05 salta kernel:
Feb 28 23:25:05 salta kernel: Code: 0f 0b 35 00 80 95 2e c0 48 85 c0 89 41 14 0f
89 56 01 00 00
Feb 28 23:25:05 salta kernel:  ------------[ cut here ]------------
Feb 28 23:25:05 salta kernel: kernel BUG at include/linux/smp_lock.h:53!
Feb 28 23:25:05 salta kernel: invalid operand: 0000
Feb 28 23:25:05 salta kernel: CPU:    1
Feb 28 23:25:05 salta kernel: EIP:    0060:[<c0207372>]    Not tainted
Feb 28 23:25:05 salta kernel: EFLAGS: 00010282
Feb 28 23:25:05 salta kernel: EIP is at sem_exit+0xe2/0x260
Feb 28 23:25:05 salta kernel: eax: f0000001   ebx: 00000000   ecx: e16306c0  
edx: c4b30000
Feb 28 23:25:05 salta kernel: esi: c4b30000   edi: f0000001   ebp: c4b31da8  
esp: c4b31d84
Feb 28 23:25:05 salta kernel: ds: 007b   es: 007b   ss: 0068
Feb 28 23:25:05 salta kernel: Process sshd (pid: 6289, threadinfo=c4b30000
task=e16306c0)
Feb 28 23:25:05 salta kernel: Stack: 00000000 c036dde8 fffffffd c4b31db0
c012419b c4b30000 00000000 e16306c0
Feb 28 23:25:05 salta kernel:        e16306c0 c4b31e20 c012284c c4b31dd4
c01171b2 00000082 c03c5261 00000046
Feb 28 23:25:05 salta kernel:        00000001 c4b30000 c4b31eec c02e9357
c4b31e20 c010b8e6 c4b30000 c036d440
Feb 28 23:25:05 salta kernel: Call Trace:
Feb 28 23:25:05 salta kernel:  [<c012419b>] do_softirq+0x6b/0xd0
Feb 28 23:25:05 salta kernel:  [<c012284c>] do_exit+0x18c/0x400
Feb 28 23:25:05 salta kernel:  [<c01171b2>] smp_apic_timer_interrupt+0x112/0x140
Feb 28 23:25:05 salta kernel:  [<c010b8e6>] apic_timer_interrupt+0x1a/0x20
Feb 28 23:25:05 salta kernel:  [<c02e007b>] rpc_proc_read+0x1b/0x150
Feb 28 23:25:05 salta kernel:  [<c02e007b>] rpc_proc_read+0x1b/0x150
Feb 28 23:25:05 salta kernel:  [<c010be8f>] die+0x7f/0xa0
Feb 28 23:25:05 salta kernel:  [<c010c0e0>] do_invalid_op+0x0/0x90

Etc. etc. 


It reproduces. I have seen the exact same loggings at two different crashes.


Steps to reproduce:
Nothing special. Just boot & wait.


