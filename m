Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWJJMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWJJMMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWJJMMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:12:48 -0400
Received: from ns.suse.de ([195.135.220.2]:42908 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965019AbWJJMMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:12:48 -0400
From: Andreas Schwab <schwab@suse.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] ixgb:  Delete IXGB_DBG() macro and call pr_debug() directly.
References: <Pine.LNX.4.64.0610100738540.7436@localhost.localdomain>
X-Yow: ..  One FISHWICH coming up!!
Date: Tue, 10 Oct 2006 14:12:41 +0200
In-Reply-To: <Pine.LNX.4.64.0610100738540.7436@localhost.localdomain> (Robert
	P. J. Day's message of "Tue, 10 Oct 2006 07:59:35 -0400 (EDT)")
Message-ID: <je4pucxtc6.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

> Remove the minimally-useful definition of IXGB_DBG() and have
> ixgb_main.c call pr_debug() directly.
>
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> ---
> diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
> index 50ffe90..fb9fde5 100644
> --- a/drivers/net/ixgb/ixgb.h
> +++ b/drivers/net/ixgb/ixgb.h
> @@ -77,12 +77,6 @@ #include "ixgb_hw.h"
>  #include "ixgb_ee.h"
>  #include "ixgb_ids.h"
>
> -#ifdef _DEBUG_DRIVER_
> -#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
                                               ^^^^^^^^
> -#else
> -#define IXGB_DBG(args...)
> -#endif
> -
>  #define PFX "ixgb: "
>  #define DPRINTK(nlevel, klevel, fmt, args...) \
>  	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
> diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
> index e09f575..d063e84 100644
> --- a/drivers/net/ixgb/ixgb_main.c
> +++ b/drivers/net/ixgb/ixgb_main.c
> @@ -1948,7 +1948,7 @@ #endif
>
>  			/* All receives must fit into a single buffer */
>
> -			IXGB_DBG("Receive packet consumed multiple buffers "
> +			pr_debug("Receive packet consumed multiple buffers "

Would perhaps be useful to retain the "ixgb:" prefix.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
