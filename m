Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVDKNc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVDKNc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVDKNc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:32:28 -0400
Received: from postel.suug.ch ([195.134.158.23]:2492 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261699AbVDKNcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:32:18 -0400
Date: Mon, 11 Apr 2005 15:32:39 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Message-ID: <20050411133239.GM26731@postel.suug.ch>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411125932.GA19538@uganda.factory.vocord.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Evgeniy Polyakov <20050411125932.GA19538@uganda.factory.vocord.ru> 2005-04-11 16:59
> +	size = NLMSG_SPACE(sizeof(*msg) + msg->len);
> +
> +	skb = alloc_skb(size, gfp_mask);
> +	if (!skb) {
> +		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
> +		return -ENOMEM;
> +	}
> +
> +	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));

Needs same fix.

> +	size0 = sizeof(*msg) + sizeof(*ctl) + 3*sizeof(*req);
> +	
> +	size = NLMSG_SPACE(size0);
> +
> +	skb = alloc_skb(size, GFP_ATOMIC);
> +	if (!skb) {
> +		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
> +
> +		return -ENOMEM;
> +	}
> +
> +	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size - NLMSG_ALIGN(sizeof(*nlh)));

Just pass size0 instead of reverting the calculation.
