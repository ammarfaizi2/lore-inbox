Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265511AbSJXPn6>; Thu, 24 Oct 2002 11:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265512AbSJXPn5>; Thu, 24 Oct 2002 11:43:57 -0400
Received: from zero.aec.at ([193.170.194.10]:19973 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265511AbSJXPn5>;
	Thu, 24 Oct 2002 11:43:57 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 performance counters driver 3.0-pre2 for 2.5.44: [2/4] x86 support
References: <200210241500.RAA03585@kim.it.uu.se>
From: Andi Kleen <ak@muc.de>
Date: 24 Oct 2002 17:49:55 +0200
In-Reply-To: <200210241500.RAA03585@kim.it.uu.se>
Message-ID: <m3wuo7omzg.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> +struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
> +	union {
> +		unsigned int p5_cesr;
> +		unsigned int id;	/* cache owner id */
> +	} k1;
> +	struct {
> +		/* NOTE: these caches have physical indices, not virtual */
> +		unsigned int evntsel[18];
> +		unsigned int escr[0x3E2-0x3A0];
> +		unsigned int pebs_enable;
> +		unsigned int pebs_matrix_vert;
> +	} control;
> +} __attribute__((__aligned__(SMP_CACHE_BYTES)));
> +static struct per_cpu_cache per_cpu_cache[NR_CPUS] __cacheline_aligned;

This should use per cpu data (asm/percpu.h) to save memory.

-Andi
