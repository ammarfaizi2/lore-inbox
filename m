Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSK1JF1>; Thu, 28 Nov 2002 04:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSK1JF1>; Thu, 28 Nov 2002 04:05:27 -0500
Received: from cpe.atm0-0-0-209183.0x3ef29767.boanxx7.customer.tele.dk ([62.242.151.103]:38992
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S265321AbSK1JFY>; Thu, 28 Nov 2002 04:05:24 -0500
Date: Thu, 28 Nov 2002 10:12:43 +0100
From: Henrik =?iso-8859-1?Q?St=F8rner?= <henrik@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 compile failure: drivers/pci/quirks.c missing #include
Message-ID: <20021128091243.GA26352@hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wp,-MD,drivers/pci/.quirks.o.d -D__KERNEL__ -Iinclude -Wall
  -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
  -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
  -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
  -DKBUILD_BASENAME=quirks -DKBUILD_MODNAME=quirks   -c -o
  drivers/pci/quirks.o drivers/pci/quirks.c
drivers/pci/quirks.c: In function `quirk_ioapic_rmw':
drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this
  function)

osiris:~/kernel/linux-2.5 $ grep sis_apic_bug include/asm-i386/*
include/asm-i386/io_apic.h:extern int sis_apic_bug;
include/asm-i386/io_apic.h:     if (sis_apic_bug)

This fixes it:


--- linux-2.5/drivers/pci//quirks.c.orig	2002-11-28 10:07:21.000000000 +0100
+++ linux-2.5/drivers/pci/quirks.c	2002-11-28 10:07:57.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <asm/io_apic.h>
 
 #undef DEBUG
 

-- 
Henrik Storner <henrik@hswn.dk> 
