Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVKSMLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVKSMLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVKSMLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:11:24 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:50564 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751099AbVKSMLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:11:24 -0500
Message-ID: <437F165F.80203@colorfullife.com>
Date: Sat, 19 Nov 2005 13:11:11 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH 3/5] slab: extract slabinfo header printing to separate
 function
References: <iq5uuc.zmsv6.a6p8qowodnwx9kaa8jonhv8n3.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uuc.zmsv6.a6p8qowodnwx9kaa8jonhv8n3.beaver@cs.helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>  #ifdef CONFIG_PROC_FS
> 
>-static void *s_start(struct seq_file *m, loff_t *pos)
>+static inline void print_slabinfo_header(struct seq_file *m)
>  
>
Why inline? I try to avoid adding inline wherever possible. inline is 
actually always_inline force_inline 
compiler_we_know_it_better_this_must_be_inlined.
I only use inline in the hot path (kmem_cache_alloc/kmalloc+free) and 
where I know that lots of code will be optimized away due to constant 
propagation. In this case, there is no reason to force the compiler to 
inline the function, thus I wouldn't add an inline.

--
    Manfred
