Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbULTRMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbULTRMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbULTRMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:12:32 -0500
Received: from mproxy.gmail.com ([216.239.56.250]:63424 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261569AbULTRMS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:12:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lNRGGiD6qEFtsnaDSTUlkVzUSw8WPRWVpL2Q8cZyPhG/bmueFZKfyLpxPu8KJVmv0YvmZFrP75zpaC8sZ7SWNuTtIpiWLFhH44KLQ4wtoKGQ42k16Kxfw4WiQYw+m9cf1ifaRKuIX6Cf1WqFQBww2EkWQ2vuAcflT3cn3g9k2i8=
Message-ID: <8924577504122009126c40c1fe@mail.gmail.com>
Date: Mon, 20 Dec 2004 11:12:17 -0600
From: Jon Mason <jdmason@gmail.com>
Reply-To: Jon Mason <jdmason@gmail.com>
To: Richard Ems <richard.ems@mtg-marinetechnik.de>
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?"
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <41C6E2E1.8030801@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>
	 <89245775041217090726eb2751@mail.gmail.com>
	 <41C31421.7090102@mtg-marinetechnik.de>
	 <8924577504121710054331bb54@mail.gmail.com>
	 <8924577504121712527144a5cf@mail.gmail.com>
	 <41C6E2E1.8030801@mtg-marinetechnik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks correct to me.  I apologize for the oversight.


On Mon, 20 Dec 2004 15:34:09 +0100, Richard Ems
<richard.ems@mtg-marinetechnik.de> wrote:
> Hi Jon, hi list.
> 
> The following patch is what I'm trying now:
> (I added the *np declaration to your patch, is this correct?)
> 
> Thanks, Richard
> 
> --- dl2k.c,orig-save-2004.12.20 2004-12-20 09:32:19.000000000 +0100
> +++ dl2k.c      2004-12-20 15:24:39.051556188 +0100
> @@ -562,9 +562,11 @@
>   rio_tx_timeout (struct net_device *dev)
>   {
>          long ioaddr = dev->base_addr;
> +       struct netdev_private *np = dev->priv;
> 
> -       printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
> -               dev->name, readl (ioaddr + TxStatus));
> +       printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
> +               dev->name, readl (ioaddr + TxStatus), np->cur_tx,
> np->cur_rx,
> +               readl (ioaddr + DMACtrl), readw(ioaddr + IntEnable));
>          rio_free_tx(dev, 0);
>          dev->if_port = 0;
>          dev->trans_start = jiffies;
> @@ -1005,8 +1007,9 @@
>          /* PCI Error, a catastronphic error related to the bus interface
>             occurs, set GlobalReset and HostReset to reset. */
>          if (int_status & HostError) {
> -               printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
> -                       dev->name, int_status);
> +               printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d %d
> %x %x\n",
> +                       dev->name, int_status, np->cur_tx, np->cur_rx,
> +                       readl (ioaddr + DMACtrl), readw(ioaddr +
> IntEnable));
>                  writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
>                  mdelay (500);
>          }
> 
> --
> Richard Ems
> Tel: +49 40 65803 312
> Fax: +49 40 65803 392
> Richard.Ems@mtg-marinetechnik.de
> 
> MTG Marinetechnik GmbH - Wandsbeker Königstr. 62 - D 22041 Hamburg
> 
> GF Dipl.-Ing. Ullrich Keil
> Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
> USt.-IdNr.: DE 1186 70571
> 
>
