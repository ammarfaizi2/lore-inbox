Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVHHTyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVHHTyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVHHTyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:54:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1274 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932243AbVHHTyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:54:32 -0400
Subject: Re: [patch] IPV4 spinlock_casting
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: dwalker@mvista.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050808090659.GA11879@elte.hu>
References: <1123466661.20677.14.camel@localhost.localdomain>
	 <20050808090457.GA11771@elte.hu>  <20050808090659.GA11879@elte.hu>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 12:54:25 -0700
Message-Id: <1123530866.20053.12.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 11:06 +0200, Ingo Molnar wrote:
> 
> it just occured to me that !PREEMPT_RT builds would be affected by the
> #else branch, so i committed the build fix below into -52-15.
> 
>         Ingo
> 

That fixes it. Thanks

Sven

> Index: linux/net/ipv4/route.c
> ===================================================================
> --- linux.orig/net/ipv4/route.c
> +++ linux/net/ipv4/route.c
> @@ -231,7 +231,7 @@ static spinlock_t   *rt_hash_locks;
>                         spin_lock_init(&rt_hash_locks[i]); \
>                 }
>  #else
> -# define rt_hash_lock_addr(slot) NULL
> +# define rt_hash_lock_addr(slot) ((spinlock_t *)NULL)
>  # define rt_hash_lock_init()
>  #endif
>  
> 

