Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTHYSfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTHYSfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:35:47 -0400
Received: from ns.suse.de ([195.135.220.2]:24716 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261950AbTHYSfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:35:42 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limit some config options per arch.
References: <20030825111854.5c4afdac.rddunlap@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Aug 2003 20:35:36 +0200
In-Reply-To: <20030825111854.5c4afdac.rddunlap@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73smnp4mbr.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:


> diff -Naur ./drivers/char/Kconfig~itcfg ./drivers/char/Kconfig
> --- ./drivers/char/Kconfig~itcfg	Fri Aug 22 16:51:02 2003
> +++ ./drivers/char/Kconfig	Mon Aug 25 10:48:21 2003
> @@ -744,6 +744,7 @@
>  
>  config NVRAM
>  	tristate "/dev/nvram support"
> +	depends on !IA64

depends on X86 would be probably better.
(if some other archs use it too they can add themselves)

>  	---help---
>  	  If you say Y here and create a character special file /dev/nvram
>  	  with major number 10 and minor number 144 using mknod ("man mknod"),
> @@ -1000,6 +1001,7 @@
>  
>  config HANGCHECK_TIMER
>  	tristate "Hangcheck timer"
> +	depends on X86

AFAIK that's not x86 specific. It should work on other architecture too.

>  	  say Y. Information about this driver, especially important for IBM
> diff -Naur ./drivers/pnp/Kconfig~itcfg ./drivers/pnp/Kconfig
> --- ./drivers/pnp/Kconfig~itcfg	Fri Aug 22 16:56:13 2003
> +++ ./drivers/pnp/Kconfig	Mon Aug 25 11:15:37 2003
> @@ -2,6 +2,8 @@
>  # Plug and Play configuration
>  #
>  
> +if X86 && !X86_64

This should be if ISA && X86 && !X86_64

-Andi

