Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273049AbRIIVIH>; Sun, 9 Sep 2001 17:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273050AbRIIVH5>; Sun, 9 Sep 2001 17:07:57 -0400
Received: from s340-modem2102.dial.xs4all.nl ([194.109.168.54]:14725 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S273049AbRIIVHz>;
	Sun, 9 Sep 2001 17:07:55 -0400
Date: Sun, 9 Sep 2001 23:07:02 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Feedback on preemptible kernel patch
In-Reply-To: <1000055386.15956.2.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109092245240.3676-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert,


I tried 2.4.10-pre4+preempt+this-patch.
Just booted up, and don't notice anything unusual.

On 9 Sep 2001, Robert Love wrote:

> Arjan,
>
> the following patch was written by Manfred Spraul to fix your highmem
> bug.  I haven't had a chance to go over it, but I would like it if you
> could test it.  It can't hurt.  Patch it on top of the preempt patch and
> enable CONFIG_PREEMPT, CONFIG_HIGHMEM, and CONFIG_HIGHMEM_DEBUG.

I found i do anly have a '#define HIGHMEM_DEBUG 1' in
./include/asm/highmem.h, which is default in 2.4.10-pre4.

>
> let me know what happens...any relevant messages, etc. please pass
> along. if it does work, id be curious if they are any slowdowns

Booting up, X, compiling kernel.. no problems.
For speed, i DO notice other processes seem not to wait on that one
programm which has much disk-access, so the (real) sluggish feeling has
gone. This is however with the preempt patch, and the ctx_sw_ patch below
seems only to affect stability in positive sense.

Can you advice what and how to test performance/latency?
The grafics/statistics on the websites you named are impressive..


Greatings,


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

