Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284090AbRLRPsP>; Tue, 18 Dec 2001 10:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284124AbRLRPsF>; Tue, 18 Dec 2001 10:48:05 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:16900 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S284090AbRLRPrw>; Tue, 18 Dec 2001 10:47:52 -0500
Message-Id: <4.3.2.7.2.20011218103901.00c3aad0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 18 Dec 2001 10:47:48 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: 2.5.1 - error compiling ksyms.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I can't 2.5.1 for a single processor environment.  The compilation of 
kernel/ksyms.c fails as follows:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.1/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c ksyms.c
In file included from ksyms.c:24:
/usr/src/linux-2.5.1/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/linux-2.5.1/include/linux/kernel_stat.h:48: `smp_num_cpus' 
undeclared (first use in this function)
/usr/src/linux-2.5.1/include/linux/kernel_stat.h:48: (Each undeclared 
identifier is reported only once
/usr/src/linux-2.5.1/include/linux/kernel_stat.h:48: for each function it 
appears in.)
make[2]: *** [ksyms.o] Error 1

In linux-2.5.1/.config, I have:

	# CONFIG_SMP is not set

This causes linux-2.5.1/include/linux/smp.h to define the symbol using:

	#define smp_num_cpus	1

However in linux-2.5.1/include/linux/modules/i386_ksyms.ver is:

	#define smp_num_cpus	_set_ver(smp_num_cpus)

which seems to undefine the symbol.

What the heck is going on here?

David

