Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131912AbRBNLeM>; Wed, 14 Feb 2001 06:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRBNLeC>; Wed, 14 Feb 2001 06:34:02 -0500
Received: from dire.bris.ac.uk ([137.222.10.60]:50932 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S131957AbRBNLdw>;
	Wed, 14 Feb 2001 06:33:52 -0500
From: "ASN Stevens, Computing Service" <Alastair.Stevens@bristol.ac.uk>
Date: Wed, 14 Feb 2001 11:32:38 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac12 compile failure on sparc64
Message-ID: <EXECMAIL.1010214113238.Y@velifer.bris.ac.uk>
X-Mailer: Execmail for Win32 Version 5.0.1 Build (55)
MIME-Version: 1.0
Content-Type: Text/Plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi - I am having compilation troubles on my sparc64 workstation (standard 
Ultra 5 machine), which is currently running stock 2.4.1 on Red Hat 6.2 quite 
happily.

I have tried upgrading to -ac10 and now -ac12, but both fail during 
compilation (using gcc-2.91.66-sparc) at the same point, in what appears to 
be the sparc32 syscall conversion code:

----------------------------------------------------------
sparc64-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include 
-m64 -mcpu=ultrasparc -Wa,--undeclared-regs -ansi -c sys32.S -o sys32.o

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux/include 
-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -m64 
-pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 
-fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs
-c -o sys_sparc32.o sys_sparc32.c

sys_sparc32.c: In function `sys32_quotactl':
sys_sparc32.c:907: storage size of `d' isn't known
sys_sparc32.c:907: warning: unused variable `d'
sys_sparc32.c: In function `sys32_nfsservctl':
sys_sparc32.c:3791: warning: implicit declaration of function `sys_ni_syscall'

make[1]: *** [sys_sparc32.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/sparc64/kernel'
make: *** [_dir_arch/sparc64/kernel] Error 2
----------------------------------------------------------

I have tried it 3 times now, with clean source trees, so there's clearly a 
problem somewhere. Please be gentle - I'm not a coder, and this is my first 
post to the kernel list :)

Regards
Alastair

___________________________________________________________
Alastair Stevens
Network Support Officer, Information Services
Room 1.26, Computer Centre
University of Bristol
...........................................................
Internal 7850    Direct 0117 928 7850    www.cse.bris.ac.uk

