Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUFIAOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUFIAOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUFIAOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:14:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29620 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265429AbUFIAN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:13:58 -0400
Date: Tue, 8 Jun 2004 17:09:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       Simon.Derr@bull.net, wli@holomorphy.com
Subject: PATCH] cpumask 11/10 comment, spacing tweaks
Message-Id: <20040608170935.0b3f2cc8.pj@sgi.com>
In-Reply-To: <20040603101115.7f746d98.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101115.7f746d98.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - If you take my other cpumask patchs, could you add this one?
	 I just noticed that my 'big cpumask comment' was a bit stale.

	 No code changes - just spacing and comments.

Tweak cpumask.h comments, spacing:

 1) Add comments for cpu_present_map macros: num_present_cpus() and cpu_present()
 2) Remove comments for obsolete macros: cpu_set_online(), cpu_set_offline()
 3) Reorder a few comment lines, to match the code and confuse readers of this patch
 3) Tabify one chunk of code

 include/linux/cpumask.h |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc2-mm2/include/linux/cpumask.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/linux/cpumask.h	2004-06-07 15:45:25.000000000 -0700
+++ 2.6.7-rc2-mm2/include/linux/cpumask.h	2004-06-08 16:46:05.000000000 -0700
@@ -47,17 +47,21 @@
  * int cpumask_scnprintf(buf, len, mask) Format cpumask for printing
  * int cpumask_parse(ubuf, ulen, mask)	Parse ascii string as cpumask
  *
+ * for_each_cpu_mask(cpu, mask)		for-loop cpu over mask
+ *
  * int num_online_cpus()		Number of online CPUs
  * int num_possible_cpus()		Number of all possible CPUs
+ * int num_present_cpus()		Number of present CPUs
+ *
  * int cpu_online(cpu)			Is some cpu online?
  * int cpu_possible(cpu)		Is some cpu possible?
- * void cpu_set_online(cpu)		set cpu in cpu_online_map
- * void cpu_set_offline(cpu)		clear cpu in cpu_online_map
+ * int cpu_present(cpu)			Is some cpu present (can schedule)?
+ *
  * int any_online_cpu(mask)		First online cpu in mask
  *
- * for_each_cpu_mask(cpu, mask)		for-loop cpu over mask
  * for_each_cpu(cpu)			for-loop cpu over cpu_possible_map
  * for_each_online_cpu(cpu)		for-loop cpu over cpu_online_map
+ * for_each_present_cpu(cpu)		for-loop cpu over cpu_present_map
  *
  * Subtlety:
  * 1) The 'type-checked' form of cpu_isset() causes gcc (3.3.2, anyway)
@@ -336,19 +340,19 @@
 extern cpumask_t cpu_present_map;
 
 #if NR_CPUS > 1
-#define num_online_cpus()    cpus_weight(cpu_online_map)
-#define num_possible_cpus()  cpus_weight(cpu_possible_map)
-#define num_present_cpus()   cpus_weight(cpu_present_map)
-#define cpu_online(cpu)      cpu_isset((cpu), cpu_online_map)
-#define cpu_possible(cpu)    cpu_isset((cpu), cpu_possible_map)
-#define cpu_present(cpu)     cpu_isset((cpu), cpu_present_map)
+#define num_online_cpus()	cpus_weight(cpu_online_map)
+#define num_possible_cpus()	cpus_weight(cpu_possible_map)
+#define num_present_cpus()	cpus_weight(cpu_present_map)
+#define cpu_online(cpu)		cpu_isset((cpu), cpu_online_map)
+#define cpu_possible(cpu)	cpu_isset((cpu), cpu_possible_map)
+#define cpu_present(cpu)	cpu_isset((cpu), cpu_present_map)
 #else
-#define num_online_cpus()    1
-#define num_possible_cpus()  1
-#define num_present_cpus()   1
-#define cpu_online(cpu)      ((cpu) == 0)
-#define cpu_possible(cpu)    ((cpu) == 0)
-#define cpu_present(cpu)     ((cpu) == 0)
+#define num_online_cpus()	1
+#define num_possible_cpus()	1
+#define num_present_cpus()	1
+#define cpu_online(cpu)		((cpu) == 0)
+#define cpu_possible(cpu)	((cpu) == 0)
+#define cpu_present(cpu)	((cpu) == 0)
 #endif
 
 #define any_online_cpu(mask)			\


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
