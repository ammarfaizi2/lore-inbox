Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWEMMa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWEMMa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWEMMa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:30:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932412AbWEMMa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:30:56 -0400
Date: Sat, 13 May 2006 05:27:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 24/35] Add support for Xen event channels.
Message-Id: <20060513052750.41cfcb9d.akpm@osdl.org>
In-Reply-To: <20060509085157.491027000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085157.491027000@sous-sol.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2006 00:00:24 -0700
Chris Wright <chrisw@sous-sol.org> wrote:

> +void __init init_IRQ(void)
> +{
> +	int i;
> +	int cpu;
> +
> +	irq_ctx_init(0);
> +
> +	spin_lock_init(&irq_mapping_update_lock);

May as well initialise this at compile time.

> +	init_evtchn_cpu_bindings();
> +
> +	/* No VIRQ or IPI bindings. */
> +	for (cpu = 0; cpu < NR_CPUS; cpu++) {

Using NR_CPUS is a little...  old-fashioned.  I'd suggest a sweep through
all the Xen code, look for places where it should be using
for_each_foo_cpu().



