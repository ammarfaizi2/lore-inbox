Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVCIHs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVCIHs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 02:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVCIHs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 02:48:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:10213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262222AbVCIHst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 02:48:49 -0500
Date: Tue, 8 Mar 2005 23:48:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       cpufreq@ZenII.linux.org.uk
Subject: Re: 2.6.11 cpufreq: Device or resource busy
Message-Id: <20050308234816.245f35b4.akpm@osdl.org>
In-Reply-To: <20050308222516.GA20370@carfax.org.uk>
References: <20050308222516.GA20370@carfax.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugo Mills <hugo-lkml@carfax.org.uk> wrote:
>
>    I've just upgraded my laptop (ASUS M3000 -- see below) from 2.6.10
>  to 2.6.11. It now seems to be unable to load the acpi_cpufreq module:
> 
>  hrm@joshua:hrm $ sudo modprobe acpi-cpufreq
>  FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.11-plain/kernel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.ko): Device or resource busy

Presumably there's already a cpufreq driver regisered when you try to load
the acpi_cpufreq module.

If you can work out how to enable cpufreq debugging, then do so.  Or apply
the below patch, see what driver is being registered.

--- 25/drivers/cpufreq/cpufreq.c~a	2005-03-08 23:45:21.000000000 -0800
+++ 25-akpm/drivers/cpufreq/cpufreq.c	2005-03-08 23:45:28.000000000 -0800
@@ -1351,7 +1351,7 @@ int cpufreq_register_driver(struct cpufr
 	    ((!driver_data->setpolicy) && (!driver_data->target)))
 		return -EINVAL;
 
-	dprintk("trying to register driver %s\n", driver_data->name);
+	printk("trying to register driver %s\n", driver_data->name);
 
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
_

