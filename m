Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVC2GsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVC2GsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVC2GsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:48:03 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:23405 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262365AbVC2Grv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:47:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WHSkpey46qq5UaJyC7U00frhgjEH+Q1+qGZhpODyYmsi8HRWw0ztuQhWijpF+bNQ8e38dEoVc5j7AfBp/1tLDml2MDd9WF8N38+fO5ezp+fclr2jn1iRMyNGnSFk6ORw7UvMtDuEWmMWDkJ1gPblDz20NmWTNYH2gCsH8Srj3zs=
Message-ID: <2a0fbc5905032822477759310c@mail.gmail.com>
Date: Tue, 29 Mar 2005 08:47:51 +0200
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: How's the nforce4 support in Linux?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42456E1B.9070000@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <1111792854.23430.32.camel@mindpipe>
	 <2a0fbc5905032516174f064e23@mail.gmail.com>
	 <42456E1B.9070000@stud.feec.vutbr.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005 15:13:47 +0100, Michal Schmidt
<xschmi00@stud.feec.vutbr.cz> wrote:
> Julien Wajsberg wrote:
> > Good point... I just tried, but forcedeth doesn't support netpoll. If
> > you have a pointer, I could try to implement it ;-)
> 
> Can you try the attached patch for forcedeth?
> It compiles for me, but I don't have nForce hardware to test it.

Okay, it works :)
maybe I'll have something for you to debug at the next crash...

-- 
Julien


> --- linux-2.6.12-rc1/drivers/net/forcedeth.c.orig       2005-03-26 15:00:12.000000000 +0100
> +++ linux-2.6.12-rc1/drivers/net/forcedeth.c    2005-03-26 15:08:56.000000000 +0100
> @@ -1480,6 +1480,13 @@ static void nv_do_nic_poll(unsigned long
>         enable_irq(dev->irq);
>  }
> 
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +static void nv_poll_controller(struct net_device *dev)
> +{
> +       nv_do_nic_poll((long) dev);
> +}
> +#endif
> +
>  static void nv_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
>  {
>         struct fe_priv *np = get_nvpriv(dev);
> @@ -1962,6 +1969,9 @@ static int __devinit nv_probe(struct pci
>         dev->get_stats = nv_get_stats;
>         dev->change_mtu = nv_change_mtu;
>         dev->set_multicast_list = nv_set_multicast;
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +       dev->poll_controller = nv_poll_controller;
> +#endif
>         SET_ETHTOOL_OPS(dev, &ops);
>         dev->tx_timeout = nv_tx_timeout;
>         dev->watchdog_timeo = NV_WATCHDOG_TIMEO;
> 
> 
>
