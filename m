Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132887AbRDPIXy>; Mon, 16 Apr 2001 04:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132880AbRDPIWb>; Mon, 16 Apr 2001 04:22:31 -0400
Received: from 13dyn131.delft.casema.net ([212.64.76.131]:35342 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132883AbRDPIU5>; Mon, 16 Apr 2001 04:20:57 -0400
Message-Id: <200104160820.KAA04117@cave.bitwizard.nl>
Subject: [PATCH] Aligning the CPU capabilities flags. 
To: hpa@transmeta.com, Linus Torvalds <Torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Mon, 16 Apr 2001 10:20:52 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Human eyes are wonderful things. They do pattern matching given
the right input. Compare:

CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000

with:

CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000

In the second case it's immediately obivous nothing changed during
these steps.

Patch below. 

			Roger. 


diff -ur linux-2.4.3.clean/arch/i386/kernel/setup.c linux-2.4.3.cpuflagsfix/arch/i386/kernel/setup.c
--- linux-2.4.3.clean/arch/i386/kernel/setup.c	Mon Apr  2 10:02:33 2001
+++ linux-2.4.3.cpuflagsfix/arch/i386/kernel/setup.c	Mon Apr 16 10:14:59 2001
@@ -2064,7 +2064,7 @@
 
 	/* Now the feature flags better reflect actual CPU features! */
 
-	printk(KERN_DEBUG "CPU: After generic, caps: %08x %08x %08x %08x\n",
+	printk(KERN_DEBUG "CPU:     After generic, caps: %08x %08x %08x %08x\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
 	       c->x86_capability[2],
@@ -2082,7 +2082,7 @@
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
 	}
 
-	printk(KERN_DEBUG "CPU: Common caps: %08x %08x %08x %08x\n",
+	printk(KERN_DEBUG "CPU:             Common caps: %08x %08x %08x %08x\n",
 	       boot_cpu_data.x86_capability[0],
 	       boot_cpu_data.x86_capability[1],
 	       boot_cpu_data.x86_capability[2],



-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
