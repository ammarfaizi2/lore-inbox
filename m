Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWBXBpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWBXBpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWBXBpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:45:36 -0500
Received: from ns1.suse.de ([195.135.220.2]:962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932377AbWBXBpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:45:35 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Make SMP x86-64 kernels boot on more UP systems.
Date: Fri, 24 Feb 2006 02:45:00 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060224014112.GA16089@redhat.com>
In-Reply-To: <20060224014112.GA16089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240245.01417.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 02:41, Dave Jones wrote:
> Should someone boot an SMP kernel on UP hardware on some systems,
> strange things happen, such as..

Boot logs?
 
> SMP: Allowing 0 CPUs.
> 
> We blow up shortly afterwards.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.15.noarch/arch/x86_64/kernel/smpboot.c~	2006-02-20 21:59:56.000000000 -0500
> +++ linux-2.6.15.noarch/arch/x86_64/kernel/smpboot.c	2006-02-20 22:01:57.000000000 -0500
> @@ -975,6 +975,11 @@ __init void prefill_possible_map(void)
>  	if (possible > NR_CPUS) 
>  		possible = NR_CPUS;
>  
> +	if (possible == 0) {	/* Could be SMP kernel on UP hw with broken BIOS */
> +		possible = 1;
> +		printk (KERN_DEBUG "BIOS never enumerated boot CPU, fixing.\n");
> +	}

It's the wrong place to handle this. Better would be in mpparse.c

-Andi
