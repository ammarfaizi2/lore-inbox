Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTLWSGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTLWSGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:06:15 -0500
Received: from iron-c-1.tiscali.it ([212.123.84.81]:48268 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S262104AbTLWSEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:04:24 -0500
X-BrightmailFiltered: true
Date: Tue, 23 Dec 2003 19:04:29 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Export available frequencies on K7 mobile CPUs
Message-ID: <20031223180429.GA11198@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
the following patch make powernow-k7.c export supported frequencies via
sysfs. I'm trying to write a scaling deamon and I need to know them.

--- linux-2.6/arch/i386/kernel/cpu/cpufreq/powernow-k7.c.orig	Fri Dec 19 19:27:48 2003
+++ linux-2.6/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	Fri Dec 21 20:42:21 2003
@@ -389,15 +389,29 @@
 	policy->cpuinfo.transition_latency = latency;
 	policy->cur = maximum_speed;
 
+	cpufreq_frequency_table_get_attr(powernow_table, policy->cpu);
+
 	return cpufreq_frequency_table_cpuinfo(policy, powernow_table);
 }
 
+static int powernow_cpu_exit (struct cpufreq_policy *policy) {
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static struct freq_attr* powernow_table_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
 static struct cpufreq_driver powernow_driver = {
 	.verify 	= powernow_verify,
 	.target 	= powernow_target,
 	.init		= powernow_cpu_init,
+	.exit		= powernow_cpu_exit,
 	.name		= "powernow-k7",
 	.owner		= THIS_MODULE,
+	.attr		= powernow_table_attr,
 };
 
 static int __init powernow_init (void)


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono
