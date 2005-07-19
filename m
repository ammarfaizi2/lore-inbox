Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVGSGxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVGSGxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 02:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVGSGxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 02:53:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:43208 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261931AbVGSGwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 02:52:55 -0400
Date: Tue, 19 Jul 2005 10:49:31 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/w1/w1_int.c compile error with NET=n
Message-ID: <20050719104931.A22238@2ka.mipt.ru>
References: <20050719000549.GD5031@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050719000549.GD5031@stusta.de>; from bunk@stusta.de on Tue, Jul 19, 2005 at 02:05:49AM +0200
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 19 Jul 2005 10:49:31 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 02:05:49AM +0200, Adrian Bunk (bunk@stusta.de) wrote:
> I'm seeing the following compile error in 2.6.13-rc3-mm1 (but it doesn't 
> seem to be specific to -mm) with CONFIG_NET=n:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `w1_alloc_dev':
> w1_int.c:(.text+0x65d81f): undefined reference to `netlink_kernel_create'
> w1_int.c:(.text+0x65d881): undefined reference to `sock_release'
> drivers/built-in.o: In function `w1_free_dev':
> w1_int.c:(.text+0x65d8e9): undefined reference to `sock_release'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 

Something changed...
Those functions were exported before even with NET disabled.
There is a NETLINK_DISABLE config option which guards message
sending, now it should guard socket creation too.

Thanks, Adrian, I will create a patch for it.

> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 

-- 
	Evgeniy Polyakov
