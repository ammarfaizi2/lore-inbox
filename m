Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285183AbRLXRSL>; Mon, 24 Dec 2001 12:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285184AbRLXRSC>; Mon, 24 Dec 2001 12:18:02 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:3498 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S285183AbRLXRRx>;
	Mon, 24 Dec 2001 12:17:53 -0500
Message-ID: <3C280D5B.274EC187@sltnet.lk>
Date: Mon, 24 Dec 2001 23:23:39 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sfr@canb.auug.org.au, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] A slightly smarter dmi_scan.c
Content-Type: multipart/mixed;
 boundary="------------29845CCAE1C230EF8F04C323"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------29845CCAE1C230EF8F04C323
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> APM can also be compiled as a module.

Right. Thanks. I blatantly ignored that APM can be built as modules ;(
The fixed patch is here.

Cheerio !

	- ioj

~~~~
    Ask not of race, but ask of conduct: 
    From the stick is born the sacred fire:
    The wise ascetic, though lowly born,
    Is noble in his modest self-control.
                - Gotama Buddha
.
--------------29845CCAE1C230EF8F04C323
Content-Type: text/plain; charset=us-ascii;
 name="dmi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi.patch"

--- linux/arch/i386/kernel/dmi_scan.c	Mon Dec 24 22:50:41 2001
+++ linux/arch/i386/kernel/dmi_scan.c.c	Mon Dec 24 22:53:21 2001
@@ -255,26 +255,29 @@
 
 static __init int set_realmode_power_off(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM) || defined (CONFIG_APM_MODULE)
        if (apm_info.realmode_power_off == 0)
        {
                apm_info.realmode_power_off = 1;
                printk(KERN_INFO "%s bios detected. Using realmode poweroff only.\n", d->ident);
        }
+#endif
        return 0;
 }
 
-
 /* 
  * Some laptops require interrupts to be enabled during APM calls 
  */
 
 static __init int set_apm_ints(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM) || defined (CONFIG_APM_MODULE)
 	if (apm_info.allow_ints == 0)
 	{
 		apm_info.allow_ints = 1;
 		printk(KERN_INFO "%s machine detected. Enabling interrupts during APM calls.\n", d->ident);
 	}
+#endif
 	return 0;
 }
 
@@ -284,15 +287,16 @@
 
 static __init int apm_is_horked(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM) || defined (CONFIG_APM_MODULE)
 	if (apm_info.disabled == 0)
 	{
 		apm_info.disabled = 1;
 		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
 	}
+#endif
 	return 0;
 }
 
-
 /*
  *  Check for clue free BIOS implementations who use
  *  the following QA technique
@@ -311,10 +315,12 @@
 
 static __init int broken_apm_power(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM) || defined (CONFIG_APM_MODULE)
 	apm_info.get_power_status_broken = 1;
 	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
+#endif
 	return 0;
-}		
+}
 
 /*
  * Check for a Sony Vaio system
@@ -341,8 +347,10 @@
  
 static __init int swab_apm_power_in_minutes(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM) || defined (CONFIG_APM_MODULE)
 	apm_info.get_power_status_swabinminutes = 1;
 	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
+#endif
 	return 0;
 }
 

--------------29845CCAE1C230EF8F04C323--

