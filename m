Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSITIOg>; Fri, 20 Sep 2002 04:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbSITIOg>; Fri, 20 Sep 2002 04:14:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54999 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261619AbSITIOf>; Fri, 20 Sep 2002 04:14:35 -0400
Date: Fri, 20 Sep 2002 10:19:31 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: Dominik Brodowski <linux@brodo.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre7-ac3
In-Reply-To: <200209191728.g8JHSBg22827@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0209201012540.23207-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Alan Cox wrote:

>...
> Linux 2.4.20-pre7-ac3
>...
> o       Interrupt.h needs asm/system for smb_mb         (Dominik Brodowski)
>...


The following part of his patches is also needed in order to compile
cpufreq.c:



--- include/asm-i386/hw_irq.h.old	2002-09-20 09:25:37.000000000 +0200
+++ include/asm-i386/hw_irq.h	2002-09-19 19:52:25.000000000 +0200
@@ -13,8 +13,10 @@
  */

 #include <linux/config.h>
+#include <linux/smp_lock.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
+#include <asm/current.h>

 /*
  * IDT vectors usable for external interrupt sources start




With this patch applied I got a compile error in ieee1394_core.c because
asm-i386/smplock.h was included twice. It seems the following is needed,
too:



--- include/asm-i386/smplock.h.old	2002-09-19 20:53:57.000000000 +0200
+++ include/asm-i386/smplock.h	2002-09-19 20:54:46.000000000 +0200
@@ -1,3 +1,6 @@
+#ifndef __ASM_SMPLOCK_H
+#define __ASM_SMPLOCK_H
+
 /*
  * <asm/smplock.h>
  *
@@ -74,3 +77,5 @@
 		 "=m" (current->lock_depth));
 #endif
 }
+
+#endif /* __ASM_SMPLOCK_H */


cu
Adrian


