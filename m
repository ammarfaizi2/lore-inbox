Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWEHVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWEHVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWEHVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:24:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751103AbWEHVYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:24:06 -0400
Date: Mon, 8 May 2006 14:26:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 3/8] cpu delay collection via schedstats
Message-Id: <20060508142640.675665c7.akpm@osdl.org>
In-Reply-To: <20060502061505.GN13962@in.ibm.com>
References: <20060502061505.GN13962@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
> +/*
> + * Expects runqueue lock to be held for atomicity of update
> + */
> +static inline void rq_sched_info_arrive(struct runqueue *rq,
> +						unsigned long diff)
> +{
> +	if (rq) {
> +		rq->rq_sched_info.run_delay += diff;
> +		rq->rq_sched_info.pcnt++;
> +	}
> +}
> +
> +/*
> + * Expects runqueue lock to be held for atomicity of update
> + */
> +static inline void rq_sched_info_depart(struct runqueue *rq,
> +						unsigned long diff)
> +{
> +	if (rq)
> +		rq->rq_sched_info.cpu_time += diff;
> +}

The kernel has many different units of time - jiffies, cpu ticks, ns, us,
ms, etc.  So the reader of these functions doesn't have a clue what "diff"
is.

A good way to remove all doubt in all cases is to include the units in the
variable's name.  Something like delta_jiffies, perhaps.

