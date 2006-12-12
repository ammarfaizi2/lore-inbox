Return-Path: <linux-kernel-owner+w=401wt.eu-S932408AbWLLThR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWLLThR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWLLThR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:37:17 -0500
Received: from waste.org ([66.93.16.53]:39444 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932408AbWLLThP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:37:15 -0500
Date: Tue, 12 Dec 2006 13:27:27 -0600
From: Matt Mackall <mpm@selenic.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 5/6] add "add" element in /sys/class/misc/netconsole
Message-ID: <20061212192727.GM13687@waste.org>
References: <457E498C.1050806@bx.jp.nec.com> <457E4E20.5090101@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457E4E20.5090101@bx.jp.nec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:37:20PM +0900, Keiichi KII wrote:
> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> This patch contains the following changes.
> 
> To add port dynamically, create "add" element in /sys/class/misc/netconsole.
> 
> ex)
> 1. echo "eth0" > /sys/clas/misc/netconsole/add
>    then the port is added with the default settings.

What are the default settings for target IP address?

> 2. echo "@/eth0,@192.168.0.1/" > /sys/class/misc/netconsole/add
>    then the port is added with the settings sending kernel messages
>    to 192.168.0.1 using eth0 device.
> 
> -+- /sys/class/misc/
>  |-+- netconsole/
>    |--- add       [-w-------]  If you write parameter(network interface name
>    |                           or one config parameter of netconsole), The
>    |                            port related its config is added
>    |--- port1/
>    |--- port2/
>    ...
> 
> Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
> ---
> --- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:26.874827500 +0900
> +++ enhanced-netconsole/drivers/net/netconsole.c.add	2006-12-06
> 13:33:05.661516750 +0900
> @@ -321,6 +321,50 @@ static struct miscdevice netcon_miscdev
>  	.name = "netconsole",
>  };
> 
> +static ssize_t set_netconmisc_add(struct class_device *cdev, const char *buf,
> +				  size_t count)
> +{
> +	char *target;
> +	char *target_param;
> +
> +	target_param = (char*)kmalloc(count+1, GFP_ATOMIC);

Unnecessary cast.

> +	for(i=0; i < ARRAY_SIZE(netcon_misc_attr); i++) {
> +		class_device_create_file(netcon_miscdev.class,
> +					 netcon_misc_attr[i]);
> +	}
> +

This chunk looks like it goes in an earlier patch.

-- 
Mathematics is the supreme nostalgia of our time.
