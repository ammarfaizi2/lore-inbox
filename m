Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263688AbUDTS0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUDTS0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUDTS0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:26:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:60570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263688AbUDTS0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:26:23 -0400
Date: Tue, 20 Apr 2004 11:25:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: andrea@suse.de, agruen@suse.de, linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
Message-Id: <20040420112556.400ea49e.akpm@osdl.org>
In-Reply-To: <40855C97.1090006@colorfullife.com>
References: <1082383751.6746.33.camel@f235.suse.de>
	<20040419162533.GR29954@dualathlon.random>
	<4084017C.5080706@colorfullife.com>
	<20040420002423.469cca01.akpm@osdl.org>
	<20040420144937.GG29954@dualathlon.random>
	<40855C97.1090006@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Andrea Arcangeli wrote:
> 
> >On Tue, Apr 20, 2004 at 12:24:23AM -0700, Andrew Morton wrote:
> >  
> >
> >>So I do think that we should either make "align=0" translate to "pack them
> >>densely" or do the big sweep across all kmem_cache_create() callsites.
> >>    
> >>
> >
> >agreed.
> >  
> >
> What about this proposal:
> SLAB_HWCACHE_ALIGN clear: align to max(sizeof(void*), align).
> SLAB_HWCACHE_ALIGN set: align to max(cpu_align(), align).
> 
> cpu_align is the cpu cache line size - either runtime or compile time.
> 
> Or are there users that want an alignment smaller than sizeof(void*)?

I doubt if this is likely to cause problems, and in cases where we expect
to have really large numbers of objects we could explicitly select an
alignment of 4 anyway.

But why would you choose to make the "SLAB_HWCACHE_ALIGN clear" case use
sizeof(void*) rather than sizeof(int)?
