Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWIVGgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWIVGgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWIVGgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:36:24 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:48860 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1750787AbWIVGgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:36:23 -0400
Date: Fri, 22 Sep 2006 08:36:21 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: john cooper <john.cooper@third-harmonic.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rt1
Message-ID: <20060922063621.GA1283@xi.wantstofly.org>
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <45134829.9040708@third-harmonic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45134829.9040708@third-harmonic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 10:19:21PM -0400, john cooper wrote:

> >ok, i've uploaded -rt3:
> 
> Attached is a patch which fixes a build problem
> for ARM pxa270, and general ARM boot issue when
> LATENCY_TRACE is configured.
> 
> -john
> 
> -- 
> john.cooper@third-harmonic.com

>  include/asm-arm/arch-pxa/timex.h |    2 ++
>  kernel/latency_trace.c           |    2 ++
>  2 files changed, 4 insertions(+)
> =================================================================
> --- ./kernel/latency_trace.c.ORG	2006-09-20 21:10:15.000000000 -0400
> +++ ./kernel/latency_trace.c	2006-09-21 21:28:49.000000000 -0400
> @@ -150,6 +150,8 @@ enum trace_flag_type
>   */
>  #if !defined(CONFIG_DEBUG_PAGEALLOC) && !defined(CONFIG_SMP) && !defined(CONFIG_ARM)
>  # define MAX_TRACE (unsigned long)(8192*16-1)
> +#elif defined(CONFIG_ARM)      /* 4MB kernel image size limitation */
> +# define MAX_TRACE (unsigned long)(128*2-1)

This patch (queued for Linus) lifts that 4MB limitation:

	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3809/2

(I ran into the limit when enabling lockdep on ARM.)


cheers,
Lennert
