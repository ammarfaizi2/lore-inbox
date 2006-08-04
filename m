Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWHDHfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHDHfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWHDHfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:35:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932393AbWHDHfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:35:45 -0400
Date: Fri, 4 Aug 2006 00:35:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ RFC, PATCH 1/5 ] CPU controller - base changes
Message-Id: <20060804003528.da3722b3.akpm@osdl.org>
In-Reply-To: <20060804050932.GE27194@in.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
	<20060804050932.GE27194@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 10:39:32 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> +/* runqueue used for every task-group */
> +struct task_grp_rq {
> +	struct prio_array arrays[2];
> +	struct prio_array *active, *expired, *rq_array;
> +	unsigned long expired_timestamp;
> +	unsigned int ticks;
> +	int prio;	/* Priority of the task-group */
> +	struct list_head list;
> +};
> +
> +static DEFINE_PER_CPU(struct task_grp_rq, init_tg_rq);

That's another 4.5kbytes/cpu of our precious per-cpu memory.  Is it feasible to make this
dependent upon CONFIG_CPUMETER?
