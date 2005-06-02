Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFBPte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFBPte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 11:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVFBPte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 11:49:34 -0400
Received: from relay.axxeo.de ([213.239.199.237]:54659 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261168AbVFBPtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 11:49:23 -0400
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
Date: Thu, 2 Jun 2005 17:49:15 +0200
User-Agent: KMail/1.7.2
References: <20050602144004.GA31807@elte.hu>
In-Reply-To: <20050602144004.GA31807@elte.hu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021749.15206.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
you wrote:

> --- linux/lib/spinlock_debug.c.orig
> +++ linux/lib/spinlock_debug.c
> +#define SPIN_BUG_ON(cond, lock, msg) \
> +		if (unlikely(cond)) spin_bug(lock, __FILE__, __LINE__, msg)
> +#define RWLOCK_BUG_ON(cond, lock, msg) \
> +		if (unlikely(cond)) rwlock_bug(lock, __FILE__, __LINE__, msg)

I would suggest propagating the __FILE__ and __LINE__ from the CALLERS 
of those functions in lib/spinlock_debug.c into these macros, to make
this info more useful. At the moment you just know, that the bug happend
on some spinlock/rwlock, but not who caused this.


Regards

Ingo Oeser

