Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262854AbTCKING>; Tue, 11 Mar 2003 03:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262856AbTCKING>; Tue, 11 Mar 2003 03:13:06 -0500
Received: from firewall.osb.hu ([193.224.234.1]:56843 "EHLO firewall.osb.hu")
	by vger.kernel.org with ESMTP id <S262854AbTCKINF>;
	Tue, 11 Mar 2003 03:13:05 -0500
Date: Tue, 11 Mar 2003 09:15:13 +0100 (CET)
From: Soos Peter <sp@osb.hu>
To: linux-kernel@vger.kernel.org
Subject: APM vs. ACPI status detection
Message-ID: <Pine.LNX.4.44.0303110904160.5045-100000@sppc.intranet.osb.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a little patch witch sets apm_info.disabled flag not only if APM 
disabled by user but if it disabled by SMP or ACPI. Please apply.

<-- Cut here -->
--- ./arch/i386/kernel/apm.c.orig	Tue Mar 11 08:59:24 2003
+++ ./arch/i386/kernel/apm.c	Tue Mar 11 09:00:30 2003
@@ -1906,10 +1906,12 @@
 	}
 	if ((smp_num_cpus > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
+		apm_info.disabled = 1;
 		return -ENODEV;
 	}
 	if (PM_IS_ACTIVE()) {
 		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
+		apm_info.disabled = 1;
 		return -ENODEV;
 	}
 	pm_active = 1;
<-- Cut here -->

Regards,
-- 
Soós Péter		Pannonhalmi Fõapátság / Archabbey of Pannonhalma
			H-9090 Pannonhalma, Vár 1.
			Tel: +3696570189, Fax: +3696470011






