Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbUKGQ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUKGQ4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUKGQ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:56:30 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:8200 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id S261403AbUKGQ40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:56:26 -0500
Date: Sun, 7 Nov 2004 16:56:23 +0000
From: John Levon <levon@movementarian.org>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: [PATCH][OPROFILE] disable preempt when calling smp_processor_id()
Message-ID: <20041107165623.GA36328@compsoc.man.ac.uk>
References: <20041105163221.J14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105163221.J14339@build.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CQqL3-0000MD-Al*xC5Fqh0zgtA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 04:32:21PM -0800, Chris Wright wrote:

> smp_processor_id() is called w/out preempt disabled.  Use
> get_cpu()/put_cpu() instead.  Should this be put_cpu_no_resched()?

No, the patch below looks fine

regards
john

> Signed-off-by: Chris Wright <chrisw@osdl.org>
> 
> --- linux-2.6.10-rc1-mm3-smp_processor_id/drivers/oprofile/buffer_sync.c~orig	2004-11-05 15:21:21.551984200 -0800
> +++ linux-2.6.10-rc1-mm3-smp_processor_id/drivers/oprofile/buffer_sync.c	2004-11-05 15:23:29.000000000 -0800
> @@ -62,7 +62,8 @@
>  	/* To avoid latency problems, we only process the current CPU,
>  	 * hoping that most samples for the task are on this CPU
>  	 */
> -	sync_buffer(smp_processor_id());
> +	sync_buffer(get_cpu());
> +	put_cpu();
>    	return 0;
>  }
>  
> @@ -86,7 +87,8 @@
>  		/* To avoid latency problems, we only process the current CPU,
>  		 * hoping that most samples for the task are on this CPU
>  		 */
> -		sync_buffer(smp_processor_id());
> +		sync_buffer(get_cpu());
> +		put_cpu();
>  		return 0;
>  	}
>  
