Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUITDMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUITDMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 23:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUITDMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 23:12:46 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:48561 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265817AbUITDMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 23:12:43 -0400
Message-ID: <cone.1095649950.909900.10443.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux@brodo.de
Subject: [PATCH] Add on-demand cpu-freq governor as default option
Date: Mon, 20 Sep 2004 13:12:30 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1095649950-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1095649950-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch adds the option of using the on-demand cpu-frequency governor as 
the default governor in Kconfig.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--=_pc.kolivas.org-1095649950-0000
Content-Description: ondemand_governor_default.diff
Content-Disposition: inline;
  FILENAME="ondemand_governor.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.9-rc2-mm1/drivers/cpufreq/Kconfig
===================================================================
--- linux-2.6.9-rc2-mm1.orig/drivers/cpufreq/Kconfig	2004-09-19 19:49:57.716825544 +1000
+++ linux-2.6.9-rc2-mm1/drivers/cpufreq/Kconfig	2004-09-19 19:52:36.919623040 +1000
@@ -36,6 +36,17 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
 	  program shall be able to set the CPU dynamically without having
 	  to enable the userspace governor manually.
 
+config CPU_FREQ_DEFAULT_GOV_ONDEMAND
+	bool "ondemand"
+	select CPU_FREQ_GOV_ONDEMAND
+	help
+	  Use the CPUFreq governor 'ondemand' as default. 
+	  This governor does a periodic polling and 
+	  changes frequency based on the CPU utilization.
+	  The support for this governor depends on CPU capability to
+	  do fast frequency switching (i.e, very low latency frequency
+	  transitions). 
+
 endchoice
 
 config CPU_FREQ_GOV_PERFORMANCE
Index: linux-2.6.9-rc2-mm1/include/linux/cpufreq.h
===================================================================
--- linux-2.6.9-rc2-mm1.orig/include/linux/cpufreq.h	2004-09-19 19:49:57.765818096 +1000
+++ linux-2.6.9-rc2-mm1/include/linux/cpufreq.h	2004-09-19 19:52:36.919623040 +1000
@@ -323,6 +323,9 @@ extern struct cpufreq_governor cpufreq_g
 #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE)
 extern struct cpufreq_governor cpufreq_gov_userspace;
 #define CPUFREQ_DEFAULT_GOVERNOR	&cpufreq_gov_userspace
+#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND)
+extern struct cpufreq_governor cpufreq_gov_dbs;
+#define CPUFREQ_DEFAULT_GOVERNOR	&cpufreq_gov_dbs
 #endif
 
 

--=_pc.kolivas.org-1095649950-0000--
