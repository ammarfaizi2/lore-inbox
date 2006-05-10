Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWEJLlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWEJLlY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWEJLlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:41:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964930AbWEJLlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:41:23 -0400
Date: Wed, 10 May 2006 04:38:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: cleanup swap unused warning
Message-Id: <20060510043834.70f40ddc.akpm@osdl.org>
In-Reply-To: <200605102132.41217.kernel@kolivas.org>
References: <200605102132.41217.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Are there any users of swp_entry_t when CONFIG_SWAP is not defined?

Well there shouldn't be.  Making accesses to swp_entry_t.val fail to
compile if !CONFIG_SWAP might be useful.

> +/*
> + * A swap entry has to fit into a "unsigned long", as
> + * the entry is hidden in the "index" field of the
> + * swapper address space.
> + */
> +#ifdef CONFIG_SWAP
>  typedef struct {
>  	unsigned long val;
>  } swp_entry_t;
> +#else
> +typedef struct {
> +	unsigned long val;
> +} swp_entry_t __attribute__((__unused__));
> +#endif

We have __attribute_used__, which hides a gcc oddity.
