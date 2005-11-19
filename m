Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbVKSCri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbVKSCri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbVKSCri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:47:38 -0500
Received: from [139.30.44.16] ([139.30.44.16]:56580 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1161154AbVKSCri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:47:38 -0500
Date: Sat, 19 Nov 2005 03:46:32 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: compile fix 2.6.15-rc1-mm1 + EXPERIMENTAL+  CONFIG_SPARSEMEM +
 X86_PC
In-Reply-To: <20051118170744.2c852d25.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0511190341320.18532@gockel.physik3.uni-rostock.de>
References: <437D79F3.9070301@jp.fujitsu.com> <20051118170744.2c852d25.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Andrew Morton wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> > 
> > This is a compile fix for
> > X86_PC && EXPERIMENTAL && CONFIG_SPARSEMEM=y && !CONFIG_NEED_MULTIPLE_NODES
> > 
> > BTW, on x86, it looks I can select CONFIG_NUMA=y but will not set
> > CONFIG_NEED_MULTIPLE_NODES. It this expected ?
> > 
> 
> This patch is difficult for me to handle, because I don't know which
> patches it fixes - probably it fixes two separate ones and needs to become
> two patches.  Usually it's obvious which patches are being fixed. 
> Sometimes reporters will tell me which patch is being fixed (extra nice!). 
> In this case, it's unobvious.

The first (pfn_to_nid()) part very much looks like it is due to my
dont-include-schedh-from-modh.patch.

> Please always include the text of the error messages when fixing compile
> errors.

Indeed, that would help me to tell.

> > Index: linux-2.6.15-rc1-mm1/include/linux/mmzone.h
> > ===================================================================
> > --- linux-2.6.15-rc1-mm1.orig/include/linux/mmzone.h
> > +++ linux-2.6.15-rc1-mm1/include/linux/mmzone.h
> > @@ -596,12 +596,13 @@ static inline int pfn_valid(unsigned lon
> >   		return 0;
> >   	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> >   }
> > -
> > +#ifdef CONFIG_NEED_MULTIPLE_NODES
> >   #define pfn_to_nid(pfn)							\
> >   ({									\
> >    	unsigned long __pfn = (pfn);                                    \
> >   	page_to_nid(pfn_to_page(pfn));					\
> >   })
> > +#endif
> > 
> >   #define early_pfn_valid(pfn)	pfn_valid(pfn)
> >   void sparse_init(void);
> > Index: linux-2.6.15-rc1-mm1/drivers/base/memory.c
> > ===================================================================
