Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbUKXSN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbUKXSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUKXSL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 13:11:56 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:39579 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S262809AbUKXSKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 13:10:15 -0500
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message
	when suspending
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@linuxmail.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101294838.5805.245.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294838.5805.245.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101312041.8940.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 24 Nov 2004 08:00:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 04:57, Nigel Cunningham wrote:
> While eating memory, we will potentially trigger this a lot. We
> therefore disable the message when suspending.
> 
> diff -ruN 503-disable-page-alloc-warnings-while-suspending-old/mm/page_alloc.c 503-disable-page-alloc-warnings-while-suspending-new/mm/page_alloc.c
> --- 503-disable-page-alloc-warnings-while-suspending-old/mm/page_alloc.c	2004-11-06 09:24:37.231308424 +1100
> +++ 503-disable-page-alloc-warnings-while-suspending-new/mm/page_alloc.c	2004-11-06 09:24:40.844759096 +1100
> @@ -725,7 +725,10 @@
>  	}
>  
>  nopage:
> -	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
> +	if ((!(gfp_mask & __GFP_NOWARN)) && 
> +		(!test_suspend_state(SUSPEND_RUNNING)) &&
> +		printk_ratelimit()) {
> +
>  		printk(KERN_WARNING "%s: page allocation failure."
>  			" order:%d, mode:0x%x\n",
>  			p->comm, order, gfp_mask);

Following Documentation/SubmittingPatches, please submit patches made
with "diff -urp":

       -p  --show-c-function
              Show which C function each change is in.

Otherwise, it's a lot harder to figure out what you're modifying.

-- Dave

