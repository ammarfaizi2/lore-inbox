Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbSLNXEF>; Sat, 14 Dec 2002 18:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266042AbSLNXEF>; Sat, 14 Dec 2002 18:04:05 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:18053 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266041AbSLNXEE>; Sat, 14 Dec 2002 18:04:04 -0500
Date: Sat, 14 Dec 2002 17:11:49 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Matthew Bell <mwsb@operamail.com>
cc: linux-parport@torque.net, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Obvious(ish): 3c515 should work if ISAPNP is a module.
In-Reply-To: <20021214201220.31330.qmail@operamail.com>
Message-ID: <Pine.LNX.4.44.0212141709250.7099-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2002, Matthew Bell wrote:

> This is valid for at least 2.4.20 and earlier; it works for me, and I
> can't see any exceptional reason why it shouldn't work when ISAPNP is a
> module.

> --- linux-2.4.19.orig/drivers/net/3c515.c       2002-02-25 19:37:59.000000000 +0000
> +++ linux-2.4.19/drivers/net/3c515.c    2002-08-03 18:24:05.000000000 +0100
> @@ -370,7 +370,7 @@
>         { "Default", 0, 0xFF, XCVR_10baseT, 10000},
>  };
> 
> -#ifdef CONFIG_ISAPNP
> +#if defined(CONFIG_ISAPNP) || defined (CONFIG_ISAPNP_MODULE)
>  static struct isapnp_device_id corkscrew_isapnp_adapters[] = {
>         {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
>                 ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5051),
[...]

It's really only obvious*ish*: If isapnp is a module but 3c515 built-in, 
you'll get link errors. The real fix for this is to do

+#ifdef __ISAPNP__

which will get all cases right.

--Kai


