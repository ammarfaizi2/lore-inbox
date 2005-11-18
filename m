Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVKRDwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVKRDwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVKRDwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:52:51 -0500
Received: from ozlabs.org ([203.10.76.45]:17046 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932447AbVKRDwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:52:50 -0500
Date: Fri, 18 Nov 2005 14:52:36 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: proski@gnu.org, orinoco-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: [Orinoco-devel] [2.6 patch] drivers/net/wireless/orinoco.h: "extern inline" -> "static inline"
Message-ID: <20051118035236.GB23760@localhost.localdomain>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, proski@gnu.org,
	orinoco-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, netdev@vger.kernel.org
References: <20051118033329.GU11494@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118033329.GU11494@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 04:33:29AM +0100, Adrian Bunk wrote:
> "extern inline" doesn't make much sense.

Yes it does.  "extern inline" tells gcc not to fall back to out of
line version if it can't inline the function.  These functions *must*
by inlined, or they'll break horribly on Sparc, at least.

> --- linux-2.6.15-rc1-mm1-full/drivers/net/wireless/orinoco.h.old	2005-11-18 02:38:43.000000000 +0100
> +++ linux-2.6.15-rc1-mm1-full/drivers/net/wireless/orinoco.h	2005-11-18 02:38:47.000000000 +0100
> @@ -155,7 +155,7 @@
>   * SPARC, due to its weird semantics for save/restore flags. extern
>   * inline should prevent the kernel from linking or module from
>   * loading if they are not inlined. */
> -extern inline int orinoco_lock(struct orinoco_private *priv,
> +static inline int orinoco_lock(struct orinoco_private *priv,
>  			       unsigned long *flags)
>  {
>  	spin_lock_irqsave(&priv->lock, *flags);
> @@ -168,7 +168,7 @@
>  	return 0;
>  }
>  
> -extern inline void orinoco_unlock(struct orinoco_private *priv,
> +static inline void orinoco_unlock(struct orinoco_private *priv,
>  				  unsigned long *flags)
>  {
>  	spin_unlock_irqrestore(&priv->lock, *flags);
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
