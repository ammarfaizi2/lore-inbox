Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVCHBBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVCHBBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVCHA7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:59:22 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:35545 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261953AbVCGXi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:38:29 -0500
Date: Tue, 8 Mar 2005 03:03:38 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [1/many] acrypto: Kconfig
Message-ID: <20050308030338.06bf9af7@zanzibar.2ka.mipt.ru>
In-Reply-To: <422CE4B2.2020403@osdl.org>
References: <11102278531852@2ka.mipt.ru>
	<422CE4B2.2020403@osdl.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 02:37:35 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2005 15:33:06 -0800
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> Evgeniy Polyakov wrote:
> > diff -Nru /tmp/empty/Kconfig ./acrypto/Kconfig
> > --- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
> > +++ ./acrypto/Kconfig	2005-03-07 21:21:33.000000000 +0300
> > @@ -0,0 +1,30 @@
> > +menu "Asynchronous crypto layer"
> > +
> > +config ACRYPTO
> > +	tristate "Asynchronous crypto layer"
> > +	select CONNECTOR
> > +	--- help ---
> > +	It supports:
> > +	 - multiple asynchronous crypto device queues
> > +	 - crypto session routing
> > +	 - crypto session binding
> > +	 - modular load balancing
> > +	 - crypto session batching genetically implemented by design
> Just curious, what genetics?

:)
All other stacks requires special flags and various complex schemas 
to support batching,
but acrypto provides session queue to the low-level driver, 
so it does not require any special cruft to support session batching.
So we have batching just after new driver birth, 
that is why it is genetic.

> > +	 - crypto session priority
> > +	 - different kinds of crypto operation(RNG, asymmetrical crypto, HMAC and any other
>                                       operation (RNG, ... )
> > +
> > +config SIMPLE_LB
> > +	tristate "Simple load balancer"
> > +	depends on ACRYPTO
> > +	--- help ---
> > +	Simple load balancer returns device with the lowest load
> > +	(device has the least number of session in it's queue) if it exists.
>                                          sessions in its
> > +
> > +config ASYNC_PROVIDER
> > +	tristate "Asynchronous crypto provider (AES CBC)"
> > +	depends on ACRYPTO && (CRYPTO_AES || CRYPTO_AES_586)
> > +	--- help ---
> > +	Asynchronous crypto provider based on synchronous crypto layer.
> > +	It supports AES CBC crypto mode (may be changed by source edition).
> > +
> > +endmenu

Thank you for your comments, I will put updates into the queue,
and push them if acrypto will be commited.

> -- 
> ~Randy


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
