Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWJTE74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWJTE74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWJTE74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:59:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161413AbWJTE7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:59:55 -0400
Date: Thu, 19 Oct 2006 21:59:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor fixes to generic do_div
Message-Id: <20061019215954.1be82a57.akpm@osdl.org>
In-Reply-To: <20061020033359.GR2602@parisc-linux.org>
References: <20061020033359.GR2602@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 21:34:00 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> +/* The unnecessary pointer compare is there
> + * to check for type safety (n must be 64bit)
> + */
> +# define do_div(n,base) ({				\
> +	uint32_t __base = (base);			\
> +	uint32_t __rem;					\
> +	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
> +	__rem = ((uint64_t)(n)) % __base;		\
> +	(n) = ((uint64_t)(n)) / __base;			\
> +	__rem;						\
>   })

Can we use typecheck(), from include/linux/kernel.h?
