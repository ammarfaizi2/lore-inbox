Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262265AbSJARPV>; Tue, 1 Oct 2002 13:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJARO7>; Tue, 1 Oct 2002 13:14:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262146AbSJAROf>;
	Tue, 1 Oct 2002 13:14:35 -0400
Message-ID: <3D99D923.5080200@pobox.com>
Date: Tue, 01 Oct 2002 13:19:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kent Yoder <key@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] pcnet32 cable status check
References: <Pine.LNX.4.44.0210011129330.14607-100000@ennui.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Yoder wrote:
> +static void pcnet32_watchdog(struct net_device *dev)
> +{
> +    struct pcnet32_private *lp = dev->priv;
> +
> +    /* Print the link status if it has changed */
> +    if (lp->mii)
> +	mii_check_media (&lp->mii_if, 1, 0);
> +
> +    mod_timer (&(lp->watchdog_timer), PCNET32_WATCHDOG_TIMEOUT);
> +}


Looks good ;-)

One small thing -- since you appear to test all cases for (lp->mii) 
before calling mod_timer, I don't think you need to test lp->mii inside 
the timer...

As Felipe mentioned, using the link interrupt instead of a timer is 
preferred -- but my own preference would be to apply your patch with the 
small remove-lp->mii-check fixup, and then investigate the support of 
link interrupts.  The reasoning is that, pcnet32 covers a ton of chips, 
and not all may support a link interrupt.

	Jeff



