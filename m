Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVJCSeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVJCSeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVJCSeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:34:04 -0400
Received: from [81.2.110.250] ([81.2.110.250]:42727 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932316AbVJCSeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:34:02 -0400
Subject: Re: [PATCH 1/7] AMD Geode GX/LX support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051003174738.GC29264@cosmic.amd.com>
References: <20051003174738.GC29264@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 20:01:49 +0100
Message-Id: <1128366109.26992.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 11:47 -0600, Jordan Crouse wrote:
> +	  - "Geode GX" for AMD Geode GX processors
>  	  - "Crusoe" for the Transmeta Crusoe series.
>  	  - "Efficeon" for the Transmeta Efficeon series.
>  	  - "Winchip-C6" for original IDT Winchip.

Whats wrong with the existing MGEODEGX1 define (other than it doesn't
say AMD)



>  config X86_USE_3DNOW
>  	bool
> -	depends on MCYRIXIII || MK7
> +	depends on MCYRIXIII || MK7 || MGEODE_GX
>  	default y

Is this correct - last time I benchmarked it the older GEODE was better
off using non MMX copies ?

>  
>  config X86_OOSTORE
> @@ -532,7 +539,7 @@ source "kernel/Kconfig.preempt"
>  
>  config X86_UP_APIC
>  	bool "Local APIC support on uniprocessors"
> -	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
> +	depends on !SMP && !(X86_VISWS || X86_VOYAGER || MGEODE_GX)
>  	help

This is wrong - a GEODE kernel can support APIC even if the Geode itself
doesn't. Remeber it is *optimised for at least... * not "xyz only"

> +	depends on !MGEODE_GX
>  	help
>  	  Select this if you have a 32-bit processor and more than 4
>  	  gigabytes of physical RAM.

Ditto

> +                           clear_bit(0*32+16, &c->x86_capability);
> +                           clear_bit(0*32+24, &c->x86_capability);
> +
> +                           since I don't think the kernel supports
> +                           FPU-CMOV or Cyrix MMX.  Unsure tho.

Kernel space enables Cyrix MMX on the processors it knows about that it
can. Some userspace will use the extensions if present. The Cyrix init
code you unplugged it from knows how to do this which your unfinished
patch doesn't.



