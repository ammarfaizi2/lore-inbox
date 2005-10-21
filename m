Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVJUFRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVJUFRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 01:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbVJUFRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 01:17:35 -0400
Received: from [203.31.24.31] ([203.31.24.31]:28176 "EHLO www.syd.hutch.com.au")
	by vger.kernel.org with ESMTP id S964871AbVJUFRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 01:17:35 -0400
Subject: oops on SUSE LES9-SP2-smp on dual EM64T processor system
From: Emmett Lazich <elazich@hutchison.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Hutchison Telecoms
Message-Id: <1129871849.10237.22.camel@poppy.syd.hutch.com.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 Oct 2005 15:17:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  Hope you find this useful.
Posting to you after reading Documentation/oops-tracing.txt
I am still looking into how to report this fault to SUSE.
OS upgraded by SUSE SP2 (latest) CDROM. Cannot get online
update to work to see if newer patches available.

System has 2 x Intel P4/Xeon EM64T cpus. Hyper threading so seen as 4
cpus.  Production server in core network for a Telco in Australia. Not
looking good since I lobbied hard to put in Linux instead of Solaris.

After this oops, the machine kept running (phew!), however these
processes hang: ps, top, w.  However vmstat, iostat and uptime still
work ok. uptime says machine has a load average of around 20, but vmstat
and iostat say machine is near idle. We will reboot it with nosmp until
this fault is better understood.

dmesg output:
general protection fault: 0000 [1] SMP 
CPU 3 
Pid: 26432, comm: ps Not tainted (2.6.5-7.191-smp
SLES9_SP2_BRANCH-200506281458560000)
RIP: 0010:[<ffffffff80177e9b>] <ffffffff80177e9b>{get_user_pages+267}
RSP: 0018:000001000d843d58  EFLAGS: 00010202
RAX: 00009a4ef0009ff8 RBX: 00000000ffffe000 RCX: 0000010000000000
RDX: 0000994ef0009ff8 RSI: 000ffffffffff000 RDI: ffffffff803d4f00
RBP: 000001007c014400 R08: 0000000000000000 R09: 0000000000000001
R10: 00000000006e6f6d R11: 6c7265702f6e6962 R12: 0000000000000000
R13: 0000000000000000 R14: 000001007a6d73a0 R15: 0000000000000001
FS:  0000002a9588e6e0(0000) GS:ffffffff80563000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000040a7d0 CR3: 0000000037e4c000 CR4: 00000000000006e0
Process ps (pid: 26432, threadinfo 000001000d842000, task
00000100007fc250)
Stack: 0000010079541ca0 ffffffff8019c49b 000001000d843e98
0000000000000000 
       000fffffeff80106 0000000000000106 000000100d843de8
00000000ffffe000 
       0000000000000001 000001000d843e18 
Call Trace:<ffffffff8019c49b>{real_lookup+123}
<ffffffff80145423>{access_process_vm+179} 
       <ffffffff801c4d02>{proc_pid_cmdline+146}
<ffffffff801c418f>{proc_info_read+111} 
       <ffffffff8018d184>{vfs_read+244} <ffffffff8018d3dd>{sys_read+157}
       <ffffffff80189dd7>{sys_open+231}
<ffffffff80110794>{system_call+124} 
       

Code: 48 8b 00 48 c1 eb 09 81 e3 f8 0f 00 00 48 21 f0 48 01 d8 48 
RIP <ffffffff80177e9b>{get_user_pages+267} RSP <000001000d843d58>


--------------------
/proc/version
Linux version 2.6.5-7.191-smp (geeko@buildhost) (gcc version 3.3.3 (SuSE
Linux)) #1 SMP Tue Jun 28 14:58:56 UTC 2005

/proc/cmdline
root=/dev/sda5 vga=0x317 selinux=0 console=tty0 resume=/dev/sda3
elevator=cfq pci=nommconf splash=silent
---------------
iostat -x
avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.05    0.00    0.05    0.05   99.85

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util
sda          0.00   2.00  0.00  1.20    0.00   25.60     0.00   
12.80    21.33     0.00    0.17   0.17   0.02
sdb          0.00   1.00  0.00  0.80    0.00   14.40     0.00    
7.20    18.00     0.00    0.25   0.25   0.02
sdc          0.00   3.40  0.40  4.60    3.20   64.00     1.60   
32.00    13.44     0.00    0.80   0.52   0.26
sdd          0.00   1.20  0.00  0.60    0.00   14.40     0.00    
7.20    24.00     0.00    0.00   0.00   0.00
fd0          0.00   0.00  0.00  0.00    0.00    0.00     0.00    
0.00     0.00     0.00    0.00   0.00   0.00
-------------------------------------
cpuinfo:
cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 4
cpu MHz         : 3192.097
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm 
pni monitor ds_cpl cid
bogomips        : 6340.60
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 4
cpu MHz         : 3192.097
cache size      : 1024 KB
physical id     : 3
siblings        : 2
core id         : 3
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm 
pni monitor ds_cpl cid
bogomips        : 6373.37
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 4
cpu MHz         : 3192.097
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm 
pni monitor ds_cpl cid
bogomips        : 6373.37
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 4
cpu MHz         : 3192.097
cache size      : 1024 KB
physical id     : 3
siblings        : 2
core id         : 3
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm 
pni monitor ds_cpl cid
bogomips        : 6373.37
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual



