Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261843AbSI2XvA>; Sun, 29 Sep 2002 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261846AbSI2Xu7>; Sun, 29 Sep 2002 19:50:59 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:41858 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261843AbSI2Xuy>; Sun, 29 Sep 2002 19:50:54 -0400
Date: Mon, 30 Sep 2002 01:53:46 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq bugfixes
Message-ID: <20020930015345.A11848@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for merging cpufreq. Please apply these bugfixes, too.

- incorrect pointer calculation spotted by Gerald Britton
- speedstep.c cleanup (Gerald Britton)

	Dominik

diff -ruN linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Mon Sep 30 00:58:10 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	Mon Sep 30 01:43:06 2002
@@ -290,7 +290,7 @@
 	if (!driver)
 		return -ENOMEM;
 
-	driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
+	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
 	if (!max_freq)
 		max_freq = elanfreq_get_cpu_frequency();
diff -ruN linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/longhaul.c	Mon Sep 30 00:58:10 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	Mon Sep 30 01:43:06 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: longhaul.c,v 1.70 2002/09/12 10:22:17 db Exp $
+ *  $Id: longhaul.c,v 1.72 2002/09/29 23:43:10 db Exp $
  *
  *  (C) 2001  Dave Jones. <davej@suse.de>
  *  (C) 2002  Padraig Brady. <padraig@antefacto.com>
@@ -771,7 +771,7 @@
 	if (!driver)
 		return -ENOMEM;
 
-	driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
+	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
 #ifdef CONFIG_CPU_FREQ_24_API
 	driver->cpu_min_freq    = (unsigned int) lowest_speed;
diff -ruN linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/longrun.c	Mon Sep 30 00:58:10 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	Mon Sep 30 01:43:06 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: longrun.c,v 1.10 2002/09/22 09:01:41 db Exp $
+ *  $Id: longrun.c,v 1.12 2002/09/29 23:43:10 db Exp $
  *
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
  *
@@ -241,7 +241,7 @@
 	if (!driver)
 		return -ENOMEM;
 
-	driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
+	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
 	if (longrun_determine_freqs(&longrun_low_freq, &longrun_high_freq)) {
 		kfree(driver);
diff -ruN linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Mon Sep 30 00:58:10 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Mon Sep 30 01:43:06 2002
@@ -225,7 +225,7 @@
 	if (!driver)
 		return -ENOMEM;
 
-	driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
+	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
 	if (!stock_freq)
 		stock_freq = cpu_khz;
diff -ruN linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Mon Sep 30 00:58:10 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Mon Sep 30 01:43:06 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: powernow-k6.c,v 1.31 2002/09/21 09:05:29 db Exp $
+ *  $Id: powernow-k6.c,v 1.33 2002/09/29 23:43:11 db Exp $
  *  This file was part of Powertweak Linux (http://powertweak.sf.net)
  *  and is shared with the Linux Kernel module.
  *
@@ -239,7 +239,7 @@
 		release_region (POWERNOW_IOPORT, 16);
 		return -ENOMEM;
 	}
-	driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
+	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
 #ifdef CONFIG_CPU_FREQ_24_API
 	driver->cpu_min_freq     = busfreq * 20;
diff -ruN linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-2539cpufreq/arch/i386/kernel/cpu/cpufreq/speedstep.c	Mon Sep 30 01:04:47 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Mon Sep 30 01:43:06 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: speedstep.c,v 1.50 2002/09/22 08:16:25 db Exp $
+ *  $Id: speedstep.c,v 1.53 2002/09/29 23:43:11 db Exp $
  *
  * (C) 2001  Dave Jones, Arjan van de ven.
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
@@ -91,6 +91,7 @@
  */
 static int speedstep_get_state (unsigned int *state)
 {
+	unsigned long   flags;
 	u32             pmbase;
 	u8              value;
 
@@ -110,9 +111,9 @@
 			return -EIO;
 
 		/* read state */
-		local_irq_disable();
+		local_irq_save(flags);
 		value = inb(pmbase + 0x50);
-		local_irq_enable();
+		local_irq_restore(flags);
 
 		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
@@ -132,7 +133,7 @@
  *
  *   Tries to change the SpeedStep state. 
  */
-static void speedstep_set_state (unsigned int state)
+static void speedstep_set_state (unsigned int state, int notify)
 {
 	u32                     pmbase;
 	u8	                pm2_blk;
@@ -154,7 +155,8 @@
 	freqs.new = (state == SPEEDSTEP_HIGH) ? speedstep_high_freq : speedstep_low_freq;
 	freqs.cpu = CPUFREQ_ALL_CPUS; /* speedstep.c is UP only driver */
 	
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	if (notify)
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
@@ -173,10 +175,11 @@
 			return;
 		}
 
+		/* Disable IRQs */
+		local_irq_save(flags);
+
 		/* read state */
-		local_irq_disable();
 		value = inb(pmbase + 0x50);
-		local_irq_enable();
 
 		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
@@ -186,10 +189,6 @@
 
 		dprintk(KERN_DEBUG "cpufreq: writing 0x%x to pmbase 0x%x + 0x50\n", value, pmbase);
 
-		/* Disable IRQs */
-		local_irq_save(flags);
-		local_irq_disable();
-
 		/* Disable bus master arbitration */
 		pm2_blk = inb(pmbase + 0x20);
 		pm2_blk |= 0x01;
@@ -202,14 +201,11 @@
 		pm2_blk &= 0xfe;
 		outb(pm2_blk, (pmbase + 0x20));
 
-		/* Enable IRQs */
-		local_irq_enable();
-		local_irq_restore(flags);
-
 		/* check if transition was sucessful */
-		local_irq_disable();
 		value = inb(pmbase + 0x50);
-		local_irq_enable();
+
+		/* Enable IRQs */
+		local_irq_restore(flags);
 
 		dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
@@ -223,7 +219,8 @@
 		printk (KERN_ERR "cpufreq: setting CPU frequency on this chipset unsupported.\n");
 	}
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	if (notify)
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return;
 }
@@ -526,10 +523,13 @@
  */
 static int speedstep_detect_speeds (void)
 {
+	unsigned long   flags;
 	unsigned int    state;
-	unsigned int    low = 0, high = 0;
 	int             i, result;
-    
+
+	/* Disable irqs for entire detection process */
+	local_irq_save(flags);
+
 	for (i=0; i<2; i++) {
 		/* read the current state */
 		result = speedstep_get_state(&state);
@@ -541,31 +541,30 @@
 			switch (speedstep_processor) {
 			case SPEEDSTEP_PROCESSOR_PIII_C:
 			case SPEEDSTEP_PROCESSOR_PIII_T:
-				low = pentium3_get_frequency();
+				speedstep_low_freq = pentium3_get_frequency();
 				break;
 			case SPEEDSTEP_PROCESSOR_P4M:
-				low = pentium4_get_frequency();
+				speedstep_low_freq = pentium4_get_frequency();
 			}
-			speedstep_set_state(SPEEDSTEP_HIGH);
+			speedstep_set_state(SPEEDSTEP_HIGH, 0);
 		} else {
 			switch (speedstep_processor) {
 			case SPEEDSTEP_PROCESSOR_PIII_C:
 			case SPEEDSTEP_PROCESSOR_PIII_T:
-				high = pentium3_get_frequency();
+				speedstep_high_freq = pentium3_get_frequency();
 				break;
 			case SPEEDSTEP_PROCESSOR_P4M:
-				high = pentium4_get_frequency();
+				speedstep_high_freq = pentium4_get_frequency();
 			}
-			speedstep_set_state(SPEEDSTEP_LOW);
+			speedstep_set_state(SPEEDSTEP_LOW, 0);
 		}
-
-		if (!low || !high || 
-		    (speedstep_low_freq == speedstep_high_freq))
-			return -EIO;
 	}
 
-	speedstep_low_freq = low;
-	speedstep_high_freq = high;
+	local_irq_restore(flags);
+
+	if (!speedstep_low_freq || !speedstep_high_freq || 
+	    (speedstep_low_freq == speedstep_high_freq))
+		return -EIO;
 
 	return 0;
 }
@@ -583,16 +582,16 @@
 		return;
 
 	if (policy->min > speedstep_low_freq) 
-		speedstep_set_state(SPEEDSTEP_HIGH);
+		speedstep_set_state(SPEEDSTEP_HIGH, 1);
 	else {
 		if (policy->max < speedstep_high_freq)
-			speedstep_set_state(SPEEDSTEP_LOW);
+			speedstep_set_state(SPEEDSTEP_LOW, 1);
 		else {
 			/* both frequency states are allowed */
 			if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
-				speedstep_set_state(SPEEDSTEP_LOW);
+				speedstep_set_state(SPEEDSTEP_LOW, 1);
 			else
-				speedstep_set_state(SPEEDSTEP_HIGH);
+				speedstep_set_state(SPEEDSTEP_HIGH, 1);
 		}
 	}
 }
@@ -649,7 +648,7 @@
 		return -ENODEV;
 	}
 
-	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.50 $\n");
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.53 $\n");
 	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n", 
 	       speedstep_chipset, speedstep_processor);
 
@@ -659,8 +658,6 @@
 		return result;
 
 	/* detect low and high frequency */
-	speedstep_low_freq = 100000;
-	speedstep_high_freq = 200000;
 	result = speedstep_detect_speeds();
 	if (result)
 		return result;
@@ -682,8 +679,8 @@
 	if (!driver)
 		return -ENOMEM;
 
-	driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
-	
+	driver->policy = (struct cpufreq_policy *) (driver + 1);
+
 #ifdef CONFIG_CPU_FREQ_24_API
 	driver->cpu_min_freq    = speedstep_low_freq;
 	driver->cpu_cur_freq[0] = speed;
diff -ruN linux-2539cpufreq/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2539cpufreq/arch/i386/kernel/time.c	Mon Sep 30 00:58:09 2002
+++ linux/arch/i386/kernel/time.c	Mon Sep 30 01:08:11 2002
@@ -626,7 +626,7 @@
 		}
 		for (i=0; i<NR_CPUS; i++)
 			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(loops_per_jiffy, freq->old, freq->new);
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
 		break;
 
 	case CPUFREQ_POSTCHANGE:
@@ -637,7 +637,7 @@
 		}
 		for (i=0; i<NR_CPUS; i++)
 			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
-				cpu_data[i].loops_per_jiffy = cpufreq_scale(loops_per_jiffy, freq->old, freq->new);
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(cpu_data[i].loops_per_jiffy, freq->old, freq->new);
 		break;
 	}
 
