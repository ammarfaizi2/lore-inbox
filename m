Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbRLaFUr>; Mon, 31 Dec 2001 00:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287448AbRLaFUi>; Mon, 31 Dec 2001 00:20:38 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:35790 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S287450AbRLaFUW>;
	Mon, 31 Dec 2001 00:20:22 -0500
Message-ID: <3C309FB1.63544633@sltnet.lk>
Date: Mon, 31 Dec 2001 11:26:09 -0600
From: Alvin of Diaspar <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: james@and.org
Subject: [patch] A slightly smarter dmi_scan.c ?
Content-Type: multipart/mixed;
 boundary="------------965C4EA9FC6533381C54D368"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------965C4EA9FC6533381C54D368
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Greetings everyone,

	OK. This is the last thing of this nature I'm going to submit... After
all, I started this. No need to take this above informal spring
cleaning...
	James, Alan is right. No need for #ifdef's *when* (and only when)
there's a better way to do it. Thanks.

This is against 2.4.17.
--------------965C4EA9FC6533381C54D368
Content-Type: text/plain; charset=us-ascii;
 name="dmi.patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi.patch.2"

--- linux/arch/i386/kernel/dmi_scan.c	Mon Dec 31 10:52:52 2001
+++ linux/arch/i386/kernel/dmi_scan.c.mod	Mon Dec 31 11:12:10 2001
@@ -256,7 +256,7 @@ static __init int set_smp_bios_reboot(st
 
 static __init int set_realmode_power_off(struct dmi_blacklist *d)
 {
-       if (apm_info.realmode_power_off == 0)
+       if (apm_info.bios.version && (apm_info.realmode_power_off == 0))
        {
                apm_info.realmode_power_off = 1;
                printk(KERN_INFO "%s bios detected. Using realmode poweroff only.\n", d->ident);
@@ -271,7 +271,7 @@ static __init int set_realmode_power_off
 
 static __init int set_apm_ints(struct dmi_blacklist *d)
 {
-	if (apm_info.allow_ints == 0)
+	if (apm_info.bios.version && (apm_info.allow_ints == 0))
 	{
 		apm_info.allow_ints = 1;
 		printk(KERN_INFO "%s machine detected. Enabling interrupts during APM calls.\n", d->ident);
@@ -285,7 +285,7 @@ static __init int set_apm_ints(struct dm
 
 static __init int apm_is_horked(struct dmi_blacklist *d)
 {
-	if (apm_info.disabled == 0)
+	if (apm_info.bios.version && (apm_info.disabled == 0))
 	{
 		apm_info.disabled = 1;
 		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
@@ -342,8 +342,10 @@ static __init int sony_vaio_laptop(struc
  
 static __init int swab_apm_power_in_minutes(struct dmi_blacklist *d)
 {
-	apm_info.get_power_status_swabinminutes = 1;
-	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
+	if (apm_info.bios.version) {
+		apm_info.get_power_status_swabinminutes = 1;
+		printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
+	}
 	return 0;
 }
 

--------------965C4EA9FC6533381C54D368--

