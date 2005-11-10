Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVKJNdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVKJNdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVKJNdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:33:51 -0500
Received: from [194.90.237.34] ([194.90.237.34]:9894 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1750714AbVKJNdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:33:50 -0500
Date: Thu, 10 Nov 2005 15:37:04 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110133704.GG16589@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> Subject: Re: Nick's core remove PageReserved broke vmware...
> 
> On Tue, 8 Nov 2005, Michael S. Tsirkin wrote:
> > 
> > Hugh, did you have something like the following in mind
> > (this is only boot-tested and only on x86-64)?
> 
> Yes, that looks pretty good to me, a few comments below.
> Only another twenty or so architectures to go ;)

Yea, thats easy :).

> (I had been imagining VM_DONTCOPY plus another flag to say set by the
> user: better your way, we would like to merge these vmas, and
> VM_DONTCOPY is in that peculiar list of special flags that prevent merging.)
> 
> > Hmm, maybe MADV_INHERIT and MADV_DONT_INHERIT would be better names,
> 
> You're right, and it would be a good choice, except that MAP_INHERIT on
> some OSes has a particular meaning (about inheriting across an exec),
> so I think avoid confusion with that.  MADV_DONTFORK and MADV_DOFORK?
> Accompanied by VM_DONTFORK?

Its actually similiar.
Maybe MADV_FORK_INHERIT/MADV_FORK_DONT_INHERIT then?
I find using "COPY" there confusing, since the copy is only done on write ...

> > Index: linux-2.6.14-dontcopy/include/asm-x86_64/mman.h
> > ===================================================================
> > --- linux-2.6.14-dontcopy.orig/include/asm-x86_64/mman.h
> 2005-11-08 23:19:35.000000000 +0200
> > +++ linux-2.6.14-dontcopy/include/asm-x86_64/mman.h	2005-11-08
> 23:19:46.000000000 +0200
> > @@ -36,6 +36,8 @@
> >  #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
> >  #define MADV_WILLNEED	0x3		/* pre-fault pages */
> >  #define MADV_DONTNEED	0x4		/* discard these pages
> */
> > +#define MADV_DONTCOPY	0x30		/* dont inherit across fork */
> > +#define MADV_DOCOPY	0x31		/* do inherit across fork */
> >  
> >  /* compatibility flags */
> >  #define MAP_ANON	MAP_ANONYMOUS
> 
> I think that's probably a good idea, to choose a range away from the rest.
> But I'm not quite sure: anyone familiar with adding APIs listening?
> 
> Hugh
> 

My reason was to make it possible to have identical values for all
architectures, making userspace portability easier.

-- 
MST
