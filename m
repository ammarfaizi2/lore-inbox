Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRB0CGU>; Mon, 26 Feb 2001 21:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbRB0CGD>; Mon, 26 Feb 2001 21:06:03 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:12783 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129446AbRB0CF5>; Mon, 26 Feb 2001 21:05:57 -0500
Date: Mon, 26 Feb 2001 21:26:51 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dahinds@users.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c589_cs: don't reference skb after passing it to netif_rx
Message-ID: <20010226212651.Q8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010226211058.M8692@conectiva.com.br> <3A9B0936.17170236@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A9B0936.17170236@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 26, 2001 at 08:56:06PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 26, 2001 at 08:56:06PM -0500, Jeff Garzik escreveu:
> Arnaldo Carvalho de Melo wrote:
> > --- linux-2.4.2/drivers/net/pcmcia/3c589_cs.c   Tue Feb 13 19:15:05 2001
> > +++ linux-2.4.2.acme/drivers/net/pcmcia/3c589_cs.c      Mon Feb 26 22:44:00 2001
> > @@ -992,9 +992,9 @@
> >                         (pkt_len+3)>>2);
> >                 skb->protocol = eth_type_trans(skb, dev);
> > 
> > +               lp->stats.rx_bytes += skb->len;
> >                 netif_rx(skb);
> >                 lp->stats.rx_packets++;
> > -               lp->stats.rx_bytes += skb->len;
> 
> I prefer the attached patch instead.  It makes use of the existing local
> 'pkt_len', and it checks off another item that should probably be on the
> janitor's todo list:  Set 'dev->last_rx=jiffies' immediately after
> netif_rx.

Thanks, I've added your comments and Donald one about grouping the stat
updates, as always the Janitor's TODO list is available at
http://bazar.conectiva.com.br/~acme/TODO, so get your broom and keep on
cleaning 8)

- Arnaldo
