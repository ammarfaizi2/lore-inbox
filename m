Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270959AbTGPQxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270961AbTGPQxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:53:05 -0400
Received: from fmr04.intel.com ([143.183.121.6]:8443 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S270959AbTGPQw6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:52:58 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] Use of Performance Monitoring Counters based on Model number
Date: Wed, 16 Jul 2003 10:07:49 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D0F9@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Use of Performance Monitoring Counters based on Model number
Thread-Index: AcNLvMkd+TiLHhpeT8OwYDWoryY9SQ==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 16 Jul 2003 17:07:50.0079 (UTC) FILETIME=[C95D84F0:01C34BBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Attached is a small patch to make Linux kernel use of performance
monitoring MSRs based on known processor models. Future processor
implementation models may not support the same MSR layout.

Please apply.

Thanks,
-Venkatesh




--- linux-2.5.72-monitor/arch/i386/kernel/nmi.c.org	2003-06-16
21:20:02.000000000 -0700
+++ linux-2.5.72-monitor/arch/i386/kernel/nmi.c	2003-06-20
15:47:29.000000000 -0700
@@ -157,9 +157,15 @@
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd)
+				break;
+
 			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3)
+				break;
+
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
 			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
 			break;
@@ -324,9 +338,15 @@
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd)
+				return;
+
 			setup_p6_watchdog();
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3)
+				return;
+
 			if (!setup_p4_watchdog())
 				return;
 			break;


