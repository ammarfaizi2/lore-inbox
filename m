Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUIWVDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUIWVDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUIWVDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:03:46 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:35744 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S267335AbUIWVAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:00:11 -0400
Date: Thu, 23 Sep 2004 22:59:58 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: davem@davemloft.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ArcNet and 2.6.8.1
In-Reply-To: <20040924.001627.113803491.yoshfuji@linux-ipv6.org>
Message-Id: <Pine.OSF.4.05.10409232258030.21511-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I got the arcnet device running labtop computer froze up. I have
turned off preemtion and SMP. It seems to make it more stable but I can't
be conclusive.

Esben


On Fri, 24 Sep 2004, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:

> Hello.
> 
> In article <Pine.OSF.4.05.10409231534150.5114-100000@da410.ifa.au.dk> (at Thu, 23 Sep 2004 17:08:47 +0200 (METDST)), Esben Nielsen <simlo@phys.au.dk> says:
> 
> >  I am trying to upgrade my labtop to 2.6.8.1. I have ArcNet COM20020
> > PCMCIA card. After editing /etc/pcmcia/config to make it know about the
> > module, it finds the com20020 with no problems but as soon as I try to
> > start the network device the ifconfig process crashes.
> :
> > I fixed it by changing
> > 	lp->hw.open(dev);
> > to
> > 	if(lp->hw.open) {
> > 		lp->hw.open(dev);
> > 	}
> 
> Thanks.
> 
> Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> 
> ===== drivers/net/arcnet/arcnet.c 1.18 vs edited =====
> --- 1.18/drivers/net/arcnet/arcnet.c	2004-07-01 13:18:14 +09:00
> +++ edited/drivers/net/arcnet/arcnet.c	2004-09-24 00:11:35 +09:00
> @@ -401,7 +401,8 @@
>  	lp->rfc1201.sequence = 1;
>  
>  	/* bring up the hardware driver */
> -	lp->hw.open(dev);
> +	if (lp->hw.open)
> +		lp->hw.open(dev);
>  
>  	if (dev->dev_addr[0] == 0)
>  		BUGMSG(D_NORMAL, "WARNING!  Station address 00 is reserved "
> 
> -- 
> Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
> GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
> 

