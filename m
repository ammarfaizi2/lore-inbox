Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSFUOUL>; Fri, 21 Jun 2002 10:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSFUOUK>; Fri, 21 Jun 2002 10:20:10 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47890 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316621AbSFUOUE>; Fri, 21 Jun 2002 10:20:04 -0400
Date: Fri, 21 Jun 2002 16:19:57 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.24 doesn't compile on Alpha
Message-ID: <20020621141957.GA22555@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20020621064835.GA13502@alpha.of.nowhere> <000301c2191e$5a4a3080$010b10ac@sbp.uptime.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c2191e$5a4a3080$010b10ac@sbp.uptime.at>
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Pitzeier <o.pitzeier@uptime.at>
Date: Fri, Jun 21, 2002 at 02:22:42PM +0200
> Hi Thunder!
> [ ... ]
> > `smp_num_cpus' undeclared (first use in this function)
> [ .... ]
> > 
> > I know I can fix the smp_num_cpus thing [ ... ]
> 
> Yes!? How????
> 
I tried #define smp_num_cpus 1 in include/asm-alpha/smp.h (the non-smp
section) but the same line in include/asm/mmu_context.h works - for a
while.

ALPHA :diff -Br -b -U 3 -N mmu_context.org mmu_context.h
--- mmu_context.org     Fri Jun 21 16:16:56 2002
+++ mmu_context.h       Fri Jun 21 16:09:33 2002
@@ -89,6 +89,7 @@
 #define cpu_last_asn(cpuid)    (cpu_data[cpuid].last_asn)
 #else
 extern unsigned long last_asn;
+#define smp_num_cpus   1
 #define cpu_last_asn(cpuid)    last_asn
 #endif /* CONFIG_SMP */

But after that while:

make[1]: Entering directory `/usr/src/linux-2.5.24/mm'
  gcc -Wp,-MD,./.memory.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-po
inter -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_B
ASENAME=memory   -c -o memory.o memory.c
In file included from /usr/src/linux-2.5.24/include/asm/tlb.h:1,
                 from memory.c:50:
/usr/src/linux-2.5.24/include/asm-generic/tlb.h: In function `tlb_gather_mmu':
/usr/src/linux-2.5.24/include/asm-generic/tlb.h:57: warning: large integer implicitly truncated to unsigned type
/usr/src/linux-2.5.24/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
/usr/src/linux-2.5.24/include/asm-generic/tlb.h:69: warning: implicit declaration of function `tlb_flush'
memory.c: In function `free_one_pmd':
memory.c:93: warning: implicit declaration of function `pte_free_tlb'
memory.c: In function `free_one_pgd':
memory.c:114: warning: implicit declaration of function `pmd_free_tlb'
memory.c: In function `copy_page_range':
memory.c:267: warning: implicit declaration of function `pte_pfn'
memory.c:268: warning: implicit declaration of function `pfn_valid'
memory.c:270: warning: implicit declaration of function `pfn_to_page'
memory.c:270: warning: assignment makes pointer from integer without a cast
memory.c: In function `zap_pte_range':
memory.c:338: warning: implicit declaration of function `tlb_remove_tlb_entry'
memory.c:340: warning: initialization makes pointer from integer without a cast
memory.c: In function `unmap_page_range':
memory.c:386: warning: implicit declaration of function `tlb_start_vma'
memory.c:392: warning: implicit declaration of function `tlb_end_vma'
memory.c: In function `follow_page':
memory.c:458: warning: return makes pointer from integer without a cast
memory.c: In function `remap_pte_range':
memory.c:845: invalid type argument of `->'
memory.c:846: warning: implicit declaration of function `pfn_pte'
memory.c:846: incompatible types in assignment
memory.c: In function `do_wp_page':
memory.c:961: warning: assignment makes pointer from integer without a cast
make[1]: *** [memory.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.24/mm'
make: *** [mm] Error 2
alpha:/usr/src/linux-2.5.24#

Jurriaan
-- 
I believe in coincidence. Coincidences happen every day. But I don't
trust coincidences.
	Garak - DS9
Debian GNU/Linux 2.4.19p10 on Alpha 990 bogomips load:0.52 0.48 0.46
