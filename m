Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbSIXEam>; Tue, 24 Sep 2002 00:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbSIXEam>; Tue, 24 Sep 2002 00:30:42 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:16097 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id <S261547AbSIXEal>;
	Tue, 24 Sep 2002 00:30:41 -0400
Subject: [RFC][PATCH] Compilation fix 2.4.20-pre7
From: Bongani <bonganilinux@mweb.co.za>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Ian Carr-de Avelon <avelon@emit.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 24 Sep 2002 06:38:26 +0200
Message-Id: <1032842310.2348.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo

Ian had some compilation error while trying to compile 2.4.20-pre7
this is the error that he got:

/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/linux/include/linux/kernel_stat.h:57: `smp_num_cpus' undeclared
(first use in this function)
/usr/src/linux/include/linux/kernel_stat.h:57: (Each undeclared
identifier is reported only once
/usr/src/linux/include/linux/kernel_stat.h:57: for each function it
appears in.)make[2]:
*** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2


He got this when he was compiling a UP kernel. When
he tries to compile for a SMP kernel the error goes away.
Which makes sense because smp_num_cpus is only defined fro SMP
kernels. Does the following patch look OK? This is adopted from 2.5.38.

Cheers


diff -uNr include/linux/kernel_stat.h~ include/linux/kernel_stat.h 
--- include/linux/kernel_stat.h~        2002-09-23 16:16:45.000000000
+0200
+++ include/linux/kernel_stat.h 2002-09-23 16:42:42.000000000 +0200
@@ -54,7 +54,7 @@
 {
        int i, sum=0;
 
-       for (i = 0 ; i < smp_num_cpus ; i++)
+       for (i = 0 ; i < NR_CPUS ; i++)
                sum += kstat.irqs[cpu_logical_map(i)][irq];
 
        return sum


