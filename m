Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWIHRGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWIHRGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWIHRGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:06:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:64178 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750819AbWIHRGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:06:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=N/v82TWHCHj+/sqbkkJZCdcqqZXwH8BGE1bEj1nxHh42LLGTL7MCfvngmKcnDT6axqOcXLhIFKCIx0WlLlFSYeX/l/53dxTCHe/9vHiZJCL889QJpitd0IFjrPjNG/nHD9OR0uHWei7eNqLgpao9iVX8ERTzkBM60czbZqVngD4=
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take17 1/4] kevent: Core files.
Date: Fri, 8 Sep 2006 10:06:38 -0700
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
References: <1157623151215@2ka.mipt.ru> <200609072105.16061.shaw@vranix.com> <20060908063808.GA28736@2ka.mipt.ru>
In-Reply-To: <20060908063808.GA28736@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609081006.38101.shaw@vranix.com>
From: shawvrana@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I stand corrected.

On Thursday 07 September 2006 23:38, Evgeniy Polyakov wrote:
> On Thu, Sep 07, 2006 at 09:05:16PM -0700, shaw@vranix.com (shaw@vranix.com) 
wrote:
> > > +static int __devinit kevent_user_init(void)
> > > +{
> > > +	int err = 0;
> > > +
> > > +	kevent_cache = kmem_cache_create("kevent_cache",
> > > +			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
> > > +
> > > +	err = misc_register(&kevent_miscdev);
> > > +	if (err) {
> > > +		printk(KERN_ERR "Failed to register kevent miscdev: err=%d.\n",
> > > err); +		goto err_out_exit;
> > > +	}
> > > +
> > > +	printk("KEVENT subsystem has been successfully registered.\n");
> > > +
> > > +	return 0;
> > > +
> > > +err_out_exit:
> > > +	kmem_cache_destroy(kevent_cache);
> > > +	return err;
> > > +}
> >
> > It's probably best to treat kmem_cache_create like a black box and check
> > for it returning null.
>
> It can not return NULL, it will panic instead since I use SLAB_PANIC
> flag.
>
> > Thanks,
> > Shaw
