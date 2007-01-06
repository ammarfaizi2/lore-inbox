Return-Path: <linux-kernel-owner+w=401wt.eu-S1750930AbXAFAAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbXAFAAl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbXAFAAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:00:41 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:51357 "EHLO
	mx2.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbXAFAAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:00:40 -0500
Date: Fri, 5 Jan 2007 16:00:36 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO code cleanups
In-Reply-To: <20070105235604.GA24091@Ahmed>
Message-ID: <Pine.LNX.4.64N.0701051559080.27059@attu4.cs.washington.edu>
References: <20070105235604.GA24091@Ahmed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, Ahmed S. Darwish wrote:

> @@ -791,17 +790,15 @@ static int tty_ldisc_try(struct tty_struct *tty)
>  {
>  	unsigned long flags;
>  	struct tty_ldisc *ld;
> -	int ret = 0;
>  	
>  	spin_lock_irqsave(&tty_ldisc_lock, flags);
>  	ld = &tty->ldisc;
> -	if(test_bit(TTY_LDISC, &tty->flags))
> -	{
> +	if(test_bit(TTY_LDISC, &tty->flags)) {
>  		ld->refcount++;
> -		ret = 1;
> +		return 1;
>  	}
>  	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
> -	return ret;
> +	return 0;
>  }
>  
>  /**

You leave tty_ldisk_lock locked.
