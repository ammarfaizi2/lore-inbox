Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUFKQaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUFKQaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUFKQ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:26:57 -0400
Received: from poup.poupinou.org ([195.101.94.96]:20266 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S264119AbUFKQXI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:23:08 -0400
Date: Fri, 11 Jun 2004 18:23:07 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix cpumask.h in mainline for UPu
Message-ID: <20040611162307.GA18176@poupinou.org>
Reply-To: Ducrot Bruno <ducrot@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Bruno Ducrot <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to replace for_each_cpu() with for_each_cpu_mask() in
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c

Unfortunately, though, davej pointed me that for_each_cpu_mask()
is not defined in -bk if CONFIG_SMP is not defined.  Since this macro is
the only one not defined if compiled for UP, and since -mm tree do have
the correct behaviour already, is it possible to get this patch in mainline
before this portion of -mm is merged?


 include/linux/cpumask.h |    1 +
 1 files changed, 1 insertion(+)

--- a/include/linux/cpumask.h	2004/06/11 16:06:48
+++ b/include/linux/cpumask.h	2004/06/11 16:08:06
@@ -41,6 +41,7 @@ extern cpumask_t cpu_present_map;
 #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
 #define cpu_present(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
+#define for_each_cpu_mask(cpu, mask) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_present_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)



Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
