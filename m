Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752101AbWCNC0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbWCNC0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWCNC0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:26:18 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:26636
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1752098AbWCNC0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:26:18 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bunk@stusta.de (Adrian Bunk)
Subject: Re: [2.6 patch] hostap_{pci,plx}.c: fix memory leaks
Cc: jkmaline@cc.hut.fi, hostap@shmoo.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20060313222841.GQ13973@stusta.de>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FIzE1-0003Ur-00@gondolin.me.apana.org.au>
Date: Tue, 14 Mar 2006 13:25:29 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> 
> +       if (pci_enable_device(pdev))
> +               return -EIO;
> +
>        hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
>        if (hw_priv == NULL)
>                return -ENOMEM;
>        memset(hw_priv, 0, sizeof(*hw_priv));
> 
> -       if (pci_enable_device(pdev))
> -               return -EIO;
> -

You've just turned it into a leak of a different kind.

Why not jump to the error exit instead?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
