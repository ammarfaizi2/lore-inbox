Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVJUOwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVJUOwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVJUOwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:52:49 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:11399 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964966AbVJUOws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:52:48 -0400
Date: Fri, 21 Oct 2005 09:52:47 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 4/9] ipmi: poweroff cleanups
Message-ID: <20051021145247.GD19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make module_param and MODULE_PARAM_DESC agree on poweroff_powercycle
name.

There was an extraneous ifdef in the IPMI poweroff code that
prevented it from working if PROC_FS was disabled.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: asdf/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- asdf.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ asdf/drivers/char/ipmi/ipmi_poweroff.c
@@ -56,7 +56,7 @@ static int poweroff_powercycle;
 
 /* parameter definition to allow user to flag power cycle */
 module_param(poweroff_powercycle, int, 0644);
-MODULE_PARM_DESC(poweroff_powercycles, " Set to non-zero to enable power cycle instead of power down. Power cycle is contingent on hardware support, otherwise it defaults back to power down.");
+MODULE_PARM_DESC(poweroff_powercycle, " Set to non-zero to enable power cycle instead of power down. Power cycle is contingent on hardware support, otherwise it defaults back to power down.");
 
 /* Stuff from the get device id command. */
 static unsigned int mfg_id;
@@ -611,9 +611,7 @@ static int ipmi_poweroff_init (void)
 	}
 #endif
 
-#ifdef CONFIG_PROC_FS
 	rv = ipmi_smi_watcher_register(&smi_watcher);
-#endif
 	if (rv) {
 		unregister_sysctl_table(ipmi_table_header);
 		printk(KERN_ERR PFX "Unable to register SMI watcher: %d\n", rv);
