Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVAGXnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVAGXnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVAGXmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:42:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:55016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261730AbVAGXib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:38:31 -0500
Date: Fri, 7 Jan 2005 15:43:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: pmarques@grupopie.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
Message-Id: <20050107154305.790b8a51.akpm@osdl.org>
In-Reply-To: <m18y74rfqs.fsf@clusterfs.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org>
	<41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<41DEDF87.8080809@grupopie.com>
	<m1llb5q7qs.fsf@clusterfs.com>
	<20050107132459.033adc9f.akpm@osdl.org>
	<m1d5wgrir7.fsf@clusterfs.com>
	<20050107150315.3c1714a4.akpm@osdl.org>
	<m18y74rfqs.fsf@clusterfs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
>
> >
> > Why does the filesystem risk going oom during the rebalance anyway?  Is it
> > doing atomic allocations?
> 
> No, just __alloc_pages(GFP_KERNEL, 0, ...) returns NULL. When this
> happens, the only thing balancing can do is to panic.

__alloc_pages(GFP_KERNEL, ...) doesn't return NULL.  It'll either succeed
or never return ;) That behaviour may change at any time of course, but it
does make me wonder why we're bothering with this at all.  Maybe it's
because of the possibility of a GFP_IO failure under your feet or
something?

What happens if reiser4 simply doesn't use this code?


If we introduce this mechanism, people will end up using it all over the
place.  Probably we could remove radix_tree_preload(), which is the only
similar code I can I can immediately think of.

Page reservation is not a bad thing per-se, but it does need serious
thought.

How does reiser4 end up deciding how many pages to reserve?  Gross
overkill?
