Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291952AbSBTQCB>; Wed, 20 Feb 2002 11:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291957AbSBTQB6>; Wed, 20 Feb 2002 11:01:58 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42900 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291952AbSBTQBp>; Wed, 20 Feb 2002 11:01:45 -0500
Date: Wed, 20 Feb 2002 11:01:27 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@redhat.com>, Stelian Pop <stelian.pop@fr.alcove.com>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020220110127.A13240@devserv.devel.redhat.com>
In-Reply-To: <20020220131310.GE8539@come.alcove-fr> <Pine.LNX.4.21.0202201539410.1232-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0202201539410.1232-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Feb 20, 2002 at 04:00:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 04:00:47PM +0000, Hugh Dickins wrote:
> Ingo,
> 
> On Wed, 20 Feb 2002, Stelian Pop wrote:
> > The following trivial patch exports the new vmalloc_to_page primitive to
> > the modules (following mingo's modifications to, at least, the v4l drivers).
> > 
> > Stelian.
> > 
> > ===== kernel/ksyms.c 1.62 vs edited =====
> > --- 1.62/kernel/ksyms.c	Mon Feb 18 18:09:54 2002
> > +++ edited/kernel/ksyms.c	Wed Feb 20 12:08:42 2002
> > @@ -107,6 +107,7 @@
> >  EXPORT_SYMBOL(kfree);
> >  EXPORT_SYMBOL(vfree);
> >  EXPORT_SYMBOL(__vmalloc);
> > +EXPORT_SYMBOL(vmalloc_to_page);
> >  EXPORT_SYMBOL(mem_map);
> >  EXPORT_SYMBOL(remap_page_range);
> >  EXPORT_SYMBOL(max_mapnr);
> 
> Hmm, what is this "vmalloc_to_page" and in what tree do we find it?
> Is this a case of BitKeeper users getting ahead of the game?
> 
> I ask because I was preparing mail and patch to replace Arjan's
> uvirt-to-kva-2.5.5-A0 (and those parts of your highmem-2.5.5-A0).
> 
> In brief, I contend that
> unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr)
> is not appropriate or useful for mm/memory.c to provide, but
> struct page *vvirt_to_page(unsigned long vadr)
> is appropriate and useful for mm/vmalloc.c to provide.
> 
> Is that what your "vmalloc_to_page" is?  If so, why are you also
> marketing "uvirt_to_kva"?  If not, sorry for all the confusion!

uvirt_to_kva got fixed. bad interface.
and replaced by vmalloc_to_page() which is the right one (eg returing
struct page).

Now if it should be EXPORT_SYMBOL or EXPORT_SYMBOL_GPL() I leave to Ingo
