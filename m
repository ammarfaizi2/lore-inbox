Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVCBCmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVCBCmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 21:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVCBCmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 21:42:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1019 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262141AbVCBClx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 21:41:53 -0500
Date: Tue, 1 Mar 2005 18:41:52 -0800
From: Todd Poynor <tpoynor@mvista.com>
To: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [PATCH] Custom power states for non-ACPI systems
Message-ID: <20050302024152.GB5724@slurryseal.ddns.mvista.com>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An example of custom power states for the TI OMAP family.
/sys/power/states supports a state named "deepsleep", which corresponds
to the platform state actually entered by the present-day system suspend
handler.  It no longer offers the option of "disk" suspend which would
not normally be available in an OMAP-based system, nor does it offer the
choices "standby" or "mem", which are currently somewhat arbitrarily
mapped to actual platform power states on OMAPs.  In the future the OMAP
could be extended to offer the choice of "big sleep" as well, another
platform-specific low-power mode that falls under the general category
of suspend-to-mem, once it is feasible to no longer use the same set of
system suspend state values for all platforms and drivers (as mentioned
in the base note).

Index: linux-2.6.10/arch/arm/mach-omap/pm.c
===================================================================
--- linux-2.6.10.orig/arch/arm/mach-omap/pm.c	2005-03-02 01:10:27.000000000 +0000
+++ linux-2.6.10/arch/arm/mach-omap/pm.c	2005-03-02 01:13:41.000000000 +0000
@@ -576,8 +576,20 @@
 }
 
 
+static struct pm_suspend_method omap_pm_suspend_methods[] = {
+	{
+		.name = "deepsleep",
+		.state = PM_SUSPEND_MEM,
+	},
+	{
+		.name = NULL,
+	},
+};
+
+
 struct pm_ops omap_pm_ops ={
 	.pm_disk_mode = 0,
+	.pm_suspend_methods = omap_pm_suspend_methods,
         .prepare        = omap_pm_prepare,
         .enter          = omap_pm_enter,
         .finish         = omap_pm_finish,
