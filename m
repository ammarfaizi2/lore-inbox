Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVD1TaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVD1TaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVD1TaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:30:23 -0400
Received: from mail.tyan.com ([66.122.195.4]:23304 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262243AbVD1T3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:29:49 -0400
Message-ID: <3174569B9743D511922F00A0C943142309B079F4@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: YhLu <YhLu@tyan.com>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: x86-64 dual core mapping
Date: Thu, 28 Apr 2005 12:49:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please refer to my patch about that.

YH

before patch
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Booting processor 1/1 rip 6000 rsp ffff81007ff99f58
Initializing CPU#1
masked ExtINT on CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 0
 stepping 00
Synced TSC of CPU 1 difference 21474835384
Booting processor 2/2 rip 6000 rsp ffff81013ffa3f58
Initializing CPU#2
masked ExtINT on CPU#2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 1
 stepping 00
Synced TSC of CPU 2 difference 21474835425
Booting processor 3/3 rip 6000 rsp ffff81007ff49f58
Initializing CPU#3
masked ExtINT on CPU#3
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(2) -> Node 1 -> Core 1
 stepping 00
Synced TSC of CPU 3 difference 21474835425
Brought up 4 CPUs


~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 3956.73
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 2
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 3
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

~ # 



after patch


CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Booting processor 1/1 rip 6000 rsp ffff81007ff99f58
Initializing CPU#1
masked ExtINT on CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 00
Synced TSC of CPU 1 difference 21474835384
Booting processor 2/2 rip 6000 rsp ffff81013ffa3f58
Initializing CPU#2
masked ExtINT on CPU#2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 0
 stepping 00
Synced TSC of CPU 2 difference 21474835425
Booting processor 3/3 rip 6000 rsp ffff81007ff49f58
Initializing CPU#3
masked ExtINT on CPU#3
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(2) -> Node 1 -> Core 1
 stepping 00
Synced TSC of CPU 3 difference 21474835425
Brought up 4 CPUs


~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 3956.73
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 2
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 1
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 3
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 1
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

~ # 







amd_dual_core_id.diff


--- setup.o.c   2005-04-28 12:41:12.823456408 -0700
+++ setup.c     2005-04-28 13:11:04.187127736 -0700
@@ -731,19 +731,20 @@
        int node = 0;
        if (c->x86_num_cores == 1)
                return;
-       cpu_core_id[cpu] = cpu >> hweight32(c->x86_num_cores - 1);
+       cpu_core_id[cpu] = cpu%c->x86_num_cores;

 #ifdef CONFIG_NUMA
        /* When an ACPI SRAT table is available use the mappings from SRAT
           instead. */
        if (acpi_numa <= 0) {
-               node = cpu_core_id[cpu];
+               node = cpu >> hweight32(c->x86_num_cores - 1);
                if (!node_online(node))
                        node = first_node(node_online_map);
                cpu_to_node[cpu] = node;
        } else {
                node = cpu_to_node[cpu];
        }
+       phys_proc_id[cpu] = node;
 #endif
        printk(KERN_INFO "CPU %d(%d) -> Node %d -> Core %d\n",
                        cpu, c->x86_num_cores, node, cpu_core_id[cpu]);
--- smpboot.o.c 2005-04-28 13:00:03.611550488 -0700
+++ smpboot.c   2005-04-28 12:59:27.151093320 -0700
@@ -652,7 +652,7 @@
                int i;
                if (smp_num_siblings > 1) {
                        for_each_online_cpu (i) {
-                               if (cpu_core_id[cpu] == cpu_core_id[i]) {
+                               if (cpu_to_node[cpu] == cpu_to_node[i]) {
                                        siblings++;
                                        cpu_set(i, cpu_sibling_map[cpu]);
                                }
