Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSHDUsb>; Sun, 4 Aug 2002 16:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSHDUsa>; Sun, 4 Aug 2002 16:48:30 -0400
Received: from mail01.svc.cra.dublin.eircom.net ([159.134.118.17]:24912 "HELO
	mail01.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id <S318230AbSHDUs1> convert rfc822-to-8bit; Sun, 4 Aug 2002 16:48:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: John Kinsella <rfjak@gofree.indigo.ie>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 compile warning for AMD Athlon config
Date: Sun, 4 Aug 2002 21:56:23 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020804204827Z318230-685+23824@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


amd_adv_spec_cache_feature() tries to use have_cpuid_p(), which does not
exist in 2.4.x tree. 

This seems to have been introduced in 2.4.19-rc1, I guess I should have noticed it before.
A case of 2.4 being too stable perhaps, as it works fine so I didn't check compile log :)

/home/compo/2.4/2.4.19/arch/i386/kernel/setup.c: In function `amd_adv_spec_cache_feature':
/home/compo/2.4/2.4.19/arch/i386/kernel/setup.c:751: warning: implicit declaration of func
tion `have_cpuid_p'
/home/compo/2.4/2.4.19/arch/i386/kernel/setup.c: At top level:
/home/compo/2.4/2.4.19/arch/i386/kernel/setup.c:2629: warning: `have_cpuid_p' was declared
 implicitly `extern' and later `static'
/home/compo/2.4/2.4.19/arch/i386/kernel/setup.c:751: warning: previous declaration of `hav
 e_cpuid_p'

$ grep -nr have_cpuid_p *h
 arch/i386/kernel/setup.c:751:   if(!have_cpuid_p())
 arch/i386/kernel/setup.c:2628:static int __init have_cpuid_p(void)
 arch/i386/kernel/setup.c:2708:  return have_cpuid_p();  /* Check to see if CPUID now enabled? */
 arch/i386/kernel/setup.c:2728:  if ( !have_cpuid_p() && !id_and_try_enable_cpuid(c) ) {
 arch/i386/kernel/setup.c:3164:  if(!have_cpuid_p())

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

