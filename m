Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUHHFBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUHHFBV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUHHFBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:01:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:5064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265119AbUHHFBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:01:19 -0400
Date: Sat, 7 Aug 2004 22:01:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
In-Reply-To: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0408072157500.1793@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Aug 2004, Zwane Mwaikambo wrote:
>
> Pulled from the -tiny tree,

Hmm. 

You really shouldn't use %ebx for flags. Use %edx instead. 

%ebx is call-save, so by forcing gcc to use %edx, you're guaranteeing that 
the compiler has to save/restore the register even for a simple function 
that wouldn't otherwise need it.

Also, why export the "failed" ones:

> +#ifdef CONFIG_COOL_SPINLOCK
> +extern void asmlinkage __spin_lock_failed(spinlock_t *);
> +extern void asmlinkage __spin_lock_failed_flags(spinlock_t *, unsigned long);
> +extern void asmlinkage __spin_lock_loop(spinlock_t *);
> +extern void asmlinkage __spin_lock_loop_flags(spinlock_t *, unsigned long);
> +EXPORT_SYMBOL(__spin_lock_failed);
> +EXPORT_SYMBOL(__spin_lock_failed_flags);
> +EXPORT_SYMBOL(__spin_lock_loop);
> +EXPORT_SYMBOL(__spin_lock_loop_flags);
> +#endif

that looks just broken.

		Linus
