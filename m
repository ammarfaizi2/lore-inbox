Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSFLRqA>; Wed, 12 Jun 2002 13:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSFLRp7>; Wed, 12 Jun 2002 13:45:59 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:52438 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S317751AbSFLRp6>; Wed, 12 Jun 2002 13:45:58 -0400
Date: Wed, 12 Jun 2002 12:18:39 -0700 (PDT)
From: Lance Larsh <llarsh@oracle.com>
X-X-Sender: <llarsh@llarsh-pc3.us.oracle.com>
To: <linux-kernel@vger.kernel.org>
cc: <marcelo@conectiva.com.br>
Subject: [PATCH] arch/i386/kernel/bluesmoke.c, kernel 2.4.18
Message-ID: <Pine.LNX.4.33.0206121202150.22214-100000@llarsh-pc3.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the i386 machine check exception handler, MSR_IA32_MCi_ADDR is not
output correctly.  Instead, MSR_IA32_MCi_STATUS is output a second time in
its place.

-Lance


--- 2.4.18/arch/i386/kernel/bluesmoke.c	Mon Nov 12 09:59:43 2001
+++ 2.4.18-fix/arch/i386/kernel/bluesmoke.c	Wed Jun 12 10:30:12 2002
@@ -47,7 +47,7 @@
 			{
 				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
 				printk(" at %08x%08x", 
-					high, low);
+					ahigh, alow);
 			}
 			printk("\n");
 			/* Clear it */

