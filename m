Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUDPWif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbUDPWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:36:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:5788 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263870AbUDPVtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:49:04 -0400
Date: Fri, 16 Apr 2004 22:45:06 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: rcpci45 dereference fix.
Message-ID: <20040416224506.A2769@electric-eye.fr.zoreil.com>
References: <20040416212342.GG25240@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040416212342.GG25240@redhat.com>; from davej@redhat.com on Fri, Apr 16, 2004 at 10:23:42PM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> :
> --- linux-2.6.5/drivers/net/rcpci45.c~	2004-04-16 22:22:22.000000000 +0100
> +++ linux-2.6.5/drivers/net/rcpci45.c	2004-04-16 22:23:01.000000000 +0100
> @@ -129,13 +129,14 @@
>  rcpci45_remove_one (struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata (pdev);
> -	PDPA pDpa = dev->priv;
> +	PDPA pDpa;
>  
>  	if (!dev) {
>  		printk (KERN_ERR "%s: remove non-existent device\n",
>  				dev->name);
>  		return;
>  	}
> +	pDpa = dev->priv;
>  
>  	RCResetIOP (dev);
>  	unregister_netdev (dev);

rcpci45_init_one() must succeed in order for rcpci45_remove_one() to be
issued.

If rcpci45_init_one() succeeds, dev can not be NULL.

So I'd rather see the "if (!dev) {" test removed instead of this change.

--
Ueimor
