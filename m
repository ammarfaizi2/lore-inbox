Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUHXHee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUHXHee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUHXHee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:34:34 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:13830 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266661AbUHXHeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:34:31 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@redhat.com (David S. Miller)
Subject: Re: IPv6 oops on ifup in latest BK
Cc: jgarzik@pobox.com, yoshfuji@linux-ipv6.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040823235123.71f18c04.davem@redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BzVoY-00018s-00@gondolin.me.apana.org.au>
Date: Tue, 24 Aug 2004 17:33:54 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> wrote:
> 
> Maybe new code should be something like:
> 
>                if (dev && dev != &loopback_dev) {

You want
		 if (dev) {
here.

>                        dev_put(dev);
>                        in6_dev_put(idev);
>                }
>                dev = &loopback_dev;
>                dev_hold(dev);
>                idev = in6_dev_get(dev);
>                if (!idev) {
>                        err = -ENODEV;
>                        goto out;
>                }
> 
> What do you think?

Yes this would work.  But I think Yoshifuji-san is trying to avoid the
unnecessary put/get in the case where dev is already loopback_dev.
So something like this might work:

		if (dev != &loopback_dev) {
			if (dev) {
				dev_put(dev);
				in6_dev_put(idev);
			}
			...
		}
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
