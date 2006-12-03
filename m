Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760125AbWLCV0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760125AbWLCV0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760128AbWLCV0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:26:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:11924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1760125AbWLCV0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:26:21 -0500
Date: Sun, 3 Dec 2006 13:26:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 7/12] IPMI: add poll delay
Message-Id: <20061203132610.471786ca.akpm@osdl.org>
In-Reply-To: <20061202043520.GC30531@localdomain>
References: <20061202043520.GC30531@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 22:35:20 -0600
Corey Minyard <minyard@acm.org> wrote:

> Make sure to delay a little in the IPMI poll routine so we can pass in
> a timeout time and thus time things out.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>
> 
> Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
> ===================================================================
> --- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
> +++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
> @@ -807,7 +807,12 @@ static void poll(void *send_info)
>  {
>  	struct smi_info *smi_info = send_info;
>  
> -	smi_event_handler(smi_info, 0);
> +	/*
> +	 * Make sure there is some delay in the poll loop so we can
> +	 * drive time forward and timeout things.
> +	 */
> +	udelay(10);
> +	smi_event_handler(smi_info, 10);
>  }

I don't understand what this patch is doing.  It looks fishy.  More
details, please?
