Return-Path: <linux-kernel-owner+w=401wt.eu-S1759616AbWLICqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759616AbWLICqz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 21:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758814AbWLICqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 21:46:55 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:47145 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760254AbWLICqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 21:46:54 -0500
Date: Sat, 9 Dec 2006 11:49:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [3/4] static
 virtual mem_map
Message-Id: <20061209114950.307d57ca.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208163020.4650bbaa.akpm@osdl.org>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160708.c263a393.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208163020.4650bbaa.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 16:30:20 -0800
Andrew Morton <akpm@osdl.org> wrote:

> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP_STATIC
> > +#include <linux/mm_types.h>
> > +extern struct page mem_map[];
> > +#else
> >  extern struct page* mem_map;
> >  #endif
> > +#endif
> 
> This looks rather unpleasant - what went wrong here?
> 
definition of 'struct page' is necessary before declearing array[]. (for gcc-4.0)

> Would prefer to unconditionally include the header file - conditional inclusions
> like this can cause compile failures when someone changes a config option.  They
> generally raise the complexity level.
>
Okay.
Now, forward declearation of 'struct page' is in mmzone.h. 
I'll remove it and include mm_types.h instead of it.
If someone says "Don't do that", I'll look for anothere way.

-Kame


