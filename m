Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTLLUIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTLLUIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:08:12 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:451 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261929AbTLLUIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:08:09 -0500
Message-ID: <3FDA2008.9080504@colorfullife.com>
Date: Fri, 12 Dec 2003 21:07:36 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Nathan Scott <nathans@sgi.com>, pinotj@club-internet.fr, torvalds@osdl.org,
       neilb@cse.unsw.edu.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
References: <mnet2.1070931455.23402.pinotj@club-internet.fr> <20031209020322.GA1798@frodo> <20031209072131.GD24599@lst.de> <20031209235832.GG783@frodo> <20031212190002.GA21253@lst.de>
In-Reply-To: <20031212190002.GA21253@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>Looks like whe're better of fixing mm/slab.c
>
Maybe I'm blind, but I don't see how kmem_cache_alloc can return NULL 
with __GFP_NOFAIL:
- kmem_cache_alloc calls __cache_alloc.
- cache_alloc only return 0 if cache_alloc_refill returns 0.
- cache_alloc_refill only return 0 if cache_grow returns 0.
- cache_grow only return 0 if
    * SLAB_NO_GROW is set in flags.
    * get_free_pages(flags) fails.
    * kmem_cache_alloc(flags&SLAB_LEVEL_MASK) fails.
       SLAB_LEVEL_MASK contains __GFP_NOFAIL.

--
    Manfred


