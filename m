Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261846AbSJEAGP>; Fri, 4 Oct 2002 20:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSJEAGP>; Fri, 4 Oct 2002 20:06:15 -0400
Received: from zero.aec.at ([193.170.194.10]:1798 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261846AbSJEAGO>;
	Fri, 4 Oct 2002 20:06:14 -0400
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40: lkcd (4/9): additional kernel symbols
References: <200210042303.g94N3eS10028@nakedeye.aparity.com>
From: Andi Kleen <ak@muc.de>
Date: 05 Oct 2002 02:11:40 +0200
In-Reply-To: <200210042303.g94N3eS10028@nakedeye.aparity.com>
Message-ID: <m3znttg2wz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matt D. Robinson" <yakker@aparity.com> writes:

> diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/kernel/i386_ksyms.c linux-2.5.40+lkcd/arch/i386/kernel/i386_ksyms.c
> --- linux-2.5.40/arch/i386/kernel/i386_ksyms.c	Tue Oct  1 12:36:59 2002
> +#if defined(CONFIG_X86) || defined(CONFIG_ALPHA)
> +EXPORT_SYMBOL(page_is_ram);
> +#endif

This ifdef in i386_ksyms.c doesn't make much sense...

> +#ifdef CONFIG_SMP
> +extern irq_desc_t irq_desc[];
> +extern unsigned long irq_affinity[];
> +EXPORT_SYMBOL(irq_affinity);
> +EXPORT_SYMBOL(irq_desc);
> +extern void dump_send_ipi(void);
> +EXPORT_SYMBOL(dump_send_ipi);
> +extern int (*dump_ipi_function_ptr)(struct pt_regs *);
> +EXPORT_SYMBOL(dump_ipi_function_ptr);
> +extern void (*dump_trace_ptr)(struct pt_regs *);
> +EXPORT_SYMBOL(dump_trace_ptr);
> +extern void show_this_cpu_state(int, struct pt_regs *, struct task_struct *);
> +EXPORT_SYMBOL(show_this_cpu_state);

Before adding all these ugly declarations I would just declare the file where
whey are exported from as 'x-obj' and put them directly to where the 
functions live.


-Andi
