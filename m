Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129438AbRB0BzA>; Mon, 26 Feb 2001 20:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRB0Byz>; Mon, 26 Feb 2001 20:54:55 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:6895 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129438AbRB0Bym>; Mon, 26 Feb 2001 20:54:42 -0500
Date: Mon, 26 Feb 2001 21:15:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Donald Becker <becker@scyld.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH] via-rhine.c: don't reference skb after passing it to netif_rx
Message-ID: <20010226211536.O8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Donald Becker <becker@scyld.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010226210441.K8692@conectiva.com.br> <Pine.LNX.4.10.10102262050220.1129-100000@vaio.greennet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <Pine.LNX.4.10.10102262050220.1129-100000@vaio.greennet>; from becker@scyld.com on Mon, Feb 26, 2001 at 08:52:39PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 26, 2001 at 08:52:39PM -0500, Donald Becker escreveu:
> On Mon, 26 Feb 2001, Arnaldo Carvalho de Melo wrote:
> 
> > Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> > 	I've just read davem's post at netdev about the brokeness of
> > referencing skbs after passing it to netif_rx, so please consider applying
> > this patch. Ah, this was just added to the Janitor's TODO list at
> 
> > --- linux-2.4.2/drivers/net/via-rhine.c	Mon Dec 11 19:38:29 2000
> > +++ linux-2.4.2.acme/drivers/net/via-rhine.c	Mon Feb 26 22:36:18 2001
> > @@ -1147,9 +1147,9 @@
> >  								 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
> >  			}
> >  			skb->protocol = eth_type_trans(skb, dev);
> > +			np->stats.rx_bytes += skb->len;
> >  			netif_rx(skb);
> >  			dev->last_rx = jiffies;
> > -			np->stats.rx_bytes += skb->len;
> >  			np->stats.rx_packets++;
> >  		}
> 
> Easier fix: 
> -			np->stats.rx_bytes += skb->len;
> +			np->stats.rx_bytes += pkt_len;
> 
> Grouping the writes to np->stats results in better cache usage.

thanks, I'll take that into account for the remaining ones and this should
be checked by the driver authors for the ones I've already sent.

- Arnaldo
