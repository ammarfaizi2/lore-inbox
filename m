Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263193AbUDUP1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUDUP1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUDUP1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:27:34 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:6152 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263193AbUDUP1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 11:27:30 -0400
Date: Wed, 21 Apr 2004 16:27:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/9): oprofile for s390.
Message-ID: <20040421162725.A7211@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040421144829.GH2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040421144829.GH2951@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Apr 21, 2004 at 04:48:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 04:48:29PM +0200, Martin Schwidefsky wrote:
> +++ linux-2.6-s390/arch/s390/kernel/irq.c	Wed Apr 21 16:29:40 2004
> @@ -0,0 +1,72 @@
> +/*
> + * arch/s390/kernel/irq.c
> + *
> + * Contains functions related to oprofile taken from patch
> + * linux-2.4.20-s390-oprofile.patch.
> + *
> + * Copyrith (C) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
> + * Author(s): Thomas Spatzier (tspat@de.ibm.com)
> + *
> + */

Don't you think the name for this file is completly wrong?  And a patch
name in the comment about this file doesn't exactly help either..

> +#include <linux/smp_lock.h>

What do you need this one for?

> +#include <linux/init.h>

doesn't seem to be need either.

> +#include <asm/system.h>

dito?

> +#include <asm/io.h>

dito.  I wonder why this actually exists on s390..

> +#include <asm/pgtable.h>
> +#include <asm/delay.h>

dito.

> +static inline void s390_do_profile(struct pt_regs * regs)
> +{
> +	unsigned long eip;
> +	extern unsigned long prof_cpu_mask;
> +
> +	profile_hook(regs);
> +
> +	if (user_mode(regs))
> +		return;
> +
> +	if (!prof_buffer)
> +		return;
> +
> +	eip = instruction_pointer(regs);
> +
> +	/*
> +	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
> +	 * (default is all CPUs.)
> +	 */
> +	if (!((1<<smp_processor_id()) & prof_cpu_mask))

shouldn't this be cpumask_t arithmetic?

> +//extern int irq_init(struct oprofile_operations** ops);

why this?

