Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSJEPuG>; Sat, 5 Oct 2002 11:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSJEPuG>; Sat, 5 Oct 2002 11:50:06 -0400
Received: from host194.steeleye.com ([66.206.164.34]:20234 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262385AbSJEPuF>; Sat, 5 Oct 2002 11:50:05 -0400
Message-Id: <200210051555.g95FtZA10167@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Josh McKinney <forming@charter.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40-ac3 compile error
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_15384386080"
Date: Sat, 05 Oct 2002 11:55:35 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_15384386080
Content-Type: text/plain; charset=us-ascii

> make[2]: *** [timer_pit.o] Error 1 make[2]: Leaving directory `/usr/
> src/linux-2.5/linux-2.5.40/arch/i386/kernel' 

This is caused by timer_pit.c not having quite the right #includes for the 
i386 subarch code.

The attached patch should fix it. (smp.h gets the smp_local_timer_interrupt, 
mpspec.h gets using_apic_timer and arch_hooks is the primer for the hooks in 
do_timer.h).

James


--==_Exmh_15384386080
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

--- arch/i386/kernel/timer_pit.c~	Sat Oct  5 11:22:01 2002
+++ arch/i386/kernel/timer_pit.c	Sat Oct  5 11:48:05 2002
@@ -7,7 +7,10 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <asm/timer.h>
+#include <asm/smp.h>
+#include <asm/mpspec.h>
 #include <asm/io.h>
+#include <asm/arch_hooks.h>
 
 /* fwd declarations */
 int init_pit(void);

--==_Exmh_15384386080--


