Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUFCRDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUFCRDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUFCRDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:03:22 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:473 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S265665AbUFCRB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:01:59 -0400
Date: Thu, 3 Jun 2004 19:01:47 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Stock IA64 kernel on SGI Altix 350
Message-ID: <20040603170147.GK10708@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

I have a SGI Altix 350 IA64 machine (running SLES 8) for testing before
it goes to the production use. I have succeeded recompiling and booting
the SuSE distribution kernel (2.4.21+patches) from sources, but I have
failed to compile/run any stock kernel from ftp.kernel.org (+ patches from
kernel/ports/ia64/v2.[46]).

	Firstly, is there any Linux IA64-specific mailing list?
The MAINTAINERS file points to www.linuxia64.org, which is probably
expired (please update the MAINTAINERS file).

	Now the detailed description:

---------------------
The 2.6.6 kernel + linux-2.6.6-ia64-040521.diff.bz2 patch compiled and
linked correctly, but failed to boot (it did not print anything to the
console):

ELILO boot: 2.6.6 console=ttyS0
Uncompressing Linux... done
                                                                                
(and without "console=ttyS0" it was the same).

---------------------
The 2.4.26 kernel + linux-2.4.26-ia64-040510.diff.bz2 patch failed to link
on my box with <asm/sn/idle.h> missing:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.26/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -g -fomit-frame-pointer -pipe  -ffixed-r13 -mfixed-range=f12-f15,f32-f127 -falign-functions=32 -DGAS_HAS_HINT_INSN -frename-registers --param max-inline-insns=5000 -DBRINGUP -mconstant-gp  -nostdinc -iwithprefix include -DKBUILD_BASENAME=process  -c -o process.o process.c
process.c:33:25: asm/sn/idle.h: No such file or directory
process.c: In function `cpu_idle':
process.c:167: warning: implicit declaration of function `snidle'
process.c:173: warning: implicit declaration of function `snidleoff'
process.c: In function `arch_kernel_thread':
/usr/src/linux-2.4.26/include/asm/unistd.h:313: warning: `dummy3' might be used uninitialized in this function
/usr/src/linux-2.4.26/include/asm/unistd.h:313: warning: `dummy4' might be used uninitialized in this function
/usr/src/linux-2.4.26/include/asm/unistd.h:313: warning: `dummy5' might be used uninitialized in this function
/usr/src/linux-2.4.26/include/asm/unistd.h:316: warning: `dummy3' might be used uninitialized in this function
/usr/src/linux-2.4.26/include/asm/unistd.h:316: warning: `dummy4' might be used uninitialized in this function
/usr/src/linux-2.4.26/include/asm/unistd.h:316: warning: `dummy5' might be used uninitialized in this function
make[1]: *** [process.o] Error 1

after "touch include/asm/sn/idle.h" it failed to compile sn2_smp.c:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.26/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -g -fomit-frame-pointer -pipe  -ffixed-r13 -mfixed-range=f12-f15,f32-f127 -falign-functions=32 -DGAS_HAS_HINT_INSN -frename-registers --param max-inline-insns=5000 -DBRINGUP -mconstant-gp -DLITTLE_ENDIAN -nostdinc -iwithprefix include -DKBUILD_BASENAME=sn2_smp  -c -o sn2_smp.o sn2_smp.c
sn2_smp.c: In function `sn2_global_tlb_purge':
sn2_smp.c:116: `node_has_active_cpus' undeclared (first use in this function)
sn2_smp.c:116: (Each undeclared identifier is reported only once
sn2_smp.c:116: for each function it appears in.)
sn2_smp.c:120: structure has no member named `shared_mm'
sn2_smp.c:120: structure has no member named `node_history'
sn2_smp.c: In function `sn2_ptc_deadlock_recovery':
sn2_smp.c:164: `node_has_active_cpus' undeclared (first use in this function)
make[3]: *** [sn2_smp.o] Error 1

include/asm-ia64/sn/nodepda.h is the only containng the "node_has_active_cpus".
---------------------

	My .configs are at http://www.fi.muni.cz/~kas/tmp/ia64/.
So is it possible to use stock kernel on Altix 350? Is there a better
list to report this than lkml?

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
++> I consider none of the code I contributed to glibc (which is quite a <++
++> lot) to be as part of the GNU project.             -- Ulrich Drepper <++
