Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423592AbWKHUhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423592AbWKHUhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423593AbWKHUhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:37:55 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56526 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423592AbWKHUhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:37:54 -0500
Subject: [PATCH] HZ: 300Hz support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 20:42:37 +0000
Message-Id: <1163018557.23956.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two things. Firstly the unit is "Hz" not "HZ". Secondly it is useful
to have 300Hz support when doing multimedia work. 250 is fine for us in
Europe but the US frame rate is 30fps (29.99 blah for pedants). 300
gives us a tick divisible by both 25 and 30, and for interlace work 50
and 60. It's also giving similar performance to 250Hz.

I'd argue we should remove 250 and add 300, but that might be excess
disruption for now.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux.vanilla-2.6.19-rc4-mm1/kernel/Kconfig.hz
linux-2.6.19-rc4-mm1/kernel/Kconfig.hz
--- linux.vanilla-2.6.19-rc4-mm1/kernel/Kconfig.hz	2006-10-31
15:40:54.000000000 +0000
+++ linux-2.6.19-rc4-mm1/kernel/Kconfig.hz	2006-11-08 17:06:38.000000000
+0000
@@ -7,7 +7,7 @@
 	default HZ_250
 	help
 	 Allows the configuration of the timer frequency. It is customary
-	 to have the timer interrupt run at 1000 HZ but 100 HZ may be more
+	 to have the timer interrupt run at 1000 Hz but 100 Hz may be more
 	 beneficial for servers and NUMA systems that do not need to have
 	 a fast response for user interaction and that may experience bus
 	 contention and cacheline bounces as a result of timer interrupts.
@@ -19,21 +19,30 @@
 	config HZ_100
 		bool "100 HZ"
 	help
-	  100 HZ is a typical choice for servers, SMP and NUMA systems
+	  100 Hz is a typical choice for servers, SMP and NUMA systems
 	  with lots of processors that may show reduced performance if
 	  too many timer interrupts are occurring.
 
 	config HZ_250
 		bool "250 HZ"
 	help
-	 250 HZ is a good compromise choice allowing server performance
+	 250 Hz is a good compromise choice allowing server performance
 	 while also showing good interactive responsiveness even
-	 on SMP and NUMA systems.
+	 on SMP and NUMA systems. If you are going to be using NTSC video
+	 or multimedia, selected 300Hz instead.
+
+	config HZ_300
+		bool "300 HZ"
+	help
+	 300 Hz is a good compromise choice allowing server performance
+	 while also showing good interactive responsiveness even
+	 on SMP and NUMA systems and exactly dividing by both PAL and
+	 NTSC frame rates for video and multimedia work.
 
 	config HZ_1000
 		bool "1000 HZ"
 	help
-	 1000 HZ is the preferred choice for desktop systems and other
+	 1000 Hz is the preferred choice for desktop systems and other
 	 systems requiring fast interactive responses to events.
 
 endchoice
@@ -42,5 +51,6 @@
 	int
 	default 100 if HZ_100
 	default 250 if HZ_250
+	default 300 if HZ_300
 	default 1000 if HZ_1000
 

 

