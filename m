Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVKGEDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVKGEDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKGEDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:03:19 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:14555 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750812AbVKGEDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 23:03:18 -0500
Message-ID: <436ED24A.7090006@ens-lyon.org>
Date: Sun, 06 Nov 2005 23:04:26 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010100060909030004010309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010100060909030004010309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
>  
>
Hi Andrew,

drivers/cpufreq/cpufreq.c uses current_in_cpu_hotplug.
But, kernel/cpu.c is not built on UP boxes.
This generates the following error:

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `__cpufreq_driver_target':
: undefined reference to `current_in_cpu_hotplug'

The attached patch should fix it.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Regards,
Brice


--------------010100060909030004010309
Content-Type: text/x-patch;
 name="fix-missing-current_in_cpu_hotplug-on-up.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-missing-current_in_cpu_hotplug-on-up.patch"

--- linux-mm/include/linux/cpu.h.old	2005-11-06 22:08:39.000000000 -0500
+++ linux-mm/include/linux/cpu.h	2005-11-06 22:41:17.000000000 -0500
@@ -33,7 +33,6 @@
 
 extern int register_cpu(struct cpu *, int, struct node *);
 extern struct sys_device *get_cpu_sysdev(int cpu);
-extern int current_in_cpu_hotplug(void);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *, struct node *);
 #endif
@@ -43,6 +42,7 @@
 /* Need to know about CPUs going up/down? */
 extern int register_cpu_notifier(struct notifier_block *nb);
 extern void unregister_cpu_notifier(struct notifier_block *nb);
+extern int current_in_cpu_hotplug(void);
 
 int cpu_up(unsigned int cpu);
 
@@ -55,6 +55,10 @@
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
+static inline int current_in_cpu_hotplug(void)
+{
+	return 0;
+}
 
 #endif /* CONFIG_SMP */
 extern struct sysdev_class cpu_sysdev_class;

--------------010100060909030004010309--
