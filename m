Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbTCLRTy>; Wed, 12 Mar 2003 12:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbTCLRTy>; Wed, 12 Mar 2003 12:19:54 -0500
Received: from hydra.colinet.de ([194.231.113.36]:27145 "EHLO hydra.colinet.de")
	by vger.kernel.org with ESMTP id <S261792AbTCLRTv>;
	Wed, 12 Mar 2003 12:19:51 -0500
Subject: 2.5.64-bk7 alpha-smp build problems + patch
To: linux-kernel@vger.kernel.org
Cc: kirk@colinet.de
Message-Id: <kirk-1030312175546.A0F310@hydra.colinet.de>
X-Mailer: TkMail 4.0beta9
From: "T. Weyergraf" <kirk@colinet.de>
Date: Wed, 12 Mar 2003 17:55:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i have been trying to build 2.5.64 + bk7-patchset on my alpha
( dual EV67, DP264 ), which failed, giving this message:

[....]
  gcc -Wp,-MD,arch/alpha/kernel/.smp.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix include  -Werror -Wno-sign-compare  -DKBUILD_BASENAME=smp -DKBUILD_MODNAME=smp -c -o arch/alpha/kernel/smp.o arch/alpha/kernel/smp.c
cc1: warnings being treated as errors
arch/alpha/kernel/smp.c: In function `wait_boot_cpu_to_stop':
arch/alpha/kernel/smp.c:117: warning: comparison of distinct pointer types lacks a cast
arch/alpha/kernel/smp.c: In function `secondary_cpu_start':
arch/alpha/kernel/smp.c:401: warning: comparison of distinct pointer types lacks a cast
arch/alpha/kernel/smp.c: In function `smp_boot_one_cpu':
arch/alpha/kernel/smp.c:463: warning: comparison of distinct pointer types lacks a cast
arch/alpha/kernel/smp.c: In function `smp_call_function_on_cpu':
arch/alpha/kernel/smp.c:842: warning: comparison of distinct pointer types lacks a cast
arch/alpha/kernel/smp.c:855: warning: comparison of distinct pointer types lacks a cast
make[1]: *** [arch/alpha/kernel/smp.o] Error 1
make: *** [arch/alpha/kernel] Error 2

For me, the following patch provides a successful build:

--- linux-2.5.64bk7/arch/alpha/kernel/smp.c     Wed Mar  5 04:29:04 2003
+++ linux-2.5.64bk7-kirk/arch/alpha/kernel/smp.c        Wed Mar 12 17:29:08 2003
@@ -114,3 +114,3 @@ wait_boot_cpu_to_stop(int cpuid)
 {
-       long stop = jiffies + 10*HZ;
+       unsigned long stop = jiffies + 10*HZ;
 
@@ -351,3 +351,3 @@ secondary_cpu_start(int cpuid, struct ta
        struct pcb_struct *hwpcb, *ipcb;
-       long timeout;
+       unsigned long timeout;
          
@@ -430,3 +430,3 @@ smp_boot_one_cpu(int cpuid)
        struct task_struct *idle;
-       long timeout;
+       unsigned long timeout;
 
@@ -818,3 +818,3 @@ smp_call_function_on_cpu (void (*func) (
        struct smp_call_struct data;
-       long timeout;
+       unsigned long timeout;
        int num_cpus_to_call;

Can anybody more knowledgeable confirm/deny the above ?

Regards,
Thomas Weyergraf


-- 
Thomas Weyergraf                                                kirk@colinet.de
My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


