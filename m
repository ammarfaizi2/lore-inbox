Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWI0Px2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWI0Px2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 11:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWI0Px2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 11:53:28 -0400
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:17877 "EHLO
	dell3.ogc.int") by vger.kernel.org with ESMTP id S964994AbWI0Px1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 11:53:27 -0400
Subject: Re: [PATCH 2.6.18 ] LIB Add gen_pool_destroy().
From: Steve Wise <swise@opengridcomputing.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, dcn@sgi.com, jes@trained-monkey.org,
       avolkov@varma-el.com
In-Reply-To: <20060927085123.99749d2c.rdunlap@xenotime.net>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int>
	 <20060927085123.99749d2c.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 10:53:25 -0500
Message-Id: <1159372405.10663.13.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > index 71338b4..c8afa10 100644
> > --- a/lib/genalloc.c
> > +++ b/lib/genalloc.c
> > @@ -36,6 +36,28 @@ EXPORT_SYMBOL(gen_pool_create);
> >  
> >  
> >  /*
> > + * Destroy a memory pool.  Assumes the user deals with releasing the
> > + * actual memory managed by the pool.  
> > + *
> > + * @pool: pool to destroy.
> > + *
> > + */
> 
> Please use kernel-doc for exported kernel interfaces.
> See Documentation/kernel-doc-nano-HOWTO.txt for info,
> and/or see some file like kernel/printk.c for examples.
> 
> > +void gen_pool_destroy(struct gen_pool *pool)
> > +{
> > +	struct list_head *_chunk, *next;
> > +	struct gen_pool_chunk *chunk;
> > +
> > +	list_for_each_safe(_chunk, next, &pool->chunks) {
> > +		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
> > +		kfree(chunk);
> > +	}
> > +	kfree(pool);
> > +	return;
> > +}
> > +EXPORT_SYMBOL(gen_pool_destroy);
> > +
> > +
> > +/*
> >   * Add a new chunk of memory to the specified pool.
> >   *
> >   * @pool: pool to add new memory chunk to
> > -
> 
> argh.  more.  (not part of your patch)


I formatted it to align with the rest of the file...

Steve.

