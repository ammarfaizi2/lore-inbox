Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbSJEBL3>; Fri, 4 Oct 2002 21:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbSJEBL3>; Fri, 4 Oct 2002 21:11:29 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:40779 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261813AbSJEBL2>; Fri, 4 Oct 2002 21:11:28 -0400
Date: Fri, 4 Oct 2002 18:25:24 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40: lkcd (4/9): additional kernel symbols
In-Reply-To: <m3znttg2wz.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0210041822120.10168-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Oct 2002, Andi Kleen wrote:
|>"Matt D. Robinson" <yakker@aparity.com> writes:
|>
|>> diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/kernel/i386_ksyms.c linux-2.5.40+lkcd/arch/i386/kernel/i386_ksyms.c
|>> --- linux-2.5.40/arch/i386/kernel/i386_ksyms.c	Tue Oct  1 12:36:59 2002
|>> +#if defined(CONFIG_X86) || defined(CONFIG_ALPHA)
|>> +EXPORT_SYMBOL(page_is_ram);
|>> +#endif
|>
|>This ifdef in i386_ksyms.c doesn't make much sense...

If the rest of the architectures used page_is_ram(), this
wouldn't be a problem, but not all do.  And since we use
it/need it, that's the reason for the addition.

|>> +#ifdef CONFIG_SMP
|>> +extern irq_desc_t irq_desc[];
|>> +extern unsigned long irq_affinity[];
|>> +EXPORT_SYMBOL(irq_affinity);
|>> +EXPORT_SYMBOL(irq_desc);
|>> +extern void dump_send_ipi(void);
|>> +EXPORT_SYMBOL(dump_send_ipi);
|>> +extern int (*dump_ipi_function_ptr)(struct pt_regs *);
|>> +EXPORT_SYMBOL(dump_ipi_function_ptr);
|>> +extern void (*dump_trace_ptr)(struct pt_regs *);
|>> +EXPORT_SYMBOL(dump_trace_ptr);
|>> +extern void show_this_cpu_state(int, struct pt_regs *, struct task_struct *);
|>> +EXPORT_SYMBOL(show_this_cpu_state);
|>
|>Before adding all these ugly declarations I would just declare the file where
|>whey are exported from as 'x-obj' and put them directly to where the 
|>functions live.

Okee, I'll start looking into doing this.  That'll break out this
whole patch (assuming there's something else that can be done for
the page_is_ram() mechanism).

|>-Andi

--Matt

