Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVAGTo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVAGTo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVAGTnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:43:46 -0500
Received: from ns.suse.de ([195.135.220.2]:63676 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261560AbVAGTmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:42:54 -0500
Date: Fri, 7 Jan 2005 20:42:45 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Paulo Marques <pmarques@grupopie.com>,
       Vladimir Saveliev <vs@namesys.com>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] per thread page reservation patch
Message-ID: <20050107194245.GA20546@wotan.suse.de>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <41DEDF87.8080809@grupopie.com> <20050107193240.GA14465@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107193240.GA14465@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 07:32:40PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 07, 2005 at 07:14:15PM +0000, Paulo Marques wrote:
> > This seems like a very asymmetrical behavior. If the code explicitly 
> > reserves pages, it should explicitly use them, or it will become 
> > impossible to track down who is using what (not to mention that this 
> > will slow down every regular user of __alloc_pages, even if it is just 
> > for a quick test).
> > 
> > Why are there specialized functions to reserve the pages, but then they 
> > are used through the standard __alloc_pages interface?
> 
> That seems to be the whole point of the patch, as that way it'll serve
> all sub-allocators or kernel function called by the user.  Without this
> behaviour the caller could have simply used a mempool.

I still don't get it why reiserfs can't put the preallocated 
pool somewhere private like all other users who do similar things
do too (and yes there are quite a lot of subsystems who do 
preallocation) 

Why pollute task_struct for this? 

-Andi
