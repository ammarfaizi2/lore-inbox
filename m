Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWAVUcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWAVUcm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAVUcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:32:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751322AbWAVUcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:32:41 -0500
Date: Sun, 22 Jan 2006 12:31:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] disable per cpu intr in /proc/stat
Message-Id: <20060122123150.3a289ac3.akpm@osdl.org>
In-Reply-To: <20060122202204.GA26295@suse.de>
References: <20060122202204.GA26295@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> (No bugzilla or benchmark)
> 
> From: schwab@suse.de
> Subject: Reading /proc/stat is slooow
> 
> Don't compute and display the per-irq sums on ia64 either, too much
> overhead for mostly useless figures.
> 
> --- linux-2.6.14/fs/proc/proc_misc.c.~1~	2005-12-06 18:12:28.840059961 +0100
> +++ linux-2.6.14/fs/proc/proc_misc.c	2005-12-06 18:13:51.211896515 +0100
> @@ -498,7 +498,7 @@ static int show_stat(struct seq_file *p,
>  	}
>  	seq_printf(p, "intr %llu", (unsigned long long)sum);
>  
> -#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
> +#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA) && !defined(CONFIG_IA64)
>  	for (i = 0; i < NR_IRQS; i++)
>  		seq_printf(p, " %u", kstat_irqs(i));
>  #endif

We'd need a big ack from the ia64 team for this, please.
