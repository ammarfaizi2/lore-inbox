Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVHODHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVHODHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 23:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVHODHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 23:07:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61402 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932356AbVHODHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 23:07:07 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][2.6.12.3] Use vectors 0x21-0x2F
Date: Sun, 14 Aug 2005 20:07:02 -0700
User-Agent: KMail/1.7.1
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Russ Weight <rweight@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200507260012.41968.jamesclv@us.ibm.com> <20050804092221.GL8266@wotan.suse.de> <200508141957.53396.jamesclv@us.ibm.com>
In-Reply-To: <200508141957.53396.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508142007.03083.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick and dirty patch to use the 16 vectors that appear to have
fallen through the cracks.  This also is useful for older CPUs that
have serial APICS:  P54C, P6, P2, P3, K5, K6, etc.  They can benefit
from the extra vector space to hash the IRQs.

I suppose I could have started at 0x20 instead of 0x21.  The extra
level probably would more than compensate for having to skip 0x80 on
the initial allocations.

Signed-off-by:  James Cleverdon <jamesclv@us.ibm.com>


diff -pru 2.6.12.3/include/asm-i386/mach-default/irq_vectors.h z12.3/include/asm-i386/mach-default/irq_vectors.h
--- 2.6.12.3/include/asm-i386/mach-default/irq_vectors.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-i386/mach-default/irq_vectors.h	2005-08-14 15:35:46.000000000 -0700
@@ -31,10 +31,6 @@
 #define SYSCALL_VECTOR		0x80
 
 /*
- * Vectors 0x20-0x2f are used for ISA interrupts.
- */
-
-/*
  * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
  *
  *  some of the following vectors are 'rare', they are merged
@@ -58,11 +54,11 @@
 #define LOCAL_TIMER_VECTOR	0xef
 
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
- * we start at 0x31 to spread out vectors evenly between priority
+ * First APIC vector available to drivers: (vectors 0x20-0xee)
+ * we start at 0x21 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
-#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_DEVICE_VECTOR	0x21
 #define FIRST_SYSTEM_VECTOR	0xef
 
 #define TIMER_IRQ 0
diff -pru 2.6.12.3/include/asm-x86_64/hw_irq.h z12.3/include/asm-x86_64/hw_irq.h
--- 2.6.12.3/include/asm-x86_64/hw_irq.h	2005-07-15 14:18:57.000000000 -0700
+++ z12.3/include/asm-x86_64/hw_irq.h	2005-08-14 15:37:30.000000000 -0700
@@ -36,10 +36,6 @@ struct hw_interrupt_type;
 
 
 /*
- * Vectors 0x20-0x2f are used for ISA interrupts.
- */
-
-/*
  * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
  *
  *  some of the following vectors are 'rare', they are merged
@@ -67,11 +63,11 @@ struct hw_interrupt_type;
 #define LOCAL_TIMER_VECTOR	0xef
 
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
- * we start at 0x31 to spread out vectors evenly between priority
+ * First APIC vector available to drivers: (vectors 0x20-0xee)
+ * we start at 0x21 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
-#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_DEVICE_VECTOR	0x21
 #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
 
 


-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
