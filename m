Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317835AbSGPOAc>; Tue, 16 Jul 2002 10:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSGPOAb>; Tue, 16 Jul 2002 10:00:31 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28614 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317835AbSGPOAa>;
	Tue, 16 Jul 2002 10:00:30 -0400
Date: Tue, 16 Jul 2002 10:58:19 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GENERIC HDLC LAYER] Messages of a hdlc device
Message-ID: <20020716135818.GB1231@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
References: <200207151111.22555.henrique@cyclades.com> <m37kjvg6nq.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37kjvg6nq.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 16, 2002 at 03:10:33PM +0200, Krzysztof Halasa escreveu:
> henrique <henrique@cyclades.com> writes:
> 
> > I'm using the generic hdlc layer with PPP protocol against a Lucent MAX6000. 
> > Everything works OK but there a kernel message bothering me:
> > 
> > 	protocol 0008 is buggy, dev hdlc0
> > 
> > I get this message nearly once per minute.
> > 
> > Do anyone know what is this message about ?
 
> Not sure what exactly causes it. I was getting it while running tcpdump
> on PPP device.

This is becoming a FAQ... see net/core/dev.c, line 907 on 2.5:

    /* skb->nh should be correctly
       set by sender, so that the second statement is
       just protection against buggy protocols.
     */
    skb2->mac.raw = skb2->data;

    if (skb2->nh.raw < skb2->data || skb2->nh.raw > skb2->tail) {
            if (net_ratelimit())
                    printk(KERN_DEBUG "protocol %04x is buggy, dev %s\n",
			   skb2->protocol, dev->name);
            skb2->nh.raw = skb2->data;
    }

- Arnaldo
