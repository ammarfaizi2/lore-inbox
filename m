Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUI1Mlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUI1Mlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUI1Mlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:41:45 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:55774 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S267648AbUI1MlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:41:22 -0400
Date: Tue, 28 Sep 2004 14:40:57 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh.kernel.crashing.org@bogon.ms20.nix>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch]: fix cpufrequency scaling on ppc
Message-ID: <20040928124057.GA3871@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
attached patch against 2.6.9-rc2 fixes cpufrequency scaling after resume
on pmacs. Please apply.
 -- Guido

Signed-off-by: Guido Guenther <agx@sigxcpu.org>


--- linux-2.6.9-rc2.orig/arch/ppc/platforms/pmac_cpufreq.c	2004-09-15 09:22:54.000000000 +0200
+++ linux-2.6.9-rc2/arch/ppc/platforms/pmac_cpufreq.c	2004-09-28 14:36:20.265785384 +0200
@@ -366,12 +367,26 @@
 	return 0x50 + (*reg);
 }
 
+static unsigned int __pmac pmac_cpufreq_get(unsigned int cpu)
+{
+	if (cpu)
+		return -ENODEV;
+	return	cur_freq;
+}
+
+static struct freq_attr* pmac_cpufreq_attr[] = { 
+        &cpufreq_freq_attr_scaling_available_freqs,
+        NULL,
+};
+
 static struct cpufreq_driver pmac_cpufreq_driver = {
 	.verify 	= pmac_cpufreq_verify,
 	.target 	= pmac_cpufreq_target,
 	.init		= pmac_cpufreq_cpu_init,
+	.get		= pmac_cpufreq_get,
 	.name		= "powermac",
 	.owner		= THIS_MODULE,
+	.attr		= pmac_cpufreq_attr,
 };
 
 
