Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbUKQUzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUKQUzc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKQUxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:53:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:10383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262514AbUKQUvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:51:38 -0500
Date: Wed, 17 Nov 2004 12:51:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} Network interface for IPMI
Message-Id: <20041117125114.0c8fdf62.akpm@osdl.org>
In-Reply-To: <419BB646.3070805@mvista.com>
References: <419BB646.3070805@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <cminyard@mvista.com> wrote:
>
> IPMI is a manage standard that allows intelligent management controllers 
> to monitor things about the system (temperature, fan speed, etc.).  The 
> management controllers sit on a bus, and have addresses, and such.  
> After seeing the ugliness required for the 32-bit ioctl compatability 
> layers for 64-bit kernels, I have decided that the network interface for 
> IPMI is a good thing, as the IPMI device ioctls have pointers and 
> require ugly hacks.  None should be needed for the network interface.
> 
> This patch adds that layer.
> 
> -#define NPROTO		32		/* should be enough for now..	*/
> +#define NPROTO		64		/* should be enough for now..	*/

Boy, that was a big bump.  Was this intentional?

> +static struct ipmi_sock *ipmi_socket_create1(struct socket *sock)
> +{
> +	struct ipmi_sock *i;
> +
> +	if (atomic_read(&ipmi_nr_socks) >= 2*files_stat.max_files)
> +		return NULL;

Why this test?

> +config IPMI_SOCKET
> +	tristate "IPMI sockets"
> +	depends on IPMI_HANDLER
> +	---help---
> +	  If you say Y here, you will include support for IPMI sockets;
> +	  This way you don't have to use devices to access IPMI.  You
> +	  must also enable the IPMI message handler and a low-level
> +	  driver in the Character Drivers if you enable this.
> +	  
> +	  If unsure, say N.

Is this new kernel interface documented somewhere?
