Return-Path: <linux-kernel-owner+w=401wt.eu-S932248AbXAIVC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbXAIVC7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXAIVC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:02:59 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43871 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932248AbXAIVC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:02:58 -0500
Date: Tue, 9 Jan 2007 13:01:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] local_t : Documentation
Message-Id: <20070109130110.8934c29f.akpm@osdl.org>
In-Reply-To: <20070109031446.GA29426@Krystal>
References: <20061221001545.GP28643@Krystal>
	<20061223093358.GF3960@ucw.cz>
	<20070109031446.GA29426@Krystal>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 22:14:46 -0500
Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> +* How to use local atomic operations
> +
> +#include <linux/percpu.h>
> +#include <asm/local.h>
> +
> +static DEFINE_PER_CPU(local_t, counters) = LOCAL_INIT(0);
> +
> +
> +* Counting
> +
> +In preemptible context, use get_cpu_var() and put_cpu_var() around local atomic
> +operations : it makes sure that preemption is disabled around write access to
> +the per cpu variable. For instance :
> +
> +	local_inc(&get_cpu_var(counters));
> +	put_cpu_var(counters);

Confused.  The whole point behind local_t is that we can do
atomic-wrt-interrupts inc and dec on them.

Consequently, as atomic-wrt-interrupts means atomic-wrt-preemption, there
is no need to do a preempt_disable() around local_inc() and local_dec().

