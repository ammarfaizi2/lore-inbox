Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTJJTFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTJJTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:05:34 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:25475 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263120AbTJJTFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:05:12 -0400
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031010184241.GC32600@redhat.com>
References: <1065784536.2071.3.camel@paragon.slim>
	 <20031010184241.GC32600@redhat.com>
Content-Type: text/plain
Message-Id: <1065812601.1842.6.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 10 Oct 2003 21:03:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-10 at 20:42, Dave Jones wrote:
> On Fri, Oct 10, 2003 at 01:15:37PM +0200, Jurgen Kramer wrote:
> 
>  > It seems that longhaul support in 2.6.0-test7 is still not working
>  > properly...:-(. 
>  > 
>  > longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v2 supported.
>  > longhaul: Bogus values Min:0.000 Max:0.000. Voltage scaling disabled.
>  > longhaul: MinMult=5.0x MaxMult=6.0x
>  > longhaul: FSB: 0MHz Lowestspeed=0MHz Highestspeed=0MHz
> 
> Oh boy, this is a real egg-on-face bug if I'm right..
> edit arch/i386/kernel/cpu/cpufreq/longhaul.c and change line
> 394 to read longhaul_version = 1;
> I suspect things will suddenly start making a lot more sense.
> 
> 		Dave
Ok, changing line 394 gives:

<snip>
longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v1 supported.
longhaul: MinMult=3.0x MaxMult=6.0x
longhaul: FSB: 133MHz Lowestspeed=399MHz Highestspeed=798MHz
<snip>

But should it really be v1? With 2.4.20 I get:

ep 28 21:09:28 paradox kernel: longhaul: VIA CPU detected. Longhaul
version 2 supported
Sep 28 21:09:28 paradox kernel: longhaul: CPU currently at 798MHz (133 x
6.0)
Sep 28 21:09:28 paradox kernel: longhaul: MinMult(x10)=30
MaxMult(x10)=60
Sep 28 21:09:28 paradox kernel: longhaul: Lowestspeed=399000
Highestspeed=798000
Sep 28 21:09:28 paradox kernel: longhaul: New FSB:133 Mult(x10):60
Sep 28 21:09:28 paradox kernel: longhaul: New FSB:133 Mult(x10):30

x86info -a gives (running 2.6.0test7):

x86info v1.12b.  Dave Jones 2001-2003
Feedback to <davej@redhat.com>.

Found 1 CPU
--------------------------------------------------------------------------
eax in: 0x00000000, eax = 00000001 ebx = 746e6543 ecx = 736c7561 edx =
48727561
eax in: 0x00000001, eax = 00000678 ebx = 00000000 ecx = 00000000 edx =
00803135

eax in: 0x80000000, eax = 80000006 ebx = 00000000 ecx = 00000000 edx =
00000000
eax in: 0x80000001, eax = 00000678 ebx = 00000000 ecx = 00000000 edx =
80803135
eax in: 0x80000002, eax = 20414956 ebx = 61727a45 ecx = 00000000 edx =
00000000
eax in: 0x80000003, eax = 00000000 ebx = 00000000 ecx = 00000000 edx =
00000000
eax in: 0x80000004, eax = 00000000 ebx = 00000000 ecx = 00000000 edx =
00000000
eax in: 0x80000005, eax = 00000000 ebx = 08800880 ecx = 40040120 edx =
40040120
eax in: 0x80000006, eax = 00000000 ebx = 00000000 ecx = 40040120 edx =
00000000

Family: 6 Model: 7 Stepping: 8
CPU Model : VIA C3 (Samuel 2) [C5B]
Feature flags:
        Onboard FPU
        Debugging Extensions
        Time Stamp Counter
        Model-Specific Registers
        CMPXCHG8 instruction
        Memory Type Range Registers
        Page Global Enable
        MMX support

Extended feature flags:
 3dnow
Instruction TLB: 8-way associative. 128 entries.
Data TLB: 8-way associative. 128 entries.
L1 Data cache:
        Size: 64Kb      4-way associative.
        lines per tag=1 line size=32 bytes.
L1 Instruction cache:
        Size: 64Kb      4-way associative.
        lines per tag=1 line size=32 bytes.
L2 cache size errata detected. Using workaround
L2 (on CPU) cache:
        Size: 64Kb      4-way associative.
        lines per tag=1 line size=32 bytes.
/dev/cpu/0/msr: No such device
FCR: Couldn't read MSR 0x1107
Power management: Longhaul v2.0

MTRR registers:
MTRRcap (0xfe): MTRRphysBase0 (0x200): MTRRphysMask0 (0x201):
MTRRphysBase1 (0x202): MTRRphysMask1 (0x203): MTRRphysBase2 (0x204):
MTRRphysMask2 (0x205): MTRRphysBase3 (0x206): MTRRphysMask3 (0x207):
MTRRphysBase4 (0x208): MTRRphysMask4 (0x209): MTRRphysBase5 (0x20a):
MTRRphysMask5 (0x20b): MTRRphysBase6 (0x20c): MTRRphysMask6 (0x20d):
MTRRphysBase7 (0x20e): MTRRphysMask7 (0x20f): MTRRfix64K_00000 (0x250):
MTRRfix16K_80000 (0x258): MTRRfix16K_A0000 (0x259): MTRRfix4K_C8000
(0x269): MTRRfix4K_D0000 0x26a: MTRRfix4K_D8000 0x26b: MTRRfix4K_E0000
0x26c: MTRRfix4K_E8000 0x26d: MTRRfix4K_F0000 0x26e: MTRRfix4K_F8000
0x26f: MTRRdefType (0x2ff):

800MHz processor (estimate).

Greetings,

Jurgen







