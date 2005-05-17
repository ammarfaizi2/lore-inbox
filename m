Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVEQWae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVEQWae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEQW1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:27:39 -0400
Received: from one.firstfloor.org ([213.235.205.2]:2436 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261748AbVEQWXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:23:39 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.12-rc4-mm2] perfctr: x86 update with K8 multicore
 fixes, take 2
References: <200505172044.j4HKiMTY026776@alkaid.it.uu.se>
From: Andi Kleen <ak@muc.de>
Date: Wed, 18 May 2005 00:23:37 +0200
In-Reply-To: <200505172044.j4HKiMTY026776@alkaid.it.uu.se> (Mikael
 Pettersson's message of "Tue, 17 May 2005 22:44:22 +0200 (MEST)")
Message-ID: <m164xh7aqe.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> +#ifdef CONFIG_SMP
> +static void __init k8_multicore_init(void)
> +{
> +	cpumask_t non0cores;
> +	int i;
> +
> +	cpus_clear(non0cores);
> +	for(i = 0; i < NR_CPUS; ++i) {
> +		cpumask_t cores = cpu_core_map[i];
> +		int core0 = first_cpu(cores);
> +		if (core0 >= NR_CPUS)
> +			continue;
> +		cpu_clear(core0, cores);
> +		cpus_or(non0cores, non0cores, cores);
> +	}
> +	if (cpus_empty(non0cores))
> +		return;
> +	k8_is_multicore = 1;

That is still far too complicated. Just use current_cpu_data->x86_num_cores > 1 
That is simple enough that you don't need the ugly variable.

-Andi
