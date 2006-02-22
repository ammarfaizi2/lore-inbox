Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWBVWMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWBVWMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWBVWMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:12:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44203 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751525AbWBVWM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:12:26 -0500
Date: Wed, 22 Feb 2006 23:12:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH] cpufrequency change on AC-Adapter Event
Message-ID: <20060222221200.GA13776@elf.ucw.cz>
References: <20060221213742.GC26413@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060221213742.GC26413@rescue.iwoars.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 21-02-06 22:37:42, Thomas Ogrisegg wrote:
> Problem Description:
> Whenever the status of the AC-Adapter on my laptop changes, the CPU
> frequency automatically changes as well. For example, if the AC adapter
> is online my CPU has the highest frequency (3,06 GHz). When the adapter
> is unplugged, the frequency automatically decreases to 1,6 GHz. However,
> currently the Kernel simply doesn't notice. It looks like the system is
> still running at 3,06 GHz (/proc/cpuinfo and
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq both show that),
> but it doesn't like a simple test program showed.
> 
> My patch solves this problem: Whenever the status of the AC Adapter
> changes, it calls 'cpufreq_reinit' which in turn reinits the CPUfreq
> driver.
> 
> This, of course, only works if the ACPI AC driver is compiled in.
> 
> Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>

> diff -uNr -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/acpi/ac.c linux-2.6.15.4/drivers/acpi/ac.c
> --- linux-2.6.15/drivers/acpi/ac.c	2006-01-03 04:21:10.000000000 +0100
> +++ linux-2.6.15.4/drivers/acpi/ac.c	2006-02-19 17:50:20.000000000 +0100
> @@ -29,6 +29,7 @@
>  #include <linux/types.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> +#include <linux/cpufreq.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> @@ -213,6 +214,8 @@
>  		break;
>  	}
>  
> +	cpufreq_reinit();
> +
>  	return_VOID;
>  }
>  

Perhaps we need to call some notifier chain here? I think not only
cpufreq is going to be interested...
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
