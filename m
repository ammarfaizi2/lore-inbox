Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273058AbRIIVYk>; Sun, 9 Sep 2001 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273059AbRIIVYb>; Sun, 9 Sep 2001 17:24:31 -0400
Received: from s340-modem1889.dial.xs4all.nl ([194.109.167.97]:51845 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S273058AbRIIVYQ>;
	Sun, 9 Sep 2001 17:24:16 -0400
Date: Sun, 9 Sep 2001 23:23:44 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Feedback on preemptible kernel patch
In-Reply-To: <1000055386.15956.2.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109092317330.16723-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After my succes report i _do_ noticed something unusual:

I'm not sure it's preempt related, but you wanted feedback :)

Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  9 23:08:02 sjoerd last message repeated 93 times
Sep  9 23:08:02 sjoerd kernel: cation failed (gfp=0x70/1).
Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  9 23:08:02 sjoerd last message repeated 281 times

This is at the very moment i make a ppp connection to internet, and
get/set the time with netdate (for the first time after a reboot).
I didn't see this a second time (yet).

Btw this is 2.4.10-pre4+preempt-patch+pacht-below.

Greetings,

On 9 Sep 2001, Robert Love wrote:

> Arjan,
>
> the following patch was written by Manfred Spraul to fix your highmem
> bug.  I haven't had a chance to go over it, but I would like it if you
> could test it.  It can't hurt.  Patch it on top of the preempt patch and
> enable CONFIG_PREEMPT, CONFIG_HIGHMEM, and CONFIG_HIGHMEM_DEBUG.
>
> let me know what happens...any relevant messages, etc. please pass
> along. if it does work, id be curious if they are any slowdowns
>
>
> --- highmem.h.prev      Sun Sep  9 08:59:04 2001
> +++ highmem.h   Sun Sep  9 09:00:07 2001
> @@ -88,6 +88,7 @@
>         if (page < highmem_start_page)
>                 return page_address(page);
>
> +       ctx_sw_off();
>         idx = type + KM_TYPE_NR*smp_processor_id();
>         vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
> #if HIGHMEM_DEBUG
> @@ -119,6 +120,7 @@
>         pte_clear(kmap_pte-idx);
>         __flush_tlb_one(vaddr);
> #endif
> +       ctx_sw_on();
> }
>
> #endif /* __KERNEL__ */
>
>
>
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

