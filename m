Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130306AbRAWNVL>; Tue, 23 Jan 2001 08:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbRAWNUv>; Tue, 23 Jan 2001 08:20:51 -0500
Received: from rs1.Theo-Phys.Uni-Essen.DE ([132.252.73.3]:46995 "EHLO
	rs1.Theo-Phys.Uni-Essen.DE") by vger.kernel.org with ESMTP
	id <S130306AbRAWNUp>; Tue, 23 Jan 2001 08:20:45 -0500
Date: Tue, 23 Jan 2001 14:18:28 +0100 (MET)
Message-Id: <200101231318.OAA70117@indy3.Theo-Phys.Uni-Essen.DE>
From: Martin Schimschak <masch@indy3.Theo-Phys.Uni-Essen.DE>
To: linux-kernel@vger.kernel.org
Subject: [2.4.1-pre10] conflicting declarations of sys_wait4()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.1-pre10 is not compiling (at least) on alpha due to conflicting
declarations of sys_wait4() at various locations, e.g.

include/asm/unistd.h:575:

	extern long sys_wait4(int, int *, int, struct rusage *);

include/linux/sched.h:566:

	asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr,
	                          int options, struct rusage * ru);

As far as I can say, the first declaration seems to be correct
(confirmation wanted). If so, at least the following files need to be
fixed: 

	kernel/exit.c				
	include/linux/sched.h			
	arch/sparc/kernel/signal.c		
	arch/sparc/kernel/sys_sunos.c		
	arch/mips/kernel/signal.c		
	arch/mips/kernel/irixsig.c		
	arch/ppc/kernel/signal.c		
	arch/m68k/kernel/signal.c		
	arch/sparc64/kernel/signal32.c	
	arch/sparc64/kernel/sys_sparc32.c	
	arch/sparc64/kernel/signal.c		
	arch/sparc64/solaris/signal.c		
	arch/sparc64/solaris/signal.c		
	arch/sparc64/solaris/signal.c		
	arch/sparc64/solaris/signal.c		
	arch/arm/kernel/signal.c		
	arch/sh/kernel/signal.c		
	arch/ia64/ia32/sys_ia32.c		
	arch/mips64/kernel/linux32.c		
	arch/mips64/kernel/signal.c		
	arch/mips64/kernel/signal32.c		
	arch/s390/kernel/signal.c		

Martin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
