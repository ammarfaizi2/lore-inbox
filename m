Return-Path: <linux-kernel-owner+w=401wt.eu-S1750753AbWLOIfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWLOIfO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWLOIfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:35:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33798 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbWLOIfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:35:13 -0500
Date: Fri, 15 Dec 2006 09:31:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: akpm@osdl.org
Cc: mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: + schedule_on_each_cpu-use-preempt_disable.patch added to -mm tree
Message-ID: <20061215083112.GB10687@elte.hu>
References: <200612150823.kBF8NV2u011171@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612150823.kBF8NV2u011171@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* akpm@osdl.org <akpm@osdl.org> wrote:

> -	mutex_lock(&workqueue_mutex);
> +	preempt_disable();		/* CPU hotplug */
>  	for_each_online_cpu(cpu) {
>  		INIT_WORK(per_cpu_ptr(works, cpu), func);
>  		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
>  				per_cpu_ptr(works, cpu));
>  	}
> -	mutex_unlock(&workqueue_mutex);
> +	preempt_enable();

Why not cpu_hotplug_lock()?

	Ingo
