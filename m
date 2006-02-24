Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWBXBpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWBXBpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWBXBpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:45:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:4753 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932478AbWBXBpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:45:35 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Suppress APIC errors on UP x86-64.
Date: Fri, 24 Feb 2006 02:45:29 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060224014228.GB16089@redhat.com>
In-Reply-To: <20060224014228.GB16089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240245.30161.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 02:42, Dave Jones wrote:
> Quite a few UP x86-64 laptops print APIC error 40's repeatedly
> when they run an SMP kernel (And Fedora doesn't ship a UP x86-64 kernel
> any more).  We can suppress this as there's not really anything we
> can do about them.

No we need to fix the APIC errors, not hide them.

-Andi

> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.14/arch/x86_64/kernel/apic.c~	2005-12-07 15:17:33.000000000 -0500
> +++ linux-2.6.14/arch/x86_64/kernel/apic.c	2005-12-07 15:18:16.000000000 -0500
> @@ -1032,7 +1032,8 @@ asmlinkage void smp_error_interrupt(void
>  	   6: Received illegal vector
>  	   7: Illegal register address
>  	*/
> -	printk (KERN_DEBUG "APIC error on CPU%d: %02x(%02x)\n",
> +	if (num_online_cpus() > 1)
> +		printk (KERN_DEBUG "APIC error on CPU%d: %02x(%02x)\n",
>  	        smp_processor_id(), v , v1);
>  	irq_exit();
>  }
> 
