Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUE2G7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUE2G7A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 02:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUE2G7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 02:59:00 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:6580 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263778AbUE2G66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 02:58:58 -0400
Message-ID: <40B83457.3060001@colorfullife.com>
Date: Sat, 29 May 2004 08:57:27 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, dcn@sgi.com
Subject: Re: [RFC, PATCH] set SLAB_HWCACHE_ALIGN for kmalloc caches
References: <40B7A562.8040104@colorfullife.com> <20040528162545.13fa2be8.akpm@osdl.org>
In-Reply-To: <20040528162545.13fa2be8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Manfred Spraul <manfred@colorfullife.com> wrote:
>  
>
>>I think the kmalloc caches should remain cache line aligned
>>    
>>
>
>I'm not so sure.  size-64 is used a lot for out-of-line dentry names.
>Taking these up to 128 bytes or even more will consume considerable
>memory in some situations.
>  
>
No, it won't:

>         /* Default alignment: as specified by the arch code.
>          * Except if an object is really small, then squeeze multiple
>          * into one cacheline.
>          */
>         align = cache_line_size();
>         while (size <= align/2)
>                     align /= 2;

SLAB_HWCACHE_ALIGN is still just a hint, for small objects it's 
converted to alignment to a power of two boundary.

--
    Manfred

