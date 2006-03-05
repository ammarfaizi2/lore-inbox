Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752155AbWCEIrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbWCEIrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 03:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbWCEIrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 03:47:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752122AbWCEIrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 03:47:08 -0500
Date: Sun, 5 Mar 2006 00:45:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Message-Id: <20060305004534.1d94b3cf.akpm@osdl.org>
In-Reply-To: <20060303214236.11908.98881.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<20060303214236.11908.98881.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> +#ifdef CONFIG_NET_DMA
>  +	tp->ucopy.dma_chan = NULL;
>  +	if ((len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) && !sysctl_tcp_low_latency && __get_cpu_var(softnet_data.net_dma))
>  +		dma_lock_iovec_pages(msg->msg_iov, len, &tp->ucopy.locked_list);
>  +#endif

The __get_cpu_var() here will run smp_processor_id() from preemptible
context.  You'll get a big warning if the correct debug options are set.

The reason for this is that preemption could cause this code to hop between
CPUs.

Please always test code with all debug options enabled and with full kernel
preemption.

