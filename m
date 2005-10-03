Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVJCSCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVJCSCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVJCSCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:02:38 -0400
Received: from fsmlabs.com ([168.103.115.128]:52407 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932206AbVJCSCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:02:38 -0400
Date: Mon, 3 Oct 2005 11:08:17 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] AMD Geode GX/LX support
In-Reply-To: <20051003174738.GC29264@cosmic.amd.com>
Message-ID: <Pine.LNX.4.61.0510031104210.1684@montezuma.fsmlabs.com>
References: <20051003174738.GC29264@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jordan,

On Mon, 3 Oct 2005, Jordan Crouse wrote:

> @@ -532,7 +539,7 @@ source "kernel/Kconfig.preempt"
>  
>  config X86_UP_APIC
>  	bool "Local APIC support on uniprocessors"
> -	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
> +	depends on !SMP && !(X86_VISWS || X86_VOYAGER || MGEODE_GX)

Can't the Geode boot with a local APIC enabled kernel, albeit without 
using it? If it doesn't halt during boot then you don't need this change.

> @@ -749,6 +756,7 @@ config HIGHMEM4G
>  
>  config HIGHMEM64G
>  	bool "64GB"
> +	depends on !MGEODE_GX

As above.

> +static void __init init_nsc(struct cpuinfo_x86 *c)
> +{
> +
> +
> +	/* Handle the National Semiconductor models with non-Cyrix init */
> +	if ( (c->x86 == 5) && (c->x86_model >= 4 && c->x86_model <= 5)) {
> +		/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
> +		   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
> +		clear_bit(0*32+31, c->x86_capability);

Please create a define.
