Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268011AbTBMKIU>; Thu, 13 Feb 2003 05:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268014AbTBMKIT>; Thu, 13 Feb 2003 05:08:19 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:18441 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268011AbTBMKIT>; Thu, 13 Feb 2003 05:08:19 -0500
Date: Thu, 13 Feb 2003 11:17:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dominik Brodowski <linux@brodo.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <davej@suse.de>,
       <linux-kernel@vger.kernel.org>, <cpufreq@www.linux.org.uk>
Subject: Re: [PATCH] cpufreq: move frequency table helpers to extra module
In-Reply-To: <20030213091131.GA8909@brodo.de>
Message-ID: <Pine.LNX.4.44.0302131114100.32518-100000@serv>
References: <20030213091131.GA8909@brodo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Feb 2003, Dominik Brodowski wrote:

> +config CPU_FREQ_TABLE
> +       tristate "CPU frequency table helpers"
> +       depends on CPU_FREQ
> +       default y
> +       help
> +         Many CPUFreq drivers use these helpers, so only say N here if
> +	 the CPUFreq driver of your choice doesn't need these helpers.
> +
> +	 If in doubt, say Y.
> +
>  config X86_ACPI_CPUFREQ
>  	tristate "ACPI Processor P-States driver"
> -	depends on CPU_FREQ && ACPI_PROCESSOR
> +	depends on CPU_FREQ && ACPI_PROCESSOR && CPU_FREQ_TABLE
>  	help
>  	  This driver adds a CPUFreq driver which utilizes the ACPI
>  	  Processor Performance States.

If CPU_FREQ_TABLE itself depends on CPU_FREQ, then X86_ACPI_CPUFREQ 
automatically depends on CPU_FREQ too, so you can remove CPU_FREQ from the 
dependency list.
You can also put X86_ACPI_CPUFREQ and all following options, which depend 
on CPU_FREQ_TABLE, within an "if CPU_FREQ_TABLE" ... "endif" block.

bye, Roman

