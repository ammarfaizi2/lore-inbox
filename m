Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVDGIZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVDGIZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVDGIX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:23:56 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:30661 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262271AbVDGIWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:22:20 -0400
Date: Thu, 7 Apr 2005 01:21:37 -0700
From: Tony Lindgren <tony@atomide.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Dynamic Tick version 050406-1
Message-ID: <20050407082136.GF13475@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <425451A0.7020000@tuxrocks.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Frank Sorenson <frank@tuxrocks.com> [050406 14:16]:
> Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's an updated dyn-tick patch. Some minor fixes:
> 
> Doesn't look so good here.  I get this with 2.6.12-rc2 (plus a few other patches).
> Disabling Dynamic Tick makes everything happy again (it boots).
> 
> [4294688.655000] Unable to handle kernel NULL pointer dereference at virtual address 00000000

Thanks for trying it out. What kind of hardware do you have? Does it
have HPET? It looks like no suitable timer for dyn-tick is found...
Maybe the following patch helps?

Tony

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-dyntick-init-fix

--- a/kernel/dyn-tick-timer.c	2005-03-01 16:41:05 -08:00
+++ b/kernel/dyn-tick-timer.c	2005-04-07 00:57:30 -07:00
@@ -232,10 +232,6 @@
 {
 	int ret = 0;
 
-	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_state);
-	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_int);
-	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_dbg);
-
 	if (dyn_tick_cfg->arch_init == NULL ||
 	    !(dyn_tick->state & DYN_TICK_SUITABLE))
 		return -ENODEV;
@@ -245,6 +241,10 @@
 		printk(KERN_WARNING "dyn-tick: Init failed\n");
 		return -ENODEV;
 	}
+
+	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_state);
+	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_int);
+	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_dbg);
 
 	printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
 

--SLDf9lqlvOQaIe6s--
