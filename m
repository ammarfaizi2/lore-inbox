Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTAIR5t>; Thu, 9 Jan 2003 12:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbTAIR5t>; Thu, 9 Jan 2003 12:57:49 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:34501 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266939AbTAIR5r>;
	Thu, 9 Jan 2003 12:57:47 -0500
Date: Thu, 9 Jan 2003 10:06:26 -0800
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Fix socket.c compilation failure when CONFIG_NET=n
Message-ID: <20030109180626.GA24023@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030107064107.C19A73745@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107064107.C19A73745@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 03:41:07PM +0900, Miles Bader wrote:
> [I send this to Linus earlier and he ignored it; maybe you're the right
>  person...]
> 
> In net/socket.c, <linux/wireless.h> is included twice, once conditionally
> (on CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO) and once unconditionally.
> However, including <linux/wireless.h> defines WIRELESS_EXT, and this causes an
> #ifdef in `sock_ioctl' to reference `dev_ioctl', which isn't defined when
> CONFIG_NET=n, and so results in an unresolved symbol reference in that case.
> 
> The following patch fixes this by removing the unconditional include, and only
> keeping the conditional one.
> 
> Thanks,
> 
> -Miles
> 
> diff -ruN -X../cludes linux-2.5.54-moo.orig/net/socket.c linux-2.5.54-moo/net/socket.c
> --- linux-2.5.54-moo.orig/net/socket.c	2002-11-25 10:30:11.000000000 +0900
> +++ linux-2.5.54-moo/net/socket.c	2003-01-06 13:27:17.000000000 +0900
> @@ -75,7 +75,6 @@
>  #include <linux/cache.h>
>  #include <linux/module.h>
>  #include <linux/highmem.h>
> -#include <linux/wireless.h>
>  #include <linux/divert.h>
>  #include <linux/mount.h>

	This was included in 2.5.55, so I guess Linus didn't ignored you.
	Regards,

	Jean
