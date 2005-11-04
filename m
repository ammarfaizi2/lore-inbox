Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVKDWzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVKDWzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVKDWze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:55:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbVKDWzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:55:32 -0500
Date: Fri, 4 Nov 2005 14:55:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export ia64_max_cacheline_size
Message-Id: <20051104145534.17e913f2.akpm@osdl.org>
In-Reply-To: <20051104223441.GA16285@infradead.org>
References: <20051104220737.GA16551@redhat.com>
	<20051104223441.GA16285@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 04, 2005 at 05:07:37PM -0500, Dave Jones wrote:
> > on ia64, dma_get_cache_alignment() needs ia64_max_cacheline_size,
> > which isn't exported. This breaks modular compilation of the b44
> > network driver (and possibly others).
> 
> Can we please move dma_get_cache_alignment() out of line instead?

It's a single statement!  It wants to be inlined.

> Always export sane APIs instead of random internals.

The exported API is dma_get_cache_alignment().  For internal implementation
reasons we need to export an ia64 symbol to modules to support it.  That
kinda sucks, but I don't think that we need to compromise kernel size and
performance because of it.
