Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263242AbTCWVJn>; Sun, 23 Mar 2003 16:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263670AbTCWVJn>; Sun, 23 Mar 2003 16:09:43 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:12681 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263242AbTCWVJm>;
	Sun, 23 Mar 2003 16:09:42 -0500
Message-ID: <3E7E252A.2030902@colorfullife.com>
Date: Sun, 23 Mar 2003 22:20:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab.c cleanup
References: <3E7E204C.2040700@colorfullife.com> <3E7E2219.5090501@quark.didntduck.org>
In-Reply-To: <3E7E2219.5090501@quark.didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

>
> Perhaps, but it currently is already allocating 128 bytes for smaller 
> caches, because the cache is created with SLAB_HWCACHE_ALIGN.  So we 
> ended up with redundantly sized caches.
>

linux/mm/slab.c:

>	if (flags & SLAB_HWCACHE_ALIGN) {
>		/* Need to adjust size so that objs are cache aligned. */
>		/* Small obj size, can get at least two per cache line. */
>		while (size < align/2)
>			align /= 2;
>		size = (size+align-1)&(~(align-1));
>	}
>  
>
HWALIGN is just a hint, the implementation ignores it if it results in 
unreasonable wasting of memory.

--
    Manfred

