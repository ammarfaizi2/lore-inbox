Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWFRPD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWFRPD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWFRPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:03:27 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:38037 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932225AbWFRPD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:03:27 -0400
Date: Sun, 18 Jun 2006 17:03:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Con Kolivas <kernel@kolivas.org>
cc: Willy Tarreau <w@1wt.eu>, linux list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
In-Reply-To: <200606182008.31788.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0606181702030.8787@yvahk01.tjqt.qr>
References: <200606181732.48952.kernel@kolivas.org> <20060618074247.GF13255@w.ods.org>
 <200606182008.31788.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Thanks for your perspective. I found performance hits on computational tasks 
>with 250 vs 100 but your finer precision makes perfect sense.
>

Or this one so every user can set any value s/he wants. :)

Done-by: Me.

diff --fast -Ndpru linux-2.6.17-rc6~/kernel/Kconfig.hz linux-2.6.17-rc6+/kernel/Kconfig.hz
--- linux-2.6.17-rc6~/kernel/Kconfig.hz	2006-06-06 02:57:02.000000000 +0200
+++ linux-2.6.17-rc6+/kernel/Kconfig.hz	2006-06-16 17:15:46.884794000 +0200
@@ -2,45 +2,26 @@
 # Timer Interrupt Frequency Configuration
 #
 
-choice
-	prompt "Timer frequency"
-	default HZ_250
-	help
-	 Allows the configuration of the timer frequency. It is customary
-	 to have the timer interrupt run at 1000 HZ but 100 HZ may be more
-	 beneficial for servers and NUMA systems that do not need to have
-	 a fast response for user interaction and that may experience bus
-	 contention and cacheline bounces as a result of timer interrupts.
-	 Note that the timer interrupt occurs on each processor in an SMP
-	 environment leading to NR_CPUS * HZ number of timer interrupts
-	 per second.
-
-
-	config HZ_100
-		bool "100 HZ"
-	help
-	  100 HZ is a typical choice for servers, SMP and NUMA systems
-	  with lots of processors that may show reduced performance if
-	  too many timer interrupts are occurring.
-
-	config HZ_250
-		bool "250 HZ"
-	help
-	 250 HZ is a good compromise choice allowing server performance
-	 while also showing good interactive responsiveness even
-	 on SMP and NUMA systems.
-
-	config HZ_1000
-		bool "1000 HZ"
-	help
-	 1000 HZ is the preferred choice for desktop systems and other
-	 systems requiring fast interactive responses to events.
+config HZ
+    int "Timer frequency"
+    default 100
+    ---help---
+        Allows the configuration of the timer frequency. It is
+        customary to have the timer interrupt run at 1000 HZ but 100 HZ
+        may be more beneficial for servers and NUMA systems that do not
+        need to have a fast response for user interaction and that may
+        experience bus contention and cacheline bounces as a result of
+        timer interrupts.  Note that the timer interrupt occurs on each
+        processor in an SMP environment leading to NR_CPUS * HZ number
+        of timer interrupts per second.
 
-endchoice
+        100 HZ is a typical choice for servers, SMP and NUMA systems
+        with lots of processors that may show reduced performance if
+        too many timer interrupts are occurring.
 
-config HZ
-	int
-	default 100 if HZ_100
-	default 250 if HZ_250
-	default 1000 if HZ_1000
+        250 HZ is a good compromise choice allowing server performance
+        while also showing good interactive responsiveness even on SMP
+        and NUMA systems.
 
+        1000 HZ is the preferred choice for desktop systems and other
+        systems requiring fast interactive responses to events.
#<<eof>>



Jan Engelhardt
-- 
