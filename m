Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWGCUps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWGCUps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWGCUps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:45:48 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:64434 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751265AbWGCUpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:45:40 -0400
Message-ID: <44A98250.6060508@oracle.com>
Date: Mon, 03 Jul 2006 13:47:12 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, davej@codemonkey.org.uk
Subject: [Ubuntu PATCH] Add Dothan frequency tables for speedstep
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch to Add Dothan frequency tables for speedstep.

Does this conflict with other Dothan handling?

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1db7baafb2d8f9d1356802bb112826bd866221b4

---
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |   89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

--- linux-2617-g21.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
+++ linux-2617-g21/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
@@ -196,6 +196,82 @@ static struct cpufreq_frequency_table ba
 	OP(1700, 1484),
 	{ .frequency = CPUFREQ_TABLE_END }
 };
+
+#undef OP
+
+/* Dothan processor datasheet 30218903.pdf defines 4 voltages for each
+   frequency (VID#A through VID#D) - this macro allows us to define all
+   of these but we only use the VID#C voltages at compile time - this may
+   need some work if we want to select the voltage profile at runtime. */
+
+#define OP(mhz, mva, mvb, mvc, mvd)					\
+	{								\
+		.frequency = (mhz) * 1000,				\
+		.index = (((mhz)/100) << 8) | ((mvc - 700) / 16)       	\
+	}
+
+/* Intel Pentium M processor 715 / 1.50GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1500[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1068, 1068, 1068, 1052),
+	OP(1000, 1148, 1148, 1132, 1116),
+	OP(1200, 1228, 1212, 1212, 1180),
+	OP(1500, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 725 / 1.60GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1600[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1068, 1068, 1052, 1052),
+	OP(1000, 1132, 1132, 1116, 1116),
+	OP(1200, 1212, 1196, 1180, 1164),
+	OP(1400, 1276, 1260, 1244, 1228),
+	OP(1600, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 735 / 1.70GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1700[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1052, 1052, 1052, 1052),
+	OP(1000, 1116, 1116, 1116, 1100),
+	OP(1200, 1180, 1180, 1164, 1148),
+	OP(1400, 1244, 1244, 1228, 1212),
+	OP(1700, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 745 / 1.80GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1800[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1052, 1052, 1052, 1036),
+	OP(1000, 1116, 1100, 1100, 1084),
+	OP(1200, 1164, 1164, 1148, 1132),
+	OP(1400, 1228, 1212, 1212, 1180),
+	OP(1600, 1292, 1276, 1260, 1228),
+	OP(1800, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 755 / 2.00GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_2000[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1052, 1036, 1036, 1036),
+	OP(1000, 1100, 1084, 1084, 1084),
+	OP(1200, 1148, 1132, 1132, 1116),
+	OP(1400, 1196, 1180, 1180, 1164),
+	OP(1600, 1244, 1228, 1228, 1196),
+	OP(1800, 1292, 1276, 1276, 1244),
+	OP(2000, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
 #undef OP
 
 #define _BANIAS(cpuid, max, name)	\
@@ -206,6 +282,13 @@ static struct cpufreq_frequency_table ba
 }
 #define BANIAS(max)	_BANIAS(&cpu_ids[CPU_BANIAS], max, #max)
 
+#define DOTHAN(cpuid, max, name)	\
+{	.cpu_id		= cpuid,	\
+	.model_name	= "Intel(R) Pentium(R) M processor " name "GHz", \
+	.max_freq	= (max)*1000,	\
+	.op_points	= dothan_##max,	\
+}
+
 /* CPU models, their operating frequency range, and freq/voltage
    operating points */
 static struct cpu_model models[] =
@@ -219,6 +302,11 @@ static struct cpu_model models[] =
 	BANIAS(1500),
 	BANIAS(1600),
 	BANIAS(1700),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1500, "1.50"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1600, "1.60"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1700, "1.70"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1800, "1.80"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 2000, "2.00"),
 
 	/* NULL model_name is a wildcard */
 	{ &cpu_ids[CPU_DOTHAN_A1], NULL, 0, NULL },
@@ -231,6 +319,7 @@ static struct cpu_model models[] =
 };
 #undef _BANIAS
 #undef BANIAS
+#undef DOTHAN
 
 static int centrino_cpu_init_table(struct cpufreq_policy *policy)
 {

