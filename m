Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVIHFYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVIHFYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVIHFYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:24:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932507AbVIHFYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:24:16 -0400
Date: Wed, 7 Sep 2005 22:23:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miloslav Trmac <mitr@volny.cz>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wistron laptop button driver
Message-Id: <20050907222347.493f1047.akpm@osdl.org>
In-Reply-To: <431E4E28.5020604@volny.cz>
References: <431E4E28.5020604@volny.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miloslav Trmac <mitr@volny.cz> wrote:
>
> +static void call_bios(struct regs *regs)
>  +{
>  +	unsigned long flags;
>  +
>  +	preempt_disable();
>  +	local_irq_save(flags);
>  +	asm volatile ("pushl %%ebp;"
>  +		      "movl %[data], %%ebp;"
>  +		      "call *%[routine];"
>  +		      "popl %%ebp"
>  +		      : "=a" (regs->eax), "=b" (regs->ebx), "=c" (regs->ecx)
>  +		      : "0" (regs->eax), "1" (regs->ebx), "2" (regs->ecx),
>  +			[routine] "m" (bios_entry_point),
>  +			[data] "m" (bios_data_map_base)
>  +		      : "edx", "edi", "esi", "memory");
>  +	local_irq_restore(flags);
>  +	preempt_enable();
>  +}
>  +

(the preempt_disable/enable isn't needed - local_irq_save() will suffice)

gcc-2.95.x spits the dummy over this [routine] stuff.  What compiler does
this require?

Is it necessary to open-code the BIOS call in the driver?  Does it make
sense to have some library function to do this?
