Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVDMC2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVDMC2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVDMC1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:27:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:60591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262618AbVDLTsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:48:08 -0400
Date: Tue, 12 Apr 2005 12:47:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 1/9] GFP_ZERO fix
Message-Id: <20050412124741.366caee3.akpm@osdl.org>
In-Reply-To: <425BC387.3080703@yahoo.com.au>
References: <425BC262.1070500@yahoo.com.au>
	<425BC387.3080703@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>   #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
>  -			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
>  -			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
>  +			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL| \
>  +			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO)

Passing GFP_ZERO into kmem_cache_alloc() is such a bizarre thing to do,
perhaps a BUG is the correct response.

I guess it could be argued that the kmem_cache_alloc() callers "knows" that
the ctor will be zeroing out all the objects, but it would seem cleaner to
me to pass the "you should use GFP_ZERO" hint into kmem_cache_create()
rather than kmem_cache_alloc().

