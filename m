Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbUKZTi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbUKZTi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUKZTim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:38:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262362AbUKZTVx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:21:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Date: Fri, 26 Nov 2004 10:38:31 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD586C@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Thread-Index: AcTS4s4AZT64CLAaTS2O9jGnO5RXDwAfg//A
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <linux-pm@lists.osdl.org>
X-OriginalArrivalTime: 26 Nov 2004 02:38:32.0419 (UTC) FILETIME=[051B7330:01C4D361]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Okay, this should be better patch. It works here.

device_power_down() might fail, in this case we should
bail out, right?

Thanks,
-yi 

> --- clean/kernel/power/swsusp.c	2004-10-19
> 14:16:29.000000000 +0200
> +++ linux/kernel/power/swsusp.c	2004-11-25
> 12:27:35.000000000 +0100
> @@ -854,11 +840,13 @@
>  	if ((error = arch_prepare_suspend()))
>  		return error;
>  	local_irq_disable();
> +	device_power_down(3);
>  	save_processor_state();
>  	error = swsusp_arch_suspend();
>  	/* Restore control flow magically appears here */ 
>  	restore_processor_state(); restore_highmem();
> +	device_power_up();
>  	local_irq_enable();
>  	return error;
>  }
> @@ -878,6 +866,7 @@
>  {
>  	int error;
>  	local_irq_disable();
> +	device_power_down(3);
>  	/* We'll ignore saved state, but this gets preempt count (etc)
>  	right */ save_processor_state();
>  	error = swsusp_arch_resume();
> @@ -887,6 +876,7 @@
>  	BUG_ON(!error);
>  	restore_processor_state();
>  	restore_highmem();
> +	device_power_up();
>  	local_irq_enable();
>  	return error;
>  }

