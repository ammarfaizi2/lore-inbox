Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUJCKJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUJCKJB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 06:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbUJCKJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 06:09:00 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:10853 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267766AbUJCKI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 06:08:58 -0400
Date: Sun, 03 Oct 2004 06:08:57 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper call
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, trivial@rustcorp.com.au,
       rusty@rustcorp.com.au
Message-id: <20041003100857.GB5804@optonline.net>
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

