Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbULFVSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbULFVSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbULFVSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:18:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3047 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261656AbULFVSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:18:33 -0500
Date: Mon, 6 Dec 2004 22:18:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jesse Barnes <jbarnes@sgi.com>, piggin@cyberone.com.au
Subject: Re: [PATCH] isolcpus option broken in 2.6.10-rc2-bk2
Message-ID: <20041206211817.GB10235@elte.hu>
References: <20041206185221.GA23917@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206185221.GA23917@sgi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dimitri Sivanich <sivanich@sgi.com> wrote:

> The isolcpus option is broken in 2.6.10-rc2-bk2.  The domains are no longer
> being properly initialized (which results in a panic at bootup).
> 
> The following patch fixes this.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

only a minor nit:

> +	/* Initialize isolated CPU (physical) domains and groups */
> +	for_each_cpu_mask(i, cpu_isolated_map) {
> +		struct sched_domain *sd = NULL;

there's no need to initialize 'sd' to NULL here.

> +		int group;
> +
> +		sd = &per_cpu(phys_domains, i);
> +		group = cpu_to_phys_group(i);

> +	for_each_cpu_mask(i, cpu_isolated_map) {
> +		struct sched_domain *sd = NULL;

ditto.

> +		int group;
> +
> +		sd = &per_cpu(phys_domains, i);
> +		group = cpu_to_phys_group(i);
> +		*sd = SD_CPU_INIT;

	Ingo
