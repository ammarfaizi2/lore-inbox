Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264174AbRFFVmS>; Wed, 6 Jun 2001 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264179AbRFFVmI>; Wed, 6 Jun 2001 17:42:08 -0400
Received: from gateway.penguincomputing.com ([63.143.102.194]:33518 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id <S264174AbRFFVl7>; Wed, 6 Jun 2001 17:41:59 -0400
Message-ID: <3B1EA3A3.7A2C4144@penguincomputing.com>
Date: Wed, 06 Jun 2001 14:41:55 -0700
From: Philip Pokorny <ppokorny@penguincomputing.com>
Organization: Penguin Computing
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@redhat.com, torvalds@transmeta.com
Subject: [PATCH] timer vector printed inconsistently
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to debug a recent problem with some interrupt routing,
I found the output to be confusing...  The TIMER vector is
printed with %d, but when the APIC tables are printed, the vector
is printed using %02X.  This was particularly confusing in this case
because the TIMER vector was 49d (0x31) and vector 0x49 was
assigned to a different APIC pin.

The following patch causes the TIMER vector to be printed the same
way as the vectors in the APIC table (See line 786 of my io_apic.c)

I'm not a subscriber of the kernel mailing list, so please CC my on
any replies.

--- arch/i386/kernel/io_apic.c.orig	Tue Jun  5 17:30:12 2001
+++ arch/i386/kernel/io_apic.c	Tue Jun  5 17:34:38 2001
@@ -1489,7 +1489,7 @@
 	pin1 = find_isa_irq_pin(0, mp_INT);
 	pin2 = find_isa_irq_pin(0, mp_ExtINT);
 
-	printk(KERN_INFO "..TIMER: vector=%d pin1=%d pin2=%d\n", vector, pin1, pin2);
+	printk(KERN_INFO "..TIMER: vector=%02X pin1=%d pin2=%d\n", vector, pin1, pin2);
 
 	if (pin1 != -1) {
 		/*

-- 
Philip Pokorny, Senior Engineer
http://www.penguincomputing.com

Penguin Computing - The World's Most Reliable Linux Systems
