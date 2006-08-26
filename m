Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWHZPcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWHZPcG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 11:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWHZPcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 11:32:06 -0400
Received: from kanga.kvack.org ([66.96.29.28]:18145 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932336AbWHZPcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 11:32:03 -0400
Date: Sat, 26 Aug 2006 11:31:47 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Make kmem_cache_destroy() return void
Message-ID: <20060826153147.GB18092@kvack.org>
References: <20060825212110.GB2246@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825212110.GB2246@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 01:21:10AM +0400, Alexey Dobriyan wrote:
> un-, de-, -free, -destroy, -exit, etc functions should in general
> return void. Also,
> @@ -2411,7 +2410,6 @@ int kmem_cache_destroy(struct kmem_cache
>  		list_add(&cachep->next, &cache_chain);
>  		mutex_unlock(&cache_chain_mutex);
>  		unlock_cpu_hotplug();
> -		return 1;
>  	}
>  
>  	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU))

Shouldn't this return, as otherwise there is a significant change in the 
code path followed.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
