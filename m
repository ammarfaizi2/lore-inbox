Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVACAx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVACAx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVACAx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:53:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:3242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261174AbVACAvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:51:04 -0500
Message-ID: <41D89586.40500@osdl.org>
Date: Sun, 02 Jan 2005 16:44:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Update to module_params() in 3c59x.c
References: <714805690.20041230154020@dns.toxicfilms.tv>
In-Reply-To: <714805690.20041230154020@dns.toxicfilms.tv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:
> Hi!
> 
> This patch:
> 1) updates the 3c59x.c driver to use module_param() stuff.
> 2) kills a strange character somewhere at the bottom of the patch
> 
> I hope it is right, it is my first glance at module_param() :-)
> 
>  3c59x.c |   67 +++++++++++++++++++++++++++++++---------------------------------
>  1 files changed, 33 insertions(+), 34 deletions(-)
> 
> Oh, in order to use the module_param() macros i had to move the variable
> before module_param.
> 
> Signed-off-by: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
> 
> Please review and hopefully apply.
> Regars,
> Maciej

Looks pretty good, a couple of minor comments below.

> diff -ru linux.orig/drivers/net/3c59x.c linux/drivers/net/3c59x.c
> --- linux.orig/drivers/net/3c59x.c      2004-12-30 15:27:40.000000000 +0100
> +++ linux/drivers/net/3c59x.c   2004-12-30 14:33:29.000000000 +0100
> @@ -240,6 +240,7 @@
>  
>  #include <linux/config.h>
>  #include <linux/module.h>
> +#include <linux/moduleparam.h>
module.h #includes moduleparam.h already so this isn't needed.

> @@ -279,21 +297,21 @@
>  
> -MODULE_PARM(debug, "i");
> +module_param(debug, int, 0);

I would make the 3rd parameter (permissions) be 0644 so that it can
be changed after the module is loaded (run-time debug flag changing).

---
~Randy
