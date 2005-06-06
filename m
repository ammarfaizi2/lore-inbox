Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVFFWNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVFFWNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVFFWNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:13:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:48278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261740AbVFFWNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:13:00 -0400
Date: Mon, 6 Jun 2005 15:13:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk, vatsa@in.ibm.com,
       discuss@x86-64.org, rusty@rustycorp.com.au, ashok.raj@intel.com,
       ak@muc.de
Subject: Re: [patch 4/5] try2: x86_64: Dont use broadcast shortcut to make
 it cpu hotplug safe.
Message-Id: <20050606151332.3e457433.akpm@osdl.org>
In-Reply-To: <20050606192113.307745000@araj-em64t>
References: <20050606191433.104273000@araj-em64t>
	<20050606192113.307745000@araj-em64t>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> +static void flat_send_IPI_allbutself(int vector)
> +{
> +	cpumask_t mask;
> +	/*
> +	 * if there are no other CPUs in the system then
> +	 * we get an APIC send error if we try to broadcast.
> +	 * thus we have to avoid sending IPIs in this case.
> +	 */
> +	get_cpu();
> +	mask = cpu_online_map;
> +	cpu_clear(smp_processor_id(), mask);
> +
> +	if (cpus_weight(mask) >= 1)
> +		flat_send_IPI_mask(mask, vector);
> +
> +	put_cpu();
> +}

It would be more idiomatic to use preempt_disable() and preempt_enable() in
place of get_cpu() and put_cpu() here.

