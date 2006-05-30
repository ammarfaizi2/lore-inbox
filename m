Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWE3B3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWE3B3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWE3B3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:29:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751551AbWE3B3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:20 -0400
Date: Mon, 29 May 2006 18:33:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 07/61] lock validator: better lock debugging
Message-Id: <20060529183334.d3e7bef9.akpm@osdl.org>
In-Reply-To: <20060529212337.GG3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212337.GG3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:23:37 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> --- /dev/null
> +++ linux/include/linux/debug_locks.h
> @@ -0,0 +1,62 @@
> +#ifndef __LINUX_DEBUG_LOCKING_H
> +#define __LINUX_DEBUG_LOCKING_H
> +
> +extern int debug_locks;
> +extern int debug_locks_silent;
> +
> +/*
> + * Generic 'turn off all lock debugging' function:
> + */
> +extern int debug_locks_off(void);
> +
> +/*
> + * In the debug case we carry the caller's instruction pointer into
> + * other functions, but we dont want the function argument overhead
> + * in the nondebug case - hence these macros:
> + */
> +#define _RET_IP_		(unsigned long)__builtin_return_address(0)
> +#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> +
> +#define DEBUG_WARN_ON(c)						\
> +({									\
> +	int __ret = 0;							\
> +									\
> +	if (unlikely(c)) {						\
> +		if (debug_locks_off())					\
> +			WARN_ON(1);					\
> +		__ret = 1;						\
> +	}								\
> +	__ret;								\
> +})

Either the name of this thing is too generic, or we _make_ it generic, in
which case it's in the wrong header file.

> +#ifdef CONFIG_SMP
> +# define SMP_DEBUG_WARN_ON(c)			DEBUG_WARN_ON(c)
> +#else
> +# define SMP_DEBUG_WARN_ON(c)			do { } while (0)
> +#endif

Probably ditto.


