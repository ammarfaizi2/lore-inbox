Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbVGAQOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbVGAQOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbVGAQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:14:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47573 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263380AbVGAQOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:14:08 -0400
Date: Fri, 1 Jul 2005 18:15:34 +0200
From: Jens Axboe <axboe@suse.de>
To: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>
Cc: paul@paulbristow.net, linux-kernel@vger.kernel.org,
       manfred.scherer@siemens.com
Subject: Re: PATCH for ide_floppy
Message-ID: <20050701161534.GJ2243@suse.de>
References: <1DoNSU-0kLq880@fwd18.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1DoNSU-0kLq880@fwd18.aul.t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01 2005, Manfred.Scherer.Mhm@t-online.de wrote:
> --- linux-2.6.12/drivers/ide/ide-floppy.c.ORIG  2005-06-17
> 21:48:29.000000000 +0200
> +++ linux-2.6.12/drivers/ide/ide-floppy.c       2005-06-25
> 03:29:45.000000000 +0200
> @@ -125,7 +125,14 @@
>  /*
>   *     Some drives require a longer irq timeout.
>   */
> +#if 0
>  #define IDEFLOPPY_WAIT_CMD             (5 * WAIT_CMD)
> +#endif
> +#if 0
> +#define IDEFLOPPY_WAIT_CMD             200     /* --ms  */
> +#endif
> +#define IDEFLOPPY_WAIT_CMD             WAIT_CMD        /* 2004/12/31
> --ms */
> +
> 
>  /*
>   *     After each failed packet command we issue a request sense
> command
> @@ -317,7 +324,13 @@
>         unsigned long flags;
>  } idefloppy_floppy_t;
> 
> +#if 0
>  #define IDEFLOPPY_TICKS_DELAY  3       /* default delay for ZIP 100 */
> +#define IDEFLOPPY_TICKS_DELAY  6       /* default delay for ZIP 100
> --ms 2005/01/01 */
> +#define IDEFLOPPY_TICKS_DELAY  12      /* default delay for ZIP 100
> --ms 2005/01/01 */
> +#endif
> +#define IDEFLOPPY_TICKS_DELAY  60      /* default delay for ZIP 100
> --ms 2005/01/07 */
> +

This seems to be basically what your patch changes, along with the
expiry addition. Neither of which should make any change in performance,
since you should normally not time commands out. Do you normally get
lots of errors or timeouts running that workload?

I don't see how your patch changes anything for a normally running
ide-floppy.

-- 
Jens Axboe

