Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVLUJqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVLUJqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVLUJqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:46:36 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:34537 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932344AbVLUJqf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:46:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g+JCKt2HexbH9w+M6lYACQe434iMpMLxD5btWBqzaDCIH8Z1ugsrssU66sqXRCZuQpCLM2M0UzumVWqGhwJt1y6xPIWqBYOqW65f1g/QcSIHBKzuDLOuz2Jw+DQQvliRd+aOOvufrpp2LRdakxO3YDuXjKKLIHdHtTU+QnoKhf8=
Message-ID: <35f686220512210146yc648487h2ff48bd663ec5921@mail.gmail.com>
Date: Wed, 21 Dec 2005 15:16:34 +0530
From: Alok kataria <alokkataria1@gmail.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <43A91C57.20102@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	 <43A91C57.20102@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Eric Dumazet <dada1@cosmosbay.com> wrote:
> I wonder if the 32 and 192 bytes caches are worth to be declared in
> include/linux/kmalloc_sizes.h, at least on x86_64
>
> (x86_64 : PAGE_SIZE = 4096, L1_CACHE_BYTES = 64)
>
> On my machines, I can say that the 32 and 192 sizes could be avoided in favor
> in spending less cpu cycles in __find_general_cachep()
>
> Could some of you post the result of the following command on your machines :
>
> # grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
>
> size-131072            0      0 131072
> size-65536             0      0  65536
> size-32768             2      2  32768
> size-16384             0      0  16384
> size-8192             13     13   8192
> size-4096            161    161   4096
> size-2048          40564  42976   2048
> size-1024            681    800   1024
> size-512           19792  37168    512
> size-256              81    105    256
> size-192            1218   1280    192
> size-64            31278  86907     64
> size-128            5457  10380    128
> size-32              594    784     32
>
> Thank you
>
> PS : I have no idea why the last lines (size-192, 64, 128, 32) are not ordered...

The size-32 and size-128 caches are created before any other cache, as
the array_caches (arraycache_init) and kmem_list3's structure come
from these cache.
Thus these caches are added to the cache_chain before other caches.
And s_show just walks this chain and prints info for the caches.

Before l3 was converted into a pointer (per node slabs) we could
intialize the caches in order as we knew that the arraycache_init will
always fit in the first cache.

Thanks & Regards,
Alok
>
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
