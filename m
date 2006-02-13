Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWBMOjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWBMOjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWBMOjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:39:18 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30100 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932118AbWBMOjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:39:17 -0500
Date: Mon, 13 Feb 2006 20:09:22 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <balbir@in.ibm.com>
Subject: Re: [ckrm-tech] [PATCH 2/2] connect the CPU resource controller to CKRM
Message-ID: <20060213143922.GB12279@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060209061142.2164.35994.sendpatchset@debian> <20060209061152.2164.64958.sendpatchset@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209061152.2164.64958.sendpatchset@debian>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 03:11:52PM +0900, KUROSAWA Takahiro wrote:
> This patch provides a resource controller for controlling the CPU ratio 
> per class in CKRM. It is just an interface to kernel/cpu_rc.c

[snip]

> +static int __devinit ckrm_cpu_notify(struct notifier_block *self,
> +				unsigned long action, void *hcpu)
> +{
> +	struct ckrm_class *cls = &ckrm_default_class;
> +	struct ckrm_class *child = NULL;
> +	struct ckrm_cpu *res;
> +	int	cpu = (long) hcpu;
> +
> +	switch (action)	{
> +

[snip]

> +		/* FALL THROUGH */
> +	case CPU_UP_PREPARE:
	     ^^^^^^^^^^^^^^
		This should be done at CPU_ONLINE time (since the new CPU won't
be in the cpu_online_map yet)?

> +		grcd.cpus = cpu_online_map;
> +		grcd.numcpus = cpus_weight(cpu_online_map);
> +		break;



--- kernel/ckrm/ckrm_cpu.c.org	2006-01-31 11:37:46.000000000 +0530
+++ kernel/ckrm/ckrm_cpu.c	2006-01-31 11:39:30.000000000 +0530
@@ -295,7 +295,7 @@ static int __devinit ckrm_cpu_notify(str
 		}
 		ckrm_unlock_hier(cls);
 		/* FALL THROUGH */
-	case CPU_UP_PREPARE:
+	case CPU_ONLINE:
 		grcd.cpus = cpu_online_map;
 		grcd.numcpus = cpus_weight(cpu_online_map);
 		break;


-- 
Regards,
vatsa
