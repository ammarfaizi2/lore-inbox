Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318259AbSHZTEi>; Mon, 26 Aug 2002 15:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHZTDl>; Mon, 26 Aug 2002 15:03:41 -0400
Received: from signup.localnet.com ([207.251.201.46]:41454 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S318210AbSHZTCq>;
	Mon, 26 Aug 2002 15:02:46 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre4-ac1 patch error and compile error
References: <m3ptw6jky2.fsf@lugabout.jhcloos.org>
	<20020826100844.B900@flint.arm.linux.org.uk>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20020826100844.B900@flint.arm.linux.org.uk>
Date: 26 Aug 2002 15:06:41 -0400
Message-ID: <m34rdhzbge.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:

>> arch/i386/kernel/time.c failed to compile.  Based on the error, the
>> required patch is:

Russell> You still want time.o to be listed in obj-y for it to be
Russell> built.

Yup.  So I discovered after posting.  [SIGH]

I should have looked at other Makefiles to confirm how the building
process works these days....

So the proper patch would presumably be:


--- linux-2.4.20-pre4-ac1/arch/i386/kernel/Makefile     Sun Aug 25 19:17:57 2002
+++ linux-2.4.20-pre4-ac1+/arch/i386/kernel/Makefile     Mon Aug 26 00:34:43 2002
@@ -14,10 +14,10 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
 
 obj-y  := process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
-               ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
+               ptrace.o i8259.o ioport.o ldt.o setup.o sys_i386.o \
                pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o

--- linux-2.4.20-pre4-ac1/arch/i386/kernel/Makefile     Sun Aug 25 19:17:57 2002
+++ linux-2.4.20-pre4-ac1+/arch/i386/kernel/Makefile     Mon Aug 26 00:34:43 2002
@@ -14,10 +14,10 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
 
 obj-y  := process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
                ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
                pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o


