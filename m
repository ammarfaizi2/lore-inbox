Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264315AbUEMRVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUEMRVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUEMRVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:21:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42180 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264315AbUEMRVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:21:17 -0400
Date: Thu, 13 May 2004 19:21:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6
Message-ID: <20040513172116.GD4506@atrey.karlin.mff.cuni.cz>
References: <20040512235623.GA9234@atomide.com> <20040513162643.GA4506@atrey.karlin.mff.cuni.cz> <20040513171921.GB28678@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513171921.GB28678@atomide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Following is the updated patch to make the powernow-k8 driver work on 
> > > machines with buggy BIOS, such as emachines m6805.
> > > 
> > > The patch overrides the PST table only if check_pst_table() fails.
> > > 
> > > The minimum value for the override is 800MHz, which is the lowest value 
> > > on all x86_64 systems AFAIK. The max value is the current running value.
> > > 
> > > This patch should be safe to apply, even if Pavel's ACPI table check is
> > > added to the driver. Or does anybody see a problem with it?
> > 
> > Well, there may be problems with that.
> 
> That works good now, see my recent posting to the thread on the cpufreq list
> for more details. I had ACPI processor as module, and that made the
> powernow-k8 ACPI detection to fail. I fixed it with the following little
> patch, attaching it here too for reference.

This patch is okay if you insert modules in right order, but not if
you attempt to insert cpufreq before acpi, right?

Please do not make that go in like it is.
								Pavel


> diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> --- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Thu May 13 09:58:24 2004
> +++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Thu May 13 09:58:24 2004
> @@ -32,7 +32,7 @@
>  #include <asm/io.h>
>  #include <asm/delay.h>
>  
> -#ifdef CONFIG_ACPI_PROCESSOR
> +#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
>  #include <linux/acpi.h>
>  #include <acpi/processor.h>
>  #endif

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
