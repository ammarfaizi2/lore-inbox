Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265615AbSJXTdO>; Thu, 24 Oct 2002 15:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265624AbSJXTdO>; Thu, 24 Oct 2002 15:33:14 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:32175 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265615AbSJXTdL>; Thu, 24 Oct 2002 15:33:11 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
References: <3DB82ABF.8030706@colorfullife.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 24 Oct 2002 21:39:03 +0200
Message-ID: <87of9jwrs8.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu,
> chipset and memory type?

Duron 1200, Elitegroup K7VTA3, 512 MB (DDR PC266 CL2.5)

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 7
model name	: AMD Duron(tm) processor
stepping	: 1
cpu MHz		: 1200.023
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2367.48

$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

$ gcc athlon.c -o athlon
$ ./athlon 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 15795 cycles per page
copy_page function '2.4 non MMX'         took 16958 cycles per page
copy_page function '2.4 MMX fallback'    took 16862 cycles per page
copy_page function '2.4 MMX version'     took 15792 cycles per page
copy_page function 'faster_copy'         took 9576 cycles per page
copy_page function 'even_faster'         took 9385 cycles per page
copy_page function 'no_prefetch'         took 7637 cycles per page
$ ./athlon 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 15802 cycles per page
copy_page function '2.4 non MMX'         took 16957 cycles per page
copy_page function '2.4 MMX fallback'    took 16897 cycles per page
copy_page function '2.4 MMX version'     took 15854 cycles per page
copy_page function 'faster_copy'         took 9564 cycles per page
copy_page function 'even_faster'         took 9407 cycles per page
copy_page function 'no_prefetch'         took 7649 cycles per page
$ ./athlon 
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'         took 15807 cycles per page
copy_page function '2.4 non MMX'         took 16995 cycles per page
copy_page function '2.4 MMX fallback'    took 17056 cycles per page
copy_page function '2.4 MMX version'     took 16431 cycles per page
copy_page function 'faster_copy'         took 9832 cycles per page
copy_page function 'even_faster'         took 9389 cycles per page
copy_page function 'no_prefetch'         took 7657 cycles per page
