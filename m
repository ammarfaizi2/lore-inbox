Return-Path: <linux-kernel-owner+w=401wt.eu-S1757059AbWLIDeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059AbWLIDeI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 22:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbWLIDeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:34:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40693 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757059AbWLIDeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:34:05 -0500
Date: Fri, 8 Dec 2006 19:33:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [3/4] static
 virtual mem_map
Message-Id: <20061208193323.8c5382c6.akpm@osdl.org>
In-Reply-To: <20061209114950.307d57ca.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160708.c263a393.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208163020.4650bbaa.akpm@osdl.org>
	<20061209114950.307d57ca.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 11:49:50 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Fri, 8 Dec 2006 16:30:20 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > +#ifdef CONFIG_SPARSEMEM_VMEMMAP_STATIC
> > > +#include <linux/mm_types.h>
> > > +extern struct page mem_map[];
> > > +#else
> > >  extern struct page* mem_map;
> > >  #endif
> > > +#endif
> > 
> > This looks rather unpleasant - what went wrong here?
> > 
> definition of 'struct page' is necessary before declearing array[]. (for gcc-4.0)

hm, OK, that declaration needs all of `struct page' in scope.

> 
> > Would prefer to unconditionally include the header file - conditional inclusions
> > like this can cause compile failures when someone changes a config option.  They
> > generally raise the complexity level.
> >
> Okay.
> Now, forward declearation of 'struct page' is in mmzone.h. 
> I'll remove it and include mm_types.h instead of it.
> If someone says "Don't do that", I'll look for anothere way.
> 

This header needs mm_types.h, so including it is certainly OK - there's no
choice.  But I think it'd be better to include mm_types.h outside of any
ifdefs.  Just stick the #include at the start of the file as usual.
