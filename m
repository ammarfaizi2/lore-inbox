Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUHIVn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUHIVn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUHIVn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:43:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:7854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267252AbUHIVnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:43:45 -0400
Date: Mon, 9 Aug 2004 14:47:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: -mm swsusp: fix highmem handling
Message-Id: <20040809144708.13955e44.akpm@osdl.org>
In-Reply-To: <20040809124825.GA602@elf.ucw.cz>
References: <20040809124825.GA602@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This fixes highmem handling, and adds some comments so that others do
> not fall into the same trap I fallen in: code does not continue below
> swsusp_arch_resume if things go okay.
> 
> Please apply,
> 								Pavel
> 
> --- clean-mm/kernel/power/swsusp.c	2004-07-28 23:39:49.000000000 +0200
> +++ linux-mm/kernel/power/swsusp.c	2004-08-09 11:54:04.000000000 +0200
> @@ -870,8 +866,12 @@
>  	local_irq_disable();
>  	save_processor_state();
>  	error = swsusp_arch_suspend();
> +	/* Restore control flow magically appears here */
>  	restore_processor_state();
>  	local_irq_enable();
> +#ifdef CONFIG_HIGHMEM
> +	restore_highmem();
> +#endif
>  	return error;

restore_highmem() is a noop if !CONFIG_HIGHMEM, so I shall remove the
above ifdef/endif.
