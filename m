Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbUKRArn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbUKRArn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbUKRApk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:45:40 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:64918 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262602AbUKRAnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:43:07 -0500
Message-ID: <419BF015.3050900@mega.ist.utl.pt>
Date: Thu, 18 Nov 2004 00:43:01 +0000
From: Pedro Venda <pjlv@mega.ist.utl.pt>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041107)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial update: option for default ondemand cpufreq governor
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial patch that adds a Kconfig option to select the
*ondemand* cpufreq governor as the *default cpufreq governor*.

It seemed as useful as the other default governor options, and since
nobody else did it, here it is.

Feedback would be very appreciated. Also, please note that this is my first patch.

Applies cleanly to 2.6.10-rc2, 2.6.10-rc2-bk2 and 2.6.10-rc2-mm1.
Applies to 2.6.9 sources with line offset errors only.

Signed-off-by; Pedro Venda <pjlv@mega.ist.utl.pt>

diff -uprN linux-2.6.10-rc2-original/drivers/cpufreq/Kconfig linux-2.6.10-rc2/drivers/cpufreq/Kconfig
--- linux-2.6.10-rc2-original/drivers/cpufreq/Kconfig	2004-11-17 23:37:48.000000000 +0000
+++ linux-2.6.10-rc2/drivers/cpufreq/Kconfig	2004-11-17 23:52:32.153215407 +0000
@@ -65,6 +65,15 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
  	  program shall be able to set the CPU dynamically without having
  	  to enable the userspace governor manually.

+config CPU_FREQ_DEFAULT_GOV_ONDEMAND
+	bool "ondemand"
+	select CPU_FREQ_GOV_ONDEMAND
+	help
+	  Use the CPUFreq governor 'ondemand' as default. This uses a
+	  polling mechanism to dynamically change frequency based on
+	  the CPU utilization. The desired functioning of this governor
+	  depends on the CPU capability to do fast frequency switching.
+	
  endchoice

  config CPU_FREQ_GOV_PERFORMANCE
diff -uprN linux-2.6.10-rc2-original/include/linux/cpufreq.h linux-2.6.10-rc2/include/linux/cpufreq.h
--- linux-2.6.10-rc2-original/include/linux/cpufreq.h	2004-11-17 23:38:07.000000000 +0000
+++ linux-2.6.10-rc2/include/linux/cpufreq.h	2004-11-17 23:53:48.000000000 +0000
@@ -323,6 +323,9 @@ extern struct cpufreq_governor cpufreq_g
  #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE)
  extern struct cpufreq_governor cpufreq_gov_userspace;
  #define CPUFREQ_DEFAULT_GOVERNOR	&cpufreq_gov_userspace
+#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND)
+extern struct cpufreq_governor cpufreq_gov_dbs;
+#define CPUFREQ_DEFAULT_GOVERNOR	&cpufreq_gov_dbs
  #endif



-- 

Pedro João Lopes Venda
email: pjlv@mega.ist.utl.pt
http://arrakis.dhis.org



