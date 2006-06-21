Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWFUTAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWFUTAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWFUTAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:00:17 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:9997 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932568AbWFUTAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:00:15 -0400
Date: Wed, 21 Jun 2006 21:00:12 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: PATCH: Re: Memory corruption in 8390.c ? (and hp100 xirc2ps smc9194 ....)
Message-ID: <20060621190012.GA94169@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, netdev@oss.sgi.com
References: <1150907317.8320.0.camel@alice> <1150909982.15275.100.camel@localhost.localdomain> <87mzc65soy.fsf@benpfaff.org> <1150912780.15275.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150912780.15275.108.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:59:40PM +0100, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/8390.c linux-2.6.17/drivers/net/8390.c
> --- linux.vanilla-2.6.17/drivers/net/8390.c	2006-06-19 17:17:32.000000000 +0100
> +++ linux-2.6.17/drivers/net/8390.c	2006-06-21 17:41:12.007145384 +0100
> @@ -275,12 +275,14 @@
>  	struct ei_device *ei_local = (struct ei_device *) netdev_priv(dev);
>  	int send_length = skb->len, output_page;
>  	unsigned long flags;
> +	char buf[ETH_ZLEN];
> +	char *data = skb->data;
>  
>  	if (skb->len < ETH_ZLEN) {
> -		skb = skb_padto(skb, ETH_ZLEN);
> -		if (skb == NULL)
> -			return 0;
> +		memset(buf, 0, ETH_ZLEN);	/* more efficient than doing just the needed bits */
> +		memcpy(buf, data, ETH_ZLEN);
                                  ^^^^^^^^
send_length surely?

>  		send_length = ETH_ZLEN;
> +		data = buf;
>  	}
>  
>  	/* Mask interrupts from the ethercard. 

  OG.
