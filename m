Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVGRHg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVGRHg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGRHg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:36:59 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36309 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261558AbVGRHg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:36:58 -0400
Date: Mon, 18 Jul 2005 11:33:46 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [-mm patch] EXIT_CONNECTOR and FORK_CONNECTOR must depend on NET
Message-ID: <20050718113346.A13338@2ka.mipt.ru>
References: <20050717204820.GD3753@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050717204820.GD3753@stusta.de>; from bunk@stusta.de on Sun, Jul 17, 2005 at 10:48:20PM +0200
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 18 Jul 2005 11:33:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 10:48:20PM +0200, Adrian Bunk (bunk@stusta.de) wrote:
> If you select some variable, you have to ensure that the dependencies of 
> the select'ed variable are fulfilled.

Correct, thank you.
I've add Guillaume Thouvenin (author) to Cc: list.

> This patch fixes the following link error:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `cn_netlink_send':
> : undefined reference to `alloc_skb'
> drivers/built-in.o: In function `cn_netlink_send':
> : undefined reference to `netlink_broadcast'
> drivers/built-in.o: In function `cn_netlink_send':
> : undefined reference to `__kfree_skb'
> drivers/built-in.o: In function `cn_netlink_send':
> : undefined reference to `skb_over_panic'
> drivers/built-in.o: In function `cn_rx_skb':
> connector.c:(.text+0x20d809): undefined reference to `__kfree_skb'
> drivers/built-in.o: In function `cn_input':
> connector.c:(.text+0x20d91e): undefined reference to `skb_dequeue'
> drivers/built-in.o: In function `cn_init':
> connector.c:(.text+0x20dedc): undefined reference to 
> `netlink_kernel_create'
> connector.c:(.text+0x20df67): undefined reference to `sock_release'
> drivers/built-in.o: In function `kfree_skb':
> connector.c:(.text+0x20d756): undefined reference to `__kfree_skb'
> drivers/built-in.o: In function `cn_rx_skb':
> connector.c:(.text+0x20d7c8): undefined reference to `__kfree_skb'
> connector.c:(.text+0x20d87e): undefined reference to `__kfree_skb'
> drivers/built-in.o: In function `cn_fini':
> connector.c:(.text+0x20dfae): undefined reference to `sock_release'
> drivers/built-in.o: In function `w1_alloc_dev':
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.13-rc3-mm1-full/drivers/connector/Kconfig.old	2005-07-17 22:35:33.000000000 +0200
> +++ linux-2.6.13-rc3-mm1-full/drivers/connector/Kconfig	2005-07-17 22:36:12.000000000 +0200
> @@ -1,35 +1,37 @@
>  menu "Connector - unified userspace <-> kernelspace linker"
>  
>  config CONNECTOR
>  	tristate "Connector - unified userspace <-> kernelspace linker"
>  	depends on NET
>  	---help---
>  	  This is unified userspace <-> kernelspace connector working on top
>  	  of the netlink socket protocol.
>  
>  	  Connector support can also be built as a module.  If so, the module
>  	  will be called cn.ko.
>  
>  config EXIT_CONNECTOR
>  	bool "Enable exit connector"
> +	depends on NET
>  	select CONNECTOR
>  	default y
>  	---help---
>  	  It adds a connector in kernel/exit.c:do_exit() function. When a exit
>  	  occurs, netlink is used to transfer information about the process and
>  	  its parent. This information can be used by a user space application.
>  	  The exit connector can be enable/disable by sending a message to the
>  	  connector with the corresponding group id.
>  
>  config FORK_CONNECTOR
>  	bool "Enable fork connector"
> +	depends on NET
>  	select CONNECTOR
>  	default y
>  	---help---
>  	  It adds a connector in kernel/fork.c:do_fork() function. When a fork
>  	  occurs, netlink is used to transfer information about the parent and
>  	  its child. This information can be used by a user space application.
>  	  The fork connector can be enable/disable by sending a message to the
>  	  connector with the corresponding group id.
>  
>  endmenu

-- 
	Evgeniy Polyakov
