Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbSKUAas>; Wed, 20 Nov 2002 19:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbSKUAar>; Wed, 20 Nov 2002 19:30:47 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:55044 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S266224AbSKUA3x>;
	Wed, 20 Nov 2002 19:29:53 -0500
Date: Wed, 20 Nov 2002 18:29:18 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
Subject: compile error in 2.5.48
Message-ID: <Pine.LNX.4.44.0211201821230.8146-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following compile error:

[tmolina@lap linux-2.5-tm]$ make bzImage > makeimage
arch/i386/kernel/apm.c:336:1: warning: "savesegment" redefined
In file included from include/linux/elf.h:5,
                 from include/linux/module.h:17,
                 from arch/i386/kernel/apm.c:205:
include/asm/elf.h:63:1: warning: this is the location of the previous definition

in apm.c it is:

#define savesegment(seg, where) \
                __asm__ __volatile__("movl %%" #seg ",%0" : "=m" (where))
 

in elf.h 

#define savesegment(seg,value) \
        asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))


Is there any reason we can't just do the following:
--- arch/i386/kernel/apm.c.orig	2002-11-20 18:13:04.000000000 -0600
+++ arch/i386/kernel/apm.c	2002-11-20 18:16:16.000000000 -0600
@@ -331,12 +331,6 @@
 #define DEFAULT_BOUNCE_INTERVAL		(3 * HZ)
 
 /*
- * Save a segment register away
- */
-#define savesegment(seg, where) \
-		__asm__ __volatile__("movl %%" #seg ",%0" : "=m" (where))
-
-/*
  * Maximum number of events stored
  */
 #define APM_MAX_EVENTS		20


