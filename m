Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUE1RTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUE1RTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUE1RTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:19:12 -0400
Received: from digitalimplant.org ([64.62.235.95]:42442 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261862AbUE1RTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:19:03 -0400
Date: Fri, 28 May 2004 10:18:49 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Todd Poynor <tpoynor@mvista.com>
cc: greg@kroah.com, "" <linux-kernel@vger.kernel.org>, "" <akpm@osdl.org>
Subject: Re: [PATCH] Device runtime suspend/resume fixes try #2
In-Reply-To: <20040526182955.GA7176@slurryseal.ddns.mvista.com>
Message-ID: <Pine.LNX.4.50.0405281017290.4036-100000@monsoon.he.net>
References: <20040526182955.GA7176@slurryseal.ddns.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linux-2.6.6-orig/drivers/base/power/runtime.c	2004-05-10 11:22:58.000000000 -0700
> +++ linux-2.6.6-pm/drivers/base/power/runtime.c	2004-05-26 10:37:05.193449240 -0700
> @@ -14,7 +14,10 @@
>  {
>  	if (!dev->power.power_state)
>  		return;
> -	resume_device(dev);
> +	if (! resume_device(dev))
> +		dev->power.power_state = 0;
> +
> +	return;

You don't need to explicitly return from a void function. :)


	Pat
