Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWE3B3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWE3B3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWE3B3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:29:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751544AbWE3B3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:08 -0400
Date: Mon, 29 May 2006 18:33:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 05/61] lock validator: introduce WARN_ON_ONCE(cond)
Message-Id: <20060529183321.6c1a3cba.akpm@osdl.org>
In-Reply-To: <20060529212328.GE3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212328.GE3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:23:28 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> add WARN_ON_ONCE(cond) to print once-per-bootup messages.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  include/asm-generic/bug.h |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Index: linux/include/asm-generic/bug.h
> ===================================================================
> --- linux.orig/include/asm-generic/bug.h
> +++ linux/include/asm-generic/bug.h
> @@ -44,4 +44,17 @@
>  # define WARN_ON_SMP(x)			do { } while (0)
>  #endif
>  
> +#define WARN_ON_ONCE(condition)				\
> +({							\
> +	static int __warn_once = 1;			\
> +	int __ret = 0;					\
> +							\
> +	if (unlikely(__warn_once && (condition))) {	\
> +		__warn_once = 0;			\
> +		WARN_ON(1);				\
> +		__ret = 1;				\
> +	}						\
> +	__ret;						\
> +})
> +
>  #endif

I'll queue this for mainline inclusion.
