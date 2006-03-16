Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752246AbWCPIYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbWCPIYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbWCPIYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:24:16 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:25294 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751025AbWCPIYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:24:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VMScRSCfYtmNp52x0nWHeavliOOttMtxH/G9lSa0pw/Ctfbf6fZ3ZLqr69BJATgkvjdKUtI0DaUKQ15d50W2vojIBJTLEFVxvGvi+FrvujpmXbEK/0xXPZGeiV9UkVEceWB+c/F2gyk57ElUCxubx8lhqsXavxDCipUNd/sZFA8=
Date: Thu, 16 Mar 2006 11:24:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org,
       Thomas Osterried DL9SAU <thomas@x-berg.in-berlin.de>,
       Ralf Baechle DL5RB <ralf@linux-mips.org>,
       Hans Alblas PE1AYX <hans@esrac.ele.tue.nl>
Subject: Re: [PATCH] Hamradio: Fix a NULL pointer dereference in net/hamradio/mkiss.c
Message-ID: <20060316082413.GA7789@mipter.zuzino.mipt.ru>
References: <20060316064211.GA22681@eugeneteo.net> <20060316070737.GA22920@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316070737.GA22920@eugeneteo.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 03:07:37PM +0800, Eugene Teo wrote:
> Pointer ax is dereferenced before NULL check.
>
> Coverity bug #817

> --- linux-2.6/drivers/net/hamradio/mkiss.c
> +++ linux-2.6/drivers/net/hamradio/mkiss.c
> @@ -845,13 +845,15 @@ static int mkiss_ioctl(struct tty_struct
>  	unsigned int cmd, unsigned long arg)
>  {
>  	struct mkiss *ax = mkiss_get(tty);
> -	struct net_device *dev = ax->dev;
> +	struct net_device *dev;
>  	unsigned int tmp, err;
>
>  	/* First make sure we're connected. */
>  	if (ax == NULL)
>  		return -ENXIO;
>
> +	dev = ax->dev;
> +

Actual codepath, please... valid "ax" is plonked into ->disc_data in
mkiss_open().

