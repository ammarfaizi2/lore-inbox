Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTE0NOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTE0NOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:14:15 -0400
Received: from angband.namesys.com ([212.16.7.85]:16531 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263503AbTE0NOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:14:14 -0400
Date: Tue, 27 May 2003 17:27:27 +0400
From: Oleg Drokin <green@namesys.com>
To: Ben Collins <bcollins@debian.org>
Cc: jdike@karaya.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/* strlcpy conversion
Message-ID: <20030527132727.GA6622@namesys.com>
References: <20030526023850.GO2657@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526023850.GO2657@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, May 25, 2003 at 10:38:50PM -0400, Ben Collins wrote:

> Index: linux-2.5/arch/um/os-Linux/drivers/tuntap_user.c
> ===================================================================
> --- linux-2.5/arch/um/os-Linux/drivers/tuntap_user.c	(revision 10155)
> +++ linux-2.5/arch/um/os-Linux/drivers/tuntap_user.c	(working copy)
> @@ -143,7 +143,7 @@
>  		}
>  		memset(&ifr, 0, sizeof(ifr));
>  		ifr.ifr_flags = IFF_TAP;
> -		strncpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name) - 1);
> +		strlcpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
>  		if(ioctl(pri->fd, TUNSETIFF, (void *) &ifr) < 0){
>  			printk("TUNSETIFF failed, errno = %d", errno);
>  			close(pri->fd);

This part is bogus.
the smth_user.c files in arch/um are files that are compiled against userspace headers,
there is no way tuntap_user.c can know anything about strlcpy().
Or at least the strlcpy() forward declaration should be added to avoid a warning.

Bye,
    Oleg
