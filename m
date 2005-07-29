Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVG2JDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVG2JDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVG2JDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:03:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46347 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262540AbVG2JDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:03:09 -0400
Date: Fri, 29 Jul 2005 10:02:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050729100257.A10345@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <20050729070447.GA3032@elte.hu> <200507290722.j6T7Mig07477@unix-os.sc.intel.com> <20050729082826.GA6144@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050729082826.GA6144@elte.hu>; from mingo@elte.hu on Fri, Jul 29, 2005 at 10:28:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 10:28:26AM +0200, Ingo Molnar wrote:
> @@ -2872,10 +2878,10 @@ go_idle:
>  	/*
>  	 * Prefetch (at least) a cacheline below the current
>  	 * kernel stack (in expectation of any new task touching
> -	 * the stack at least minimally), and a cacheline above
> -	 * the stack:
> +	 * the stack at least minimally), and at least a cacheline
> +	 * above the stack:
>  	 */
> -	prefetch_range(kernel_stack(next) - MIN_KERNEL_STACK_FOOTPRINT,
> +	prefetch_range(kernel_stack(next) - L1_CACHE_BYTES,
>  		       MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);

This needs to ensure that we don't prefetch outside the page of the
kernel stack - otherwise we risk weird problems on architectures
which support prefetching but not DMA cache coherency.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
