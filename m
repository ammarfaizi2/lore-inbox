Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSI3Uer>; Mon, 30 Sep 2002 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSI3Uer>; Mon, 30 Sep 2002 16:34:47 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:51935 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261363AbSI3Ueq>; Mon, 30 Sep 2002 16:34:46 -0400
Date: Mon, 30 Sep 2002 22:37:33 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       m.c.p@wolk-project.de
Subject: [PATCH][vandrove@vc.cvut.cz: Re: 2.5.39-bk crashes here when P4 clock modulation enabled]
Message-ID: <20020930223733.A1003@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan,

In two drivers a wrong size of memory was allocated for cpufreq_driver: as
it must include NR_CPUS times a struct cpufreq_policy (and not struct
cpufreq_freqs). Thanks to Petr Vandrovec for this patch.

	Dominik

diff -urdN linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-09-30 11:47:34.000000000 +0000
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2002-09-30 19:52:33.000000000 +0000
@@ -221,7 +221,7 @@
 
 	printk(KERN_INFO PFX "P4/Xeon(TM) CPU On-Demand Clock Modulation available\n");
 	driver = kmalloc(sizeof(struct cpufreq_driver) +
-			 NR_CPUS * sizeof(struct cpufreq_freqs), GFP_KERNEL);
+			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
 		return -ENOMEM;
 
diff -urdN linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-09-30 11:47:18.000000000 +0000
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-09-30 19:53:01.000000000 +0000
@@ -234,7 +234,7 @@
 
 	/* initialization of main "cpufreq" code*/
 	driver = kmalloc(sizeof(struct cpufreq_driver) +
-			 NR_CPUS * sizeof(struct cpufreq_freqs), GFP_KERNEL);
+			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver) {
 		release_region (POWERNOW_IOPORT, 16);
 		return -ENOMEM;

