Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUIXR0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUIXR0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUIXRZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:25:42 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.68]:61108 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268914AbUIXRYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:24:38 -0400
Date: Fri, 24 Sep 2004 13:24:36 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH 2.6] Add DEVPATH env variable to hotplug helper call
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, akpm@osdl.org, torvalds@osdl.org
Message-id: <20040924172436.GA17723@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add $DEVPATH to the environmental variables during /sbin/hotplug call.

Josef 'Jeff' Sipek.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@optonline.net>
 
diff -Nru a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c	2004-09-24 13:08:57 -04:00
+++ b/kernel/cpu.c	2004-09-24 13:08:57 -04:00
@@ -61,13 +61,13 @@
  * cpu' with certain environment variables set.  */
 static int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
 {
-	char *argv[3], *envp[5], cpu_str[12], action_str[32];
+	char *argv[3], *envp[6], cpu_str[12], action_str[32], devpath_str[38];
 	int i;
 
 	sprintf(cpu_str, "CPU=%d", cpu);
 	sprintf(action_str, "ACTION=%s", action);
-	/* FIXME: Add DEVPATH. --RR */
-
+	sprintf(devpath_str, "DEVPATH=devices/system/cpu/cpu%d", cpu);
+	
 	i = 0;
 	argv[i++] = hotplug_path;
 	argv[i++] = "cpu";
@@ -79,6 +79,7 @@
 	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp[i++] = cpu_str;
 	envp[i++] = action_str;
+	envp[i++] = devpath_str;
 	envp[i] = NULL;
 
 	return call_usermodehelper(argv[0], argv, envp, 0);
