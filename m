Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVFJDWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVFJDWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 23:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVFJDWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 23:22:46 -0400
Received: from fmr17.intel.com ([134.134.136.16]:57808 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262417AbVFJDWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 23:22:43 -0400
Subject: [PATCH]x86-x86_64 flush cache for CPU hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, ak <ak@muc.de>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 11:30:08 +0800
Message-Id: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We should flush cache at CPU hotplug. An error has been observed data is
corrupted after CPU hotplug in CPUs with bigger cache.
I guess IA64 requires similar change, Ashok?

Thanks,
Shaohua

Signed-off-by: Shaohua.li<shaohua.li@intel.com>
---

 linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c   |    1 +
 linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/process.c |    1 +
 2 files changed, 2 insertions(+)

diff -puN arch/i386/kernel/process.c~flush_cache_cpuhotplug arch/i386/kernel/process.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/process.c~flush_cache_cpuhotplug	2005-06-10 10:56:05.082247160 +0800
+++ linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c	2005-06-10 11:05:10.597316264 +0800
@@ -155,6 +155,7 @@ static inline void play_dead(void)
 {
 	/* This must be done before dead CPU ack */
 	cpu_exit_clear();
+	wbinvd();
 	mb();
 	/* Ack it */
 	__get_cpu_var(cpu_state) = CPU_DEAD;
diff -puN arch/x86_64/kernel/process.c~flush_cache_cpuhotplug arch/x86_64/kernel/process.c
--- linux-2.6.12-rc6-mm1/arch/x86_64/kernel/process.c~flush_cache_cpuhotplug	2005-06-10 10:56:18.270242280 +0800
+++ linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/process.c	2005-06-10 11:05:23.206399392 +0800
@@ -165,6 +165,7 @@ DECLARE_PER_CPU(int, cpu_state);
 static inline void play_dead(void)
 {
 	idle_task_exit();
+	wbinvd();
 	mb();
 	/* Ack it */
 	__get_cpu_var(cpu_state) = CPU_DEAD;
_


