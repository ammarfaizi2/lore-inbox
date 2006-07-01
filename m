Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWGAOJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWGAOJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWGAOJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:09:29 -0400
Received: from [64.62.148.172] ([64.62.148.172]:31502 "EHLO arnor.apana.org.au")
	by vger.kernel.org with ESMTP id S1751152AbWGAOJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:09:28 -0400
Date: Sun, 2 Jul 2006 00:07:50 +1000
To: Miles Lane <miles.lane@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060701140750.GA7342@gondor.apana.org.au>
References: <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu> <20060630091850.GA10713@elte.hu> <20060630111734.GA22202@gondor.apana.org.au> <20060630113758.GA18504@elte.hu> <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com> <20060630203804.GA1950@elte.hu> <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com> <1151746867.3195.19.camel@laptopd505.fenrus.org> <a44ae5cd0607010706k74c30a9ey6b7eac49d11e7827@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0607010706k74c30a9ey6b7eac49d11e7827@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 07:06:22AM -0700, Miles Lane wrote:
>
> >@@ -3260,6 +3268,8 @@ while (0)
> >        SET_NETDEV_DEV(dev, sdev);
> >        if (ret >= 0)
> >                ret = register_netdevice(dev);
> >+
> >+       lockdep_set_class(&dev->_xmit_lock, &hostap_netdev_xmit_lock_key);
> >        rtnl_unlock();
> >        if (ret < 0) {
> >                printk(KERN_WARNING "%s: register netdevice failed!\n",
> 
> After rebuilding with this patch, I still get the lockdep message.
> Everything is the same except now the "other info" section reads:

Perhaps the same trick needs to be applied to the queue lock?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
