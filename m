Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUHTO2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUHTO2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbUHTO2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:28:09 -0400
Received: from the-village.bc.nu ([81.2.110.252]:56711 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266888AbUHTO2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:28:04 -0400
Subject: Re: banias with different (unusual?) model_name
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: matthias.brill@akamail.com
Cc: jeremy@goop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040820093344.GA2923@akamail.com>
References: <20040820093344.GA2923@akamail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093008335.30968.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 14:25:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 10:33, matthias brill wrote:
> hi jeremy
> 
> i've found a pentium-m banias which reports "Mobile Genuine Intel(R)
> processor       1400MHz" in /proc/cpuinfo.  this (strange?) signature
> prevents speedstep-centrino.c from working properly.

Signatures appear to be BIOS set so that would make sense.


> # diff -up arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.default arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
> --- arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.default	2004-08-19 19:53:59.000000000 +0200
> +++ arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-08-19 20:49:06.000000000 +0200
> @@ -195,7 +195,7 @@ static struct cpufreq_frequency_table ba
>  
>  #define _BANIAS(cpuid, max, name)	\
>  {	.cpu_id		= cpuid,	\
> -	.model_name	= "Intel(R) Pentium(R) M processor " name "MHz", \
> +	.model_name	= "Mobile Genuine Intel(R) processor       " name "MHz", \
>  	.max_freq	= (max)*1000,	\
>  	.op_points	= banias_##max,	\
>  }
> 

You need a new entry "_WEIRDBANIAS" and entries in the table so that
you don't break other people by such a change but yes

> it seems that only the model_name is different for this CPU?


