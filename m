Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277539AbRJESQc>; Fri, 5 Oct 2001 14:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJESQY>; Fri, 5 Oct 2001 14:16:24 -0400
Received: from chaos.ao.net ([205.244.242.21]:23458 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S277539AbRJESQO>;
	Fri, 5 Oct 2001 14:16:14 -0400
Message-Id: <200110051816.f95IGRW2008474@vulpine.ao.net>
To: linux-kernel@vger.kernel.org
Subject: Wierd /proc/cpuinfo with 2.4.11-pre4
Date: Fri, 05 Oct 2001 14:16:27 -0400
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From dmesg:
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0b
Checking 'hlt' instruction... OK.

Looks normal.  Let's see /proc/cpuinfo...

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 11
cpu MHz		: 132.634
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 264.60

processor	: 1
vendor_id	: unknown
cpu family	: 0
model		: 0
model name	: unknown
stepping	: 16
cpu MHz		: 132.634
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: yes
fpu		: yes
fpu_exception	: yes
cpuid level	: 0
wp		: yes
flags		: fpu vme de pse tsc 3dnow lrti
bogomips	: 0.02

processor	: 2
vendor_id	: ú⁄0¿œ0¿
cpu family	: 156
model		: 48
model name	: 
stepping	: 192
cpu MHz		: 132.634
cache size	: 0 KB
fdiv_bug	: yes
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 0
wp		: yes
flags		: fpu de tsc msr pae mce apic pge cmov pat clflush dts ia64 recovery longrun lrti
bogomips	: 644790.84

processor	: 3
vendor_id	: L£)¿
cpu family	: 86
model		: 41
model name	: ∏⁄0¿∏œ0¿
stepping	: 192
cache size	: 0 KB
fdiv_bug	: no
hlt_bug		: yes
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1048575
wp		: no
flags		: syscall 3dnowext 3dnow
bogomips	: 0.00

processor	: 4
vendor_id	: ÖØ)¿ÅØ)¿}Ø)¿yØ)¿uØ)¿pØ)¿
cpu family	: 0
model		: 0
model name	: uØ)¿pØ)¿
stepping	: 0
cpu MHz		: 132.634
fdiv_bug	: yes
hlt_bug		: yes
f00f_bug	: yes
coma_bug	: yes
fpu		: no
fpu_exception	: no
cpuid level	: 1
wp		: no
flags		: fpu tsc msr pae mce apic pge cmov pat clflush dts ia64 syscall 3dnowext 3dnow recovery lrti cxmmx centaur_mcr
bogomips	: 0.00

processor	: 5
vendor_id	: unknown
cpu family	: 0
model		: 0
model name	: unknown
stepping	: 0
fdiv_bug	: yes
hlt_bug		: yes
f00f_bug	: no
coma_bug	: yes
fpu		: no
fpu_exception	: no
cpuid level	: 0
wp		: no
flags		: cxmmx k6_mtrr cyrix_arr
bogomips	: 0.00

processor	: 6
vendor_id	: unknown
cpu family	: 0
model		: 0
model name	: unknown
stepping	: 0
cache size	: 0 KB
fdiv_bug	: no
hlt_bug		: yes
f00f_bug	: no
coma_bug	: no
fpu		: no
fpu_exception	: no
cpuid level	: 0
wp		: no
flags		:
bogomips	: 0.00

processor	: 7
vendor_id	: unknown
cpu family	: 0
model		: 0
model name	: unknown
stepping	: 0
cache size	: 515 KB
fdiv_bug	: no
hlt_bug		: yes
f00f_bug	: yes
coma_bug	: yes
fpu		: no
fpu_exception	: no
cpuid level	: 0
wp		: no
flags		:
bogomips	: 644464.70


Wow!  That's pretty impressive, a new kernel build gives me an 
additional _7_ CPUs!

Interesting bits of .config:

CONFIG_M586TSC=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

Won't compile with UP APIC turned on, as others have noted.

Aside from /bin/ps getting confused about the system capabilities, it
seems stable.

--Dan

