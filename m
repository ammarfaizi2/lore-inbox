Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVJMSeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVJMSeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVJMSeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:34:08 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:16590 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751109AbVJMSeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:34:07 -0400
Date: Thu, 13 Oct 2005 22:33:54 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dallas's 1-wire bus compile error (again)
Message-ID: <20051013183353.GA32530@2ka.mipt.ru>
References: <434EA63F.10306@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <434EA63F.10306@g-house.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 13 Oct 2005 22:33:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 08:23:59PM +0200, Christian (evil@g-house.de) wrote:
> hi,
> 
> playing around with "make randconfig" (don't ask :)), i noticed the
> driver for the "Dallas's 1-wire bus" does not compile when CONFIG_NET is 
> disabled.
> 
> this was discussed earlier in
> 
>   http://www.ussg.iu.edu/hypermail/linux/kernel/0408.1/1764.html
> 
> but the discussion ended up in arguing about using "depends" over 
> "select" and the actual fix was forgotten i think.

Hmm... Could you please provide error log.
Networking is only used for netlink notifications which are disabled 
if CONFIG_NET is not set, you can find empty declarations in
w1_netlink.c

drivers/w1/Makefile has following for that case:
ifneq ($(CONFIG_NET), y)
EXTRA_CFLAGS    += -DNETLINK_DISABLED
endif


> Signed-off-by: Christian Kujau <evil@g-house.de>
> 
> thanks,
> Christian.
> -- 
> BOFH excuse #446:
> 
> Mailer-daemon is busy burning your message in hell.

> --- linux-2.6/drivers/w1/Kconfig.orig	2005-10-13 20:09:44.813986698 +0200
> +++ linux-2.6/drivers/w1/Kconfig	2005-10-13 20:10:21.613460153 +0200
> @@ -2,6 +2,7 @@ menu "Dallas's 1-wire bus"
>  
>  config W1
>  	tristate "Dallas's 1-wire support"
> +	depends on NET
>  	---help---
>  	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices
>  	  such as iButtons and thermal sensors.


-- 
	Evgeniy Polyakov
