Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVIIKgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVIIKgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbVIIKgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:36:38 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:29600 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030227AbVIIKgi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:36:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D0mqKMHtZaz5HSPLjFv2MgfdF6choJY3SEAAiPj2oph4KlBLwLzcbxy4X2pJaJfT+VYbzwwnypslshck3F9w9sRr4AiXQLm2N29zQAdH2YIKpq4luw7yqE3q2LIEdJ697JhZA7XTkM7gl6m6EyeLcJ03786qrd9GlP8D2aJP42A=
Message-ID: <84144f0205090903366454da6@mail.gmail.com>
Date: Fri, 9 Sep 2005 13:36:33 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc() in ntfs_malloc_nofs() and add _nofail() version.
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> -static inline void *ntfs_malloc_nofs(unsigned long size)
> +static inline void *__ntfs_malloc(unsigned long size,
> +               unsigned int __nocast gfp_mask)
>  {
>         if (likely(size <= PAGE_SIZE)) {
>                 BUG_ON(!size);
>                 /* kmalloc() has per-CPU caches so is faster for now. */
> -               return kmalloc(PAGE_SIZE, GFP_NOFS);
> -               /* return (void *)__get_free_page(GFP_NOFS | __GFP_HIGHMEM); */
> +               return kmalloc(PAGE_SIZE, gfp_mask);
> +               /* return (void *)__get_free_page(gfp_mask); */
>         }
>         if (likely(size >> PAGE_SHIFT < num_physpages))
> -               return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
> +               return __vmalloc(size, gfp_mask, PAGE_KERNEL);

Unrelated to this patch but why do you have this wrapper instead of
using kmalloc() where you can and__vmalloc() where you really have to?

                                     Pekka
