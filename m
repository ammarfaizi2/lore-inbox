Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263869AbUDZNoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUDZNoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbUDZNm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:42:58 -0400
Received: from mail.convergence.de ([212.84.236.4]:64387 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261852AbUDZNlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:41:15 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 2/9] DVB: Documentation and Kconfig updazes
In-Reply-To: <10829866821854@convergence.de>
Message-Id: <10829867363017@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:41:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] misc. documentation updates, KConfig help file updates
- [DVB] make Twinhan driver depend on bt8xx
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/Kconfig linux-2.6.5-patched/drivers/media/dvb/frontends/Kconfig
--- xx-linux-2.6.5/drivers/media/dvb/frontends/Kconfig	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/Kconfig	2004-04-10 16:43:36.000000000 +0200
@@ -3,7 +3,7 @@
 
 config DVB_TWINHAN_DST
 	tristate "TWINHAN DST based DVB-S frontend (QPSK)"
-	depends on DVB_CORE
+	depends on DVB_CORE && DVB_BT8XX
 	help
 	  Used in such cards as the VP-1020/1030, Twinhan DST,
 	  VVmer TV@SAT. Say Y when you want to support frontends 
diff -urawBN xx-linux-2.6.5/Documentation/dvb/cards.txt linux-2.6.5-patched/Documentation/dvb/cards.txt
--- xx-linux-2.6.5/Documentation/dvb/cards.txt	2004-03-12 20:31:01.000000000 +0100
+++ linux-2.6.5-patched/Documentation/dvb/cards.txt	2004-03-19 18:13:54.000000000 +0100
@@ -50,6 +50,8 @@
     - Technotrend Budget / Hauppauge WinTV-Nova PCI Cards
     - SATELCO Multimedia PCI
     - KNC1 DVB-S
+    - Typhoon DVB-S budget
+    - Fujitsu-Siemens Activy DVB-S budget card
 
 o Cards based on the B2C2 Inc. FlexCopII/IIb/III:
   - Technisat SkyStar2 PCI DVB card revision 2.3, 2.6B, 2.6C
diff -urawBN xx-linux-2.6.5/Documentation/dvb/contributors.txt linux-2.6.5-patched/Documentation/dvb/contributors.txt
--- xx-linux-2.6.5/Documentation/dvb/contributors.txt	2004-02-22 14:48:36.000000000 +0100
+++ linux-2.6.5-patched/Documentation/dvb/contributors.txt	2004-03-19 18:13:54.000000000 +0100
@@ -62,5 +62,13 @@
   for his work on calculating and checking the crc's for the
   TechnoTrend/Hauppauge DEC driver firmware
 
+Michael Dreher <michael@5dot1.de>
+Andreas 'randy' Weinberger
+  for the support of the Fujitsu-Siemens Activy budget DVB-S
+
+Kenneth Aafløy <ke-aa@frisurf.no>
+  for adding support for Typhoon DVB-S budget card
+
+
 (If you think you should be in this list, but you are not, drop a
  line to the DVB mailing list)
diff -urawBN xx-linux-2.6.5/Documentation/dvb/faq.txt linux-2.6.5-patched/Documentation/dvb/faq.txt
--- xx-linux-2.6.5/Documentation/dvb/faq.txt	2004-03-12 20:31:01.000000000 +0100
+++ linux-2.6.5-patched/Documentation/dvb/faq.txt	2004-04-08 17:54:49.000000000 +0200
@@ -94,6 +94,11 @@
 		MythTV - analog TV PVR, but now with DVB support, too
 		(with software MPEG decode)
 
+	http://dvbsnoop.sourceforge.net/
+		DVB sniffer program to monitor, analyze, debug, dump
+		or view dvb/mpeg/dsm-cc/mhp stream information (TS,
+		PES, SECTION)
+
 4. Can't get a signal tuned correctly
 
 	If you are using a Technotrend/Hauppauge DVB-C card *without* analog
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/Kconfig linux-2.6.5-patched/drivers/media/dvb/Kconfig
--- xx-linux-2.6.5/drivers/media/dvb/Kconfig	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/Kconfig	2003-10-13 06:08:45.000000000 +0200
@@ -18,12 +18,11 @@
 	  Please report problems regarding this driver to the LinuxDVB 
 	  mailing list.
 
-	  You might want add the following lines to your /etc/modprobe.conf:
+	  You might want add the following lines to your /etc/modules.conf:
 	  	
 	  	alias char-major-250 dvb
 	  	alias dvb dvb-ttpci
-	  	install dvb-ttpci /sbin/modprobe --first-time -i dvb-ttpci && \
-			/sbin/modprobe -a alps_bsru6 alps_bsrv2 \
+	  	below dvb-ttpci alps_bsru6 alps_bsrv2 \
 	  			grundig_29504-401 grundig_29504-491 \
 	  			ves1820
 


