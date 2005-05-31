Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVEaXmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVEaXmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVEaXmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:42:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:44216 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261199AbVEaXmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:42:00 -0400
Subject: Re: [PATCH] ppc64: actually call prom_send_capabilities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200505311612.j4VGCWC8005159@hera.kernel.org>
References: <200505311612.j4VGCWC8005159@hera.kernel.org>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 09:41:46 +1000
Message-Id: <1117582907.5826.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Index: arch/ppc64/kernel/prom_init.c
> ===================================================================
> --- 3ac19ebb77c3cd8a1df31b7170c6eaf9e1afb1a4/arch/ppc64/kernel/prom_init.c  (mode:100644 sha1:6f79b7b9b445e8669411e34b48c1ea8ce5135965)
> +++ 11f504429d5e6708259f376b76e96cafd3bf9215/arch/ppc64/kernel/prom_init.c  (mode:100644 sha1:bc53967a86436d6b3f4a4f324273e01fdab934b3)
> @@ -1881,6 +1881,12 @@ unsigned long __init prom_init(unsigned 
>  		     &getprop_rval, sizeof(getprop_rval));
>  
>  	/*
> +	 * On pSeries, inform the firmware about our capabilities
> +	 */
> +	if (RELOC(of_platform) & PLATFORM_PSERIES)
> +		prom_send_capabilities();
> +
> +	/*
>  	 * On pSeries, copy the CPU hold code
>  	 */
>         	if (RELOC(of_platform) & PLATFORM_PSERIES)
> -

/* Platforms supported by PPC64 */
#define PLATFORM_PSERIES      0x0100
#define PLATFORM_PSERIES_LPAR 0x0101
#define PLATFORM_ISERIES_LPAR 0x0201
#define PLATFORM_LPAR         0x0001
#define PLATFORM_POWERMAC     0x0400
#define PLATFORM_MAPLE        0x0500

Hrm... this will trigger on Maple too... Should I change Maple
definition ? That would break kexec of maple from existing to newer
kernels though.



