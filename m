Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262530AbSI0PbV>; Fri, 27 Sep 2002 11:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbSI0PbV>; Fri, 27 Sep 2002 11:31:21 -0400
Received: from ns.suse.de ([213.95.15.193]:36877 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262530AbSI0PbU>;
	Fri, 27 Sep 2002 11:31:20 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put modules into linear mapping
References: <20020927140930.GA12610@averell.suse.lists.linux.kernel> <Pine.LNX.4.44.0209271618360.8911-100000@serv.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Sep 2002 17:36:35 +0200
In-Reply-To: Roman Zippel's message of "27 Sep 2002 16:49:12 +0200"
Message-ID: <p73d6qzsav0.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> Why is i386 only? This is generic code and other archs will benefit from
> it as well (or at least it won't hurt).

Because some arcitectures have a different module_map() (e.g. x86-64 or 
sparc64) and because the VMALLOC_START/END trick doesn't work on all.

> > +
> > +void *alloc_exact(unsigned int size)
> > +{
> > +	struct page *p, *w;
> > +	int order = get_order(size);
> > +
> > +	p = alloc_pages(GFP_KERNEL, order);
> 
> Wouldn't it be better to add a gfp argument?

I don't see a need for it. GFP_ATOMIC doesn't make sense for > order 0,
and > order 0 is the only case that is interesting for alloc_exact. 
GFP_DMA is not needed here, and GFP_HIGHUSER neither supports > order 0 
properly (because of kmap) 

-Andi
