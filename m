Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWI0Py5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWI0Py5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWI0Py4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 11:54:56 -0400
Received: from xenotime.net ([66.160.160.81]:52150 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964995AbWI0Py4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 11:54:56 -0400
Date: Wed, 27 Sep 2006 08:56:08 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Steve Wise <swise@opengridcomputing.com>
Cc: linux-kernel@vger.kernel.org, dcn@sgi.com, jes@trained-monkey.org,
       avolkov@varma-el.com
Subject: Re: [PATCH 2.6.18 ] LIB Add gen_pool_destroy().
Message-Id: <20060927085608.7f753439.rdunlap@xenotime.net>
In-Reply-To: <1159372405.10663.13.camel@stevo-desktop>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int>
	<20060927085123.99749d2c.rdunlap@xenotime.net>
	<1159372405.10663.13.camel@stevo-desktop>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 10:53:25 -0500 Steve Wise wrote:

> > > index 71338b4..c8afa10 100644
> > > --- a/lib/genalloc.c
> > > +++ b/lib/genalloc.c
> > > @@ -36,6 +36,28 @@ EXPORT_SYMBOL(gen_pool_create);
> > >  
> > >  
> > >  /*
> > > + * Destroy a memory pool.  Assumes the user deals with releasing the
> > > + * actual memory managed by the pool.  
> > > + *
> > > + * @pool: pool to destroy.
> > > + *
> > > + */
> > 
> > Please use kernel-doc for exported kernel interfaces.
> > See Documentation/kernel-doc-nano-HOWTO.txt for info,
> > and/or see some file like kernel/printk.c for examples.
> > 
> > > +void gen_pool_destroy(struct gen_pool *pool)
> > > +{
> > > +	struct list_head *_chunk, *next;
> > > +	struct gen_pool_chunk *chunk;
> > > +
> > > +	list_for_each_safe(_chunk, next, &pool->chunks) {
> > > +		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
> > > +		kfree(chunk);
> > > +	}
> > > +	kfree(pool);
> > > +	return;
> > > +}
> > > +EXPORT_SYMBOL(gen_pool_destroy);
> > > +
> > > +
> > > +/*
> > >   * Add a new chunk of memory to the specified pool.
> > >   *
> > >   * @pool: pool to add new memory chunk to
> > > -
> > 
> > argh.  more.  (not part of your patch)
> 
> 
> I formatted it to align with the rest of the file...

Yes, so I noticed (when I got to the end of the patch).

I suppose I'll queue this up for kernel-doc work.

---
~Randy
