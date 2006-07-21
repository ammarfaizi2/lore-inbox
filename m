Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWGUNFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWGUNFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWGUNFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:05:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750709AbWGUNFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:05:49 -0400
Date: Fri, 21 Jul 2006 06:05:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rodolfo Giometti <giometti@linux.it>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] no console disabling during suspend stage
Message-Id: <20060721060513.fd78b793.akpm@osdl.org>
In-Reply-To: <20060719091559.GD25330@enneenne.com>
References: <20060719091559.GD25330@enneenne.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2006 11:16:00 +0200
Rodolfo Giometti <giometti@linux.it> wrote:

> here a little patch to avoid disabling console during suspend stage
> while we are debugging kernel.
> 
> ...
>
> --- kernel/power/main.c	2006-07-19 10:54:11.000000000 +0200
> +++ kernel/power/main.c.new	2006-07-18 19:38:41.000000000 +0200
> @@ -86,7 +86,9 @@
>  			goto Thaw;
>  	}
>  
> +#ifndef CONFIG_DEBUG_KERNEL
>  	suspend_console();
> +#endif

CONFIG_DEBUG_KERNEL is not really the appropriate thing to use here - it's
more a user-interface/Kconfig level thing.

Can you please describe the problems which suspend_console() are causing?

Some runtime knob might be more appropriate.  Perhaps /sys/power/debug?

If the suspend_console() call is to be disabled then you'll want to disable
the matching resume_console() call too.

printk.c needs sem2mutex conversion.

The console_suspended/secondary_console_sem handling is racy.  Bad Linus. 
But as we're running on a single CPU and all other tasks are frozen it
doesn't matter.
