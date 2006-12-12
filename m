Return-Path: <linux-kernel-owner+w=401wt.eu-S932324AbWLLSTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWLLSTz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWLLSTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:19:54 -0500
Received: from waste.org ([66.93.16.53]:46435 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324AbWLLSTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:19:54 -0500
Date: Tue, 12 Dec 2006 12:10:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 1/6] cleanup for netconsole
Message-ID: <20061212181006.GH13687@waste.org>
References: <457E498C.1050806@bx.jp.nec.com> <457E4C01.1010206@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457E4C01.1010206@bx.jp.nec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:28:17PM +0900, Keiichi KII wrote:
> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> This patch contains the following cleanups.
>  - add __init for initialization functions(option_setup() and init_netconsole()).
>  - define name of magic number.
> 
> Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
> ---
> --- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:06.985584500 +0900
> +++ enhanced-netconsole/drivers/net/netconsole.c.cleanup	2006-12-06
> 14:34:52.561183500 +0900
> @@ -50,8 +50,14 @@ MODULE_AUTHOR("Maintainer: Matt Mackall
>  MODULE_DESCRIPTION("Console driver for network interfaces");
>  MODULE_LICENSE("GPL");
> 
> -static char config[256];
> -module_param_string(netconsole, config, 256, 0);
> +enum {
> +	MAX_PRINT_CHUNK = 1000,
> +	MAX_CONFIG_LENGTH = 256,
> +};

Converting defines to anonymous enums is generally not considered a net
improvement around here. It doesn't provide any improvement in type safety.

> 
>  static void write_msg(struct console *con, const char *msg, unsigned int len)
>  {
> @@ -75,14 +80,12 @@ static void write_msg(struct console *co
>  		return;
> 
>  	local_irq_save(flags);
> -
>  	for(left = len; left; ) {
>  		frag = min(left, MAX_PRINT_CHUNK);
>  		netpoll_send_udp(&np, msg, frag);
>  		msg += frag;
>  		left -= frag;
>  	}
> -
>  	local_irq_restore(flags);
>  }

It's not a good idea to mix unrelated changes in, especially if
they're gratuitous formatting changes.

> +static int __init init_netconsole(void)
>  {
>  	if(strlen(config))
>  		option_setup(config);

I seem to recall there was a reason for not marking that __init. It
may no longer apply.

-- 
Mathematics is the supreme nostalgia of our time.
