Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbTFNH7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 03:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbTFNH7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 03:59:39 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23755 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265640AbTFNH7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 03:59:38 -0400
Date: Sat, 14 Jun 2003 01:13:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH][2.5] Add cachep->name to kmem_cache_destroy debug
 printk
Message-Id: <20030614011334.31bb4f3f.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0306140303080.31716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0306140303080.31716-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2003 08:13:26.0794 (UTC) FILETIME=[D4F07EA0:01C3324C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> kmem_cache_destroy: Can't free all objects cbc7af30 (dcookie_cache)
> 
>          I've been getting a number of these, perhaps it might be
>  worthwhile adding the name too.
> 
> ...
>  -		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
>  -		       cachep);
>  +		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p (%s)\n",
>  +		       cachep, cachep->name);


yes, but we have a nice little helper for that.

diff -puN mm/slab.c~kmem_cache_destroy-error-print mm/slab.c
--- 25/mm/slab.c~kmem_cache_destroy-error-print	2003-06-14 01:10:37.000000000 -0700
+++ 25-akpm/mm/slab.c	2003-06-14 01:13:12.000000000 -0700
@@ -1374,8 +1374,7 @@ int kmem_cache_destroy (kmem_cache_t * c
 	up(&cache_chain_sem);
 
 	if (__cache_shrink(cachep)) {
-		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
-		       cachep);
+		slab_error(cachep, "Can't free all objects");
 		down(&cache_chain_sem);
 		list_add(&cachep->next,&cache_chain);
 		up(&cache_chain_sem);

_

