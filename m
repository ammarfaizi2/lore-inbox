Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWJBJ0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWJBJ0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWJBJ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:26:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:34747 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751007AbWJBJ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:26:42 -0400
Date: Mon, 2 Oct 2006 11:26:40 +0200
From: Karsten Keil <kkeil@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: kai.germaschewski@gmx.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN: mark as 32-bit only
Message-ID: <20061002092640.GA10395@pingi.kke.suse.de>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	kai.germaschewski@gmx.de, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20061001152116.GA4684@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061001152116.GA4684@havoc.gtf.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 11:21:16AM -0400, Jeff Garzik wrote:
> 
> Tons of ISDN drivers cast pointers to/from 32-bit values, which just
> won't work on 64-bit.
> 

NACK.

This is no problem for ISDN only some old HW drivers may not work (for most
I do not have any hardware by myself). 
I will compile all drivers again and if here are 64 bit issues I will
disable the drivers, not ISDN.

ISDN works on 64 bits, at least with following protocols:
- transparent (audio/voice)
- X.75
- HDLC
- sync PPP

Maybe some other protocols need some 64 bit cleanup, but last time I audited
the ISDN core code for 64 bit I did not saw any problems.
My main test machines are 64 bit (and SMP) and they are running ISDN servers
for sync PPP and voice data processing on different ISDN HW and drivers
(CAPI and Hisax) without any problem.

You will see still some warnings in the CAPI code, because the capi code
has dual 64/32 bit protocol format for data packets (has 2 different pointer
areas one for 64 bit one for32 bit), but this is OK.

> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> diff --git a/drivers/isdn/Kconfig b/drivers/isdn/Kconfig
> index c90afee..608588f 100644
> --- a/drivers/isdn/Kconfig
> +++ b/drivers/isdn/Kconfig
> @@ -6,7 +6,7 @@ menu "ISDN subsystem"
>  
>  config ISDN
>  	tristate "ISDN support"
> -	depends on NET
> +	depends on NET && 32BIT
>  	---help---
>  	  ISDN ("Integrated Services Digital Networks", called RNIS in France)
>  	  is a special type of fully digital telephone service; it's mostly

-- 
Karsten Keil
SuSE Labs
ISDN development
