Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbTCSOXj>; Wed, 19 Mar 2003 09:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263030AbTCSOXj>; Wed, 19 Mar 2003 09:23:39 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:32079 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S263033AbTCSOXh>; Wed, 19 Mar 2003 09:23:37 -0500
Date: Wed, 19 Mar 2003 09:33:15 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.65] pnp api changes to sound/isa/sb/es968.c
In-Reply-To: <20030319121121.A21042@infradead.org>
Message-ID: <Pine.LNX.4.53.0303190903440.28260@quinn.larvalstage.com>
References: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>
 <20030319121121.A21042@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Mar 2003, Christoph Hellwig wrote:

> On Wed, Mar 19, 2003 at 07:03:57AM -0500, John Kim wrote:
> >  struct snd_card_es968 {
> > -#ifdef __ISAPNP__
> > -	struct isapnp_dev *dev;
> > -#endif	/* __ISAPNP__ */
> > +	struct pnp_dev *dev;
> >  };
> 
> What about completly removing struct snd_card_es968 and using pnp_dev
> directtly instead?  sound/* is full of this overdesign and it's time
> to get it follow kernel style a bit more..

Perhaps the task of code clean up should be done in separate track than 
pnp api conversion task?
 
> >  static int __init alsa_card_es968_init(void)
> >  {
> >  	int cards = 0;
> >  
> > -#ifdef __ISAPNP__
> > -	cards += isapnp_probe_cards(snd_es968_pnpids, snd_es968_isapnp_detect);
> > -#else
> > -	snd_printk("you have to enable ISA PnP support.\n");
> > -#endif
> > +	cards += pnp_register_card_driver(&es968_pnpc_driver);
> >  #ifdef MODULE
> >  	if (!cards)
> > -		snd_printk("no ES968 based soundcards found\n");
> > +		printk(KERN_ERR "no ES968 based soundcards found\n");
> >  #endif
> >  	return cards ? 0 : -ENODEV;
> >  }
> 
> That printk is useless, you get a useful message from modprobe on
> an ENODEV return anyway.

I'll make a new diff without useless printk line.  Thank you.
