Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbUDPVwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUDPVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:51:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263855AbUDPVtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:49:51 -0400
Message-ID: <408054F1.4050506@pobox.com>
Date: Fri, 16 Apr 2004 17:49:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: yam driver null deref
References: <20040416212507.GP20937@redhat.com>
In-Reply-To: <20040416212507.GP20937@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> --- linux-2.6.5/drivers/net/hamradio/yam.c~	2004-04-16 22:24:00.000000000 +0100
> +++ linux-2.6.5/drivers/net/hamradio/yam.c	2004-04-16 22:24:32.000000000 +0100
> @@ -919,9 +919,12 @@
>  static int yam_close(struct net_device *dev)
>  {
>  	struct sk_buff *skb;
> -	struct yam_port *yp = (struct yam_port *) dev->priv;
> +	struct yam_port *yp;
>  
> -	if (!dev || !yp)
> +	if (!dev)
> +		return -EINVAL;
> +	yp = dev->priv;
> +	if (!yp)
>  		return -EINVAL;


Ditto...  dev will never be NULL here.  And most likely not dev->priv 
either.

	Jeff



