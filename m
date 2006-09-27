Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030733AbWI0T7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030733AbWI0T7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030734AbWI0T7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:59:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39139 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030733AbWI0T7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:59:34 -0400
Date: Wed, 27 Sep 2006 14:59:29 -0500
From: Dean Nelson <dcn@sgi.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: swise@opengridcomputing.com, jes@trained-monkey.org, avolkov@varma-el.com,
       linux-kernel@vger.kernel.org, dcn@sgi.com
Subject: Re: [PATCH 2.6.18 ] LIB Add gen_pool_destroy().
Message-ID: <20060927195929.GB3283@sgi.com>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int> <20060927085123.99749d2c.rdunlap@xenotime.net> <1159372405.10663.13.camel@stevo-desktop> <20060927085608.7f753439.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927085608.7f753439.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 08:56:08AM -0700, Randy Dunlap wrote:
> On Wed, 27 Sep 2006 10:53:25 -0500 Steve Wise wrote:
> 
> > > > index 71338b4..c8afa10 100644
> > > > --- a/lib/genalloc.c
> > > > +++ b/lib/genalloc.c
> > > > @@ -36,6 +36,28 @@ EXPORT_SYMBOL(gen_pool_create);
> > > >  
> > > >  
> > > >  /*
> > > > + * Destroy a memory pool.  Assumes the user deals with releasing the
> > > > + * actual memory managed by the pool.  
> > > > + *
> > > > + * @pool: pool to destroy.
> > > > + *
> > > > + */
> > > 
> > > Please use kernel-doc for exported kernel interfaces.
> > > See Documentation/kernel-doc-nano-HOWTO.txt for info,
> > > and/or see some file like kernel/printk.c for examples.
> > > 
> > > > +void gen_pool_destroy(struct gen_pool *pool)
> > > > +{
> > > > +	struct list_head *_chunk, *next;
> > > > +	struct gen_pool_chunk *chunk;
> > > > +
> > > > +	list_for_each_safe(_chunk, next, &pool->chunks) {
> > > > +		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
> > > > +		kfree(chunk);
> > > > +	}
> > > > +	kfree(pool);
> > > > +	return;
> > > > +}
> > > > +EXPORT_SYMBOL(gen_pool_destroy);
> > > > +
> > > > +
> > > > +/*
> > > >   * Add a new chunk of memory to the specified pool.
> > > >   *
> > > >   * @pool: pool to add new memory chunk to
> > > > -
> > > 
> > > argh.  more.  (not part of your patch)
> > 
> > 
> > I formatted it to align with the rest of the file...
> 
> Yes, so I noticed (when I got to the end of the patch).
> 
> I suppose I'll queue this up for kernel-doc work.

Sorry Randy, this was my mistake. I didn't know about kernel-doc.
I'll put together a patch tommorrow, if that would be alright?
I don't have the time today.

Thanks,
Dean
