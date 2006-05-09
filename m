Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWEJUAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWEJUAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWEJUAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:00:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21007 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751505AbWEJUAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:00:39 -0400
Date: Tue, 9 May 2006 07:21:40 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling on Xen.
Message-ID: <20060509072139.GB4150@ucw.cz>
References: <20060509084945.373541000@sous-sol.org> <20060509085155.177937000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085155.177937000@sous-sol.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
> +{
> +#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
> +	C(0); C(1); C(2);
> +#undef C
> +}

Why not use for loop here? gcc should be able to optimize it...

> +#define load_TR_desc()

do {} while (0)...

> +#define load_gdt(dtr) do {						\
...
> +} while (0)

So you know the trick :-)

> +#define load_idt(dtr) HYPERVISOR_set_trap_table(xen_trap_table)
> +#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
> +#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))

__volatile (not __volatile__?). could you just use 'asm volatile'
without __s instead?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
