Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWDDJsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWDDJsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWDDJsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:48:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964799AbWDDJsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:48:16 -0400
Date: Tue, 4 Apr 2006 02:47:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: [patch 2/3] mm: speculative get_page
Message-Id: <20060404024715.6555d8e2.akpm@osdl.org>
In-Reply-To: <20060219020159.9923.94877.sendpatchset@linux.site>
References: <20060219020140.9923.43378.sendpatchset@linux.site>
	<20060219020159.9923.94877.sendpatchset@linux.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> +static inline struct page *page_cache_get_speculative(struct page **pagep)

Seems rather large to inline.

>  +{
>  +	struct page *page;
>  +
>  +	VM_BUG_ON(in_interrupt());
>  +
>  +#ifndef CONFIG_SMP
>  +	page = *pagep;
>  +	if (unlikely(!page))
>  +		return NULL;
>  +
>  +	VM_BUG_ON(!in_atomic());

This will go blam if !CONFIG_PREEMPT.
