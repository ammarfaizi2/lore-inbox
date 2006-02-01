Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWBASbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWBASbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWBASbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:31:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1953 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422864AbWBASbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:31:21 -0500
Date: Wed, 1 Feb 2006 10:31:14 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl initialization of zone_reclaim_mode
In-Reply-To: <20060201095549.6fca4944@dxpl.pdx.osdl.net>
Message-ID: <Pine.LNX.4.62.0602011030230.17731@schroedinger.engr.sgi.com>
References: <20060201095549.6fca4944@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A cleanup patch has been in Andrews tree for awhile and I hope that Linus 
applies it today. This is the ., hmm .... 4th time the patch was posted.

On Wed, 1 Feb 2006, Stephen Hemminger wrote:

> Fix warning about initialization of sysctl table in current 2.6.16-rc1
> git tree. It could cause a nasty if anyone wrote to it.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> 
> --- linux-2.6.orig/kernel/sysctl.c
> +++ linux-2.6/kernel/sysctl.c
> @@ -878,7 +878,8 @@ static ctl_table vm_table[] = {
>  		.maxlen		= sizeof(zone_reclaim_mode),
>  		.mode		= 0644,
>  		.proc_handler	= &proc_dointvec,
> -		.strategy	= &zero,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &zero,
>  	},
>  #endif
>  	{ .ctl_name = 0 }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
