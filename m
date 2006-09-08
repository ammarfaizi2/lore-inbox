Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWIHGiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWIHGiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 02:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWIHGiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 02:38:54 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54426 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751739AbWIHGix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 02:38:53 -0400
Date: Fri, 8 Sep 2006 10:38:09 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: shaw@vranix.com
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take17 1/4] kevent: Core files.
Message-ID: <20060908063808.GA28736@2ka.mipt.ru>
References: <1157623151215@2ka.mipt.ru> <200609072105.16061.shaw@vranix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200609072105.16061.shaw@vranix.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 08 Sep 2006 10:38:13 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 09:05:16PM -0700, shaw@vranix.com (shaw@vranix.com) wrote:
> > +static int __devinit kevent_user_init(void)
> > +{
> > +	int err = 0;
> > +
> > +	kevent_cache = kmem_cache_create("kevent_cache",
> > +			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
> > +
> > +	err = misc_register(&kevent_miscdev);
> > +	if (err) {
> > +		printk(KERN_ERR "Failed to register kevent miscdev: err=%d.\n", err);
> > +		goto err_out_exit;
> > +	}
> > +
> > +	printk("KEVENT subsystem has been successfully registered.\n");
> > +
> > +	return 0;
> > +
> > +err_out_exit:
> > +	kmem_cache_destroy(kevent_cache);
> > +	return err;
> > +}
> 
> It's probably best to treat kmem_cache_create like a black box and check for 
> it returning null.

It can not return NULL, it will panic instead since I use SLAB_PANIC
flag.

> Thanks,
> Shaw

-- 
	Evgeniy Polyakov
