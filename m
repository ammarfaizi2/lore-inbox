Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSBTP7C>; Wed, 20 Feb 2002 10:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291948AbSBTP6m>; Wed, 20 Feb 2002 10:58:42 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:55602 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291952AbSBTP6f>; Wed, 20 Feb 2002 10:58:35 -0500
Date: Wed, 20 Feb 2002 16:00:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Ingo Molnar <mingo@redhat.com>
cc: Stelian Pop <stelian.pop@fr.alcove.com>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <20020220131310.GE8539@come.alcove-fr>
Message-ID: <Pine.LNX.4.21.0202201539410.1232-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

On Wed, 20 Feb 2002, Stelian Pop wrote:
> The following trivial patch exports the new vmalloc_to_page primitive to
> the modules (following mingo's modifications to, at least, the v4l drivers).
> 
> Stelian.
> 
> ===== kernel/ksyms.c 1.62 vs edited =====
> --- 1.62/kernel/ksyms.c	Mon Feb 18 18:09:54 2002
> +++ edited/kernel/ksyms.c	Wed Feb 20 12:08:42 2002
> @@ -107,6 +107,7 @@
>  EXPORT_SYMBOL(kfree);
>  EXPORT_SYMBOL(vfree);
>  EXPORT_SYMBOL(__vmalloc);
> +EXPORT_SYMBOL(vmalloc_to_page);
>  EXPORT_SYMBOL(mem_map);
>  EXPORT_SYMBOL(remap_page_range);
>  EXPORT_SYMBOL(max_mapnr);

Hmm, what is this "vmalloc_to_page" and in what tree do we find it?
Is this a case of BitKeeper users getting ahead of the game?

I ask because I was preparing mail and patch to replace Arjan's
uvirt-to-kva-2.5.5-A0 (and those parts of your highmem-2.5.5-A0).

In brief, I contend that
unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
is not appropriate or useful for mm/memory.c to provide, but
struct page *vvirt_to_page(unsigned long vadr)
is appropriate and useful for mm/vmalloc.c to provide.

Is that what your "vmalloc_to_page" is?  If so, why are you also
marketing "uvirt_to_kva"?  If not, sorry for all the confusion!

Thanks,
Hugh

