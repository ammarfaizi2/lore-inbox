Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271204AbTHCQAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 12:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271207AbTHCQAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 12:00:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30937 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S271204AbTHCQAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 12:00:02 -0400
Date: Sun, 3 Aug 2003 17:59:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Marcelo Abreu <skewer@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3
In-Reply-To: <3F2D2686.308@terra.com.br>
Message-ID: <Pine.LNX.4.44.0308031758410.27587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Aug 2003, Marcelo Abreu wrote:

> 	The 4G patch has changed the 'ldt' member of mm_context_t, calling
> it 'ldt_pages'. Patch from Raphael fixes fpu_system.h for correct
> compilation, but system won't boot with 'no387' parameter. So semantics
> must have been changed too.

i sent the correct patch to Andrew already:

--- linux/arch/i386/math-emu/fpu_system.h.orig	
+++ linux/arch/i386/math-emu/fpu_system.h	
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <asm/atomic_kmap.h>
 
 /* This sets the pointer FPU_info to point to the argument part
    of the stack frame of math_emulate() */
@@ -22,7 +23,7 @@
 
 /* s is always from a cpu register, and the cpu does bounds checking
  * during register load --> no further bounds checks needed */
-#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)current->mm->context.ldt)[(s) >> 3])
+#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)__kmap_atomic_vaddr(KM_LDT_PAGE0))[(s) >> 3])
 #define SEG_D_SIZE(x)		((x).b & (3 << 21))
 #define SEG_G_BIT(x)		((x).b & (1 << 23))
 #define SEG_GRANULARITY(x)	(((x).b & (1 << 23)) ? 4096 : 1)


