Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSKGSSh>; Thu, 7 Nov 2002 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSKGSSh>; Thu, 7 Nov 2002 13:18:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36104 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261369AbSKGSSg>;
	Thu, 7 Nov 2002 13:18:36 -0500
Message-ID: <3DCAB001.7020400@pobox.com>
Date: Thu, 07 Nov 2002 13:25:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, phillim2@comcast.net
Subject: Re: [PATCH] Update of tms380tr / tmsisa for 2.5.45
References: <Pine.LNX.4.44.0211011511200.14458-100000@gfrw1044.bocc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:
> -			if (tms_isa_probe(dev))
> +			if (!tms_isa_probe(dev))
>  			{
> -				unregister_netdev(dev);
> -				kfree(dev);
> -			}
> -			else
>  				num++;
> +				dev = init_trdev(NULL, 0);
> +				if (!dev)
> +					return (0);



you still haven't address my comments from the last time you posted 
this:  twice you add code like the above that bails out, without 
cleaning up any prior instances of this network card.  For example if 
card #2 fails to register but cards #0 and #1 are registered and probed 
successfully, you have problems...

