Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSJKBK3>; Thu, 10 Oct 2002 21:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262245AbSJKBK3>; Thu, 10 Oct 2002 21:10:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10203 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262243AbSJKBK1>; Thu, 10 Oct 2002 21:10:27 -0400
Subject: [PATCH] linux-2.5.41_cyclone-fixes_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, greg kh <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Oct 2002 18:09:39 -0700
Message-Id: <1034298580.19094.53.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, 
	This patch just syncs up the cyclone-timer code w/ Greg's changes from
this morning. 

Please apply.

thanks
-john


diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Thu Oct 10 18:07:14 2002
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Thu Oct 10 18:07:14 2002
@@ -81,7 +81,7 @@
 	
 	/*make sure we're on a summit box*/
 	/*XXX need to use proper summit hooks! such as xapic -john*/
-	if(!use_cyclone) return 0; 
+	if(!use_cyclone) return -ENODEV; 
 	
 	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
 
@@ -92,12 +92,12 @@
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!reg){
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
-		return 0;
+		return -ENODEV;
 	}
 	base = *reg;	
 	if(!base){
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
-		return 0;
+		return -ENODEV;
 	}
 	
 	/* setup PMCC */
@@ -107,7 +107,7 @@
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!reg){
 		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
-		return 0;
+		return -ENODEV;
 	}
 	reg[0] = 0x00000001;
 
@@ -118,7 +118,7 @@
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!reg){
 		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
-		return 0;
+		return -ENODEV;
 	}
 	reg[0] = 0x00000001;
 
@@ -129,7 +129,7 @@
 	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!cyclone_timer){
 		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
-		return 0;
+		return -ENODEV;
 	}
 
 	/*quick test to make sure its ticking*/
@@ -140,12 +140,12 @@
 		if(cyclone_timer[0] == old){
 			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
 			cyclone_timer = 0;
-			return 0;
+			return -ENODEV;
 		}
 	}
 
 	/* Everything looks good! */
-	return 1;
+	return 0;
 }
 




