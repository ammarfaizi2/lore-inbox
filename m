Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTFQU5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTFQU5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:57:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:469 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264961AbTFQU45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:56:57 -0400
Date: Tue, 17 Jun 2003 23:10:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] net/wireless: make two frequency_list static
Message-ID: <20030617211044.GF29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5 kernels up to 2.5.72 fail to compile with the following error:

<--  snip  -->

...
  LD      
drivers/net/wireless/built-in.o
drivers/net/wireless/atmel.o(.rodata+0x1a0): 
multiple definition of `frequency_list'
drivers/net/wireless/airo.o(.rodata+0x0): first defined here
make[3]: *** [drivers/net/wireless/built-in.o] Error 1

<--  snip  -->


the patch below makes both frequency_list static.

I've tested the compilation with 2.5.72.

cu
Adrian


--- linux-2.5.70-mm6/drivers/net/wireless/airo.c.old	2003-06-08 17:24:35.000000000 +0200
+++ linux-2.5.70-mm6/drivers/net/wireless/airo.c	2003-06-08 17:24:56.000000000 +0200
@@ -889,7 +889,7 @@
 
 #ifdef WIRELESS_EXT
 // Frequency list (map channels to frequencies)
-const long frequency_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
+static const long frequency_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
 				2447, 2452, 2457, 2462, 2467, 2472, 2484 };
 
 // A few details needed for WEP (Wireless Equivalent Privacy)
--- linux-2.5.70-mm6/drivers/net/wireless/atmel.c.old	2003-06-08 17:23:55.000000000 +0200
+++ linux-2.5.70-mm6/drivers/net/wireless/atmel.c	2003-06-08 17:24:21.000000000 +0200
@@ -1903,7 +1903,7 @@
 	return 0;
 }
 
-const long frequency_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
+static const long frequency_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
 				2447, 2452, 2457, 2462, 2467, 2472, 2484 };
 
 static int atmel_set_freq(struct net_device *dev,
