Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269473AbSIRXCy>; Wed, 18 Sep 2002 19:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269482AbSIRXCy>; Wed, 18 Sep 2002 19:02:54 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:12552 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S269473AbSIRXCx>; Wed, 18 Sep 2002 19:02:53 -0400
Date: Thu, 19 Sep 2002 01:07:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 3/7
In-Reply-To: <20020918021714.E9A292C13A@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209190042370.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 18 Sep 2002, Rusty Russell wrote:

> +/* Stopping interrupts faster than atomics on many archs (and more
> +   easily optimized if they're not) */
> +static inline void bigref_inc(struct bigref *ref)
> +{
> +	unsigned long flags;
> +	struct bigref_percpu *cpu;
> +
> +	local_irq_save(flags);
> +	cpu = &ref->ref[smp_processor_id()];
> +	if (likely(!cpu->slow_mode))
> +		cpu->counter++;

Did you benchmark this? On most UP machines an inc/dec should be cheaper
than irq enable/disable.

bye, Roman

