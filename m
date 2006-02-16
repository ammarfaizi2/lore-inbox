Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWBPEXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWBPEXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 23:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWBPEXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 23:23:00 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:19597 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S932273AbWBPEXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 23:23:00 -0500
X-Mailer: Openwave WebEngine, version 2.8.16.1 (webedge20-101-1106-101-20040924)
X-Originating-IP: [65.13.11.254]
From: <tomichm@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
CC: <jeremy@goop.org>
Subject: patch to speedstep-centrino.c
Date: Wed, 15 Feb 2006 23:22:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20060216042258.PODB2023.ibm65aec.bellsouth.net@mail.bellsouth.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess I goofed by submitting this in HTML previously...sorry...

Below is a patch to the speedstep-centrino.c file.  It's needed to fix a missing symbol error (online_cpu_map) in the latest mm patch of the kernel.

--- linux-2.6.16-rc3-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c      2006-02-15 22:31:54.561277488 -0500
+++ linux-2.6.16-rc3-mm1-patched/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c      2006-02-15 22:05:15.964091566 -0500
@@ -654,8 +654,10 @@ static int centrino_target (struct cpufr
                return -EINVAL;
        }

+#ifdef CONFIG_SMP
        /* cpufreq holds the hotplug lock, so we are safe from here on */
        cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#endif

        saved_mask = current->cpus_allowed;
        first_cpu = 1;

