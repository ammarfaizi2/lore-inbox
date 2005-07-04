Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVGDSdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVGDSdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVGDSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:33:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:920 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261532AbVGDSbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:31:15 -0400
Date: Mon, 4 Jul 2005 20:27:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix IP_FIB_HASH kconfig warning
In-Reply-To: <20050703222002.GQ5346@stusta.de>
Message-ID: <Pine.LNX.4.61.0507042025180.3728@scrub.home>
References: <20050703222002.GQ5346@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 4 Jul 2005, Adrian Bunk wrote:

> --- linux-2.6.13-rc1-mm1-full/net/ipv4/Kconfig.old	2005-07-02 20:07:25.000000000 +0200
> +++ linux-2.6.13-rc1-mm1-full/net/ipv4/Kconfig	2005-07-02 20:13:05.000000000 +0200
> @@ -58,8 +58,9 @@
>  	depends on IP_ADVANCED_ROUTER
>  	default IP_FIB_HASH
>  
> -config IP_FIB_HASH
> +config ASK_IP_FIB_HASH
>  	bool "FIB_HASH"
> +	select IP_FIB_HASH
>  	---help---
>  	Current FIB is very proven and good enough for most users.
>  
> @@ -84,12 +85,9 @@
>         
>  endchoice
>  
> -# If the user does not enable advanced routing, he gets the safe
> -# default of the fib-hash algorithm.
>  config IP_FIB_HASH
>  	bool
> -	depends on !IP_ADVANCED_ROUTER
> -	default y
> +	default y if !IP_ADVANCED_ROUTER
>  
>  config IP_MULTIPLE_TABLES
>  	bool "IP: policy routing"

I'd prefer to do it without select.

config IP_FIB_HASH  
	def_bool ASK_IP_FIB_HASH || !IP_ADVANCED_ROUTER

bye, Roman
