Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbTCITHG>; Sun, 9 Mar 2003 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbTCITHG>; Sun, 9 Mar 2003 14:07:06 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:40837 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262561AbTCITHF>; Sun, 9 Mar 2003 14:07:05 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 9 Mar 2003 11:17:29 -0800
Message-Id: <200303091917.LAA02587@adam.yggdrasil.com>
To: linux@brodo.de, rmk@arm.linux.org.uk
Subject: 2.5.64-bk[2-4]: CONFIG_CPU_FREQ_24_API breaks kernel/cpufreq.c compile
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.64-bk2 added the following lines to
cpufreq_add_dev in kernel/cpufreq.c:

#ifdef CONFIG_CPU_FREQ_24_API
        cpu_min_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.min_freq;
        cpu_max_freq[cpu] = cpufreq_driver->policy[cpu].cpuinfo.max_freq;
        cpu_cur_freq[cpu] = cpufreq_driver->cpu_cur_freq[cpu];
#endif


	However, cpu_{min,max,cur}_freq are static variables in
drivers/cpufreq/userspace.c.  Making the variables global is not a
sufficient fix, because drivers/cpufreq/userspace.c can be built as
separate module.  So, I guess the variables should be moved to
kernel/cpufreq.c or the code that I quoted above should somehow be
moved.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
