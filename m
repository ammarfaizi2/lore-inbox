Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVKTMx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVKTMx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 07:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKTMx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 07:53:29 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:7633 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751228AbVKTMx3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 07:53:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiCCfX1WQG1vkx8xzrBWTCiUJFfZbfZZBNXoEy9m/zEoVCDXrQs0crqOit+luuv+bkPH6OwSWGIQdiA+BwG5TCaU2Cy5bpr5NrrKt43K4yNoPKWrGgTjoeZy+2+pebpDr7DaDCBnohq0BkVGCUQIU0EWDlRQXObeOtqqUVH7co4=
Message-ID: <6bffcb0e0511200453g65c76fa4h@mail.gmail.com>
Date: Sun, 20 Nov 2005 13:53:28 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511200802460.3938@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117234645.4128c664.akpm@osdl.org>
	 <6bffcb0e0511191623q31a143fdr@mail.gmail.com>
	 <Pine.LNX.4.61.0511200802460.3938@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/11/05, Hugh Dickins <hugh@veritas.com> wrote:
> On Sun, 20 Nov 2005, Michal Piotrowski wrote:
> >
> > It looks similar to Rafael J. Wysocki report. It's full reproductible
> > and appears when playing mp3's in totem.
> >
> > debian:/home/michal# cat /var/log/kern.log | grep -c "Bad page state
> > at free_hot_cold_page"
>
> Please let me know if it's not fixed by:
>
> --- 2.6.15-rc1-mm2/sound/core/memalloc.c        2005-11-12 09:01:28.000000000 +0000
> +++ linux/sound/core/memalloc.c 2005-11-19 19:03:32.000000000 +0000
> @@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
>
>         snd_assert(size > 0, return NULL);
>         snd_assert(gfp_flags != 0, return NULL);
> +       gfp_flags |= __GFP_COMP;        /* compound page lets parts be mapped */
>         pg = get_order(size);
>         if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
>                 mark_pages(virt_to_page(res), pg);
> @@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
>         snd_assert(dma != NULL, return NULL);
>         pg = get_order(size);
>         gfp_flags = GFP_KERNEL
> +               | __GFP_COMP    /* compound page lets parts be mapped */
>                 | __GFP_NORETRY /* don't trigger OOM-killer */
>                 | __GFP_NOWARN; /* no stack trace print - this call is non-critical */
>         res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
>

Patch has fixed problem. Thanks.

Regards,
Michal Piotrowski
