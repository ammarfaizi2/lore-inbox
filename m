Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312972AbSDLG0Y>; Fri, 12 Apr 2002 02:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313403AbSDLG0X>; Fri, 12 Apr 2002 02:26:23 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:33209 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312972AbSDLG0X>; Fri, 12 Apr 2002 02:26:23 -0400
Date: Fri, 12 Apr 2002 08:11:03 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Oops in 2.4.18 - opl3sa2 related? (typo fix)
In-Reply-To: <Pine.LNX.4.44.0204101242520.9710-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0204120810280.13542-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slight typo...

--- linux-2.4.19/drivers/sound/opl3sa2.c.orig	Tue Apr  9 13:17:21 2002
+++ linux-2.4.19/drivers/sound/opl3sa2.c	Tue Apr  9 13:19:38 2002
@@ -641,7 +641,7 @@
 	if(!request_region(hw_config->io_base, 2, OPL3SA2_MODULE_NAME)) {
 		printk(KERN_ERR PFX "Control I/O port %#x not free\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_nodev;
 	}
 
 	/*
@@ -654,7 +654,7 @@
 	if(tmp != misc) {
 		printk(KERN_ERR PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_region;
 	}
 
 	/*
@@ -667,7 +667,7 @@
 		printk(KERN_ERR
 		       PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_region;
 	}
 	opl3sa2_write(hw_config->io_base, OPL3SA2_MIC, tmp);
 
@@ -714,9 +714,13 @@
 	if(opl3sa2_state[card].chipset != CHIPSET_UNKNOWN) {
 		/* Generate a pretty name */
 		opl3sa2_state[card].chipset_name = (char *)CHIPSET_TABLE[opl3sa2_state[card].chipset];
-		return 1;
+		return 0;
 	}
-	return 0;
+
+out_region:
+	release_region(hw_config->io_base, 2);
+out_nodev:
+	return -ENODEV;
 }
 
 
@@ -1061,7 +1065,7 @@
 			opl3sa2_clear_slots(&opl3sa2_state[card].cfg_mpu);
 		}
 
-		if(!probe_opl3sa2(&opl3sa2_state[card].cfg, card) ||
+		if(probe_opl3sa2(&opl3sa2_state[card].cfg, card) ||
 		   !probe_opl3sa2_mss(&opl3sa2_state[card].cfg_mss)) {
 			/*
 			 * If one or more cards are already registered, don't

-- 
http://function.linuxpower.ca
		

