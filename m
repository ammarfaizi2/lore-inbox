Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262978AbTCSMA0>; Wed, 19 Mar 2003 07:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbTCSMA0>; Wed, 19 Mar 2003 07:00:26 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:15111 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262978AbTCSMAZ>; Wed, 19 Mar 2003 07:00:25 -0500
Date: Wed, 19 Mar 2003 12:11:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Kim <john@larvalstage.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.65] pnp api changes to sound/isa/sb/es968.c
Message-ID: <20030319121121.A21042@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Kim <john@larvalstage.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>; from john@larvalstage.com on Wed, Mar 19, 2003 at 07:03:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 07:03:57AM -0500, John Kim wrote:
>  struct snd_card_es968 {
> -#ifdef __ISAPNP__
> -	struct isapnp_dev *dev;
> -#endif	/* __ISAPNP__ */
> +	struct pnp_dev *dev;
>  };

What about completly removing struct snd_card_es968 and using pnp_dev
directtly instead?  sound/* is full of this overdesign and it's time
to get it follow kernel style a bit more..

>  static int __init alsa_card_es968_init(void)
>  {
>  	int cards = 0;
>  
> -#ifdef __ISAPNP__
> -	cards += isapnp_probe_cards(snd_es968_pnpids, snd_es968_isapnp_detect);
> -#else
> -	snd_printk("you have to enable ISA PnP support.\n");
> -#endif
> +	cards += pnp_register_card_driver(&es968_pnpc_driver);
>  #ifdef MODULE
>  	if (!cards)
> -		snd_printk("no ES968 based soundcards found\n");
> +		printk(KERN_ERR "no ES968 based soundcards found\n");
>  #endif
>  	return cards ? 0 : -ENODEV;
>  }

That printk is useless, you get a useful message from modprobe on
an ENODEV return anyway.

