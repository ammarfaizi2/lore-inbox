Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbTDHTRX (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTDHTRX (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:17:23 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:60424 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261584AbTDHTRW (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:17:22 -0400
Date: Tue, 8 Apr 2003 21:28:56 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67] gen_rtc compile error
In-Reply-To: <200304082120.39576.freesoftwaredeveloper@web.de>
Message-ID: <Pine.LNX.4.51L.0304082128260.20726@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.51L.0304082033140.20726@piorun.ds.pg.gda.pl>
 <200304082120.39576.freesoftwaredeveloper@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, Michael Buesch wrote:
> > When I try to build my kernel I get:
> >
> > [...]
> >
> > My kernel configuration:
> > http://piorun.ds.pg.gda.pl/~blues/config-2.5.67.txt
> 
> Battery status seems to be not available on all architectures. (I don't
> know the reason for this.) With this patch, it should compile (against
> 2.5.67):
> 
> --- drivers/char/genrtc.c.orig	2003-04-08 21:15:52.000000000 +0200
> +++ drivers/char/genrtc.c	2003-04-08 21:17:33.000000000 +0200
> @@ -486,7 +486,9 @@
>  		     "update_IRQ\t: %s\n"
>  		     "periodic_IRQ\t: %s\n"
>  		     "periodic_freq\t: %ld\n"
> +#ifdef RTC_BATT_BAD
>  		     "batt_status\t: %s\n",
> +#endif
>  		     (flags & RTC_DST_EN) ? "yes" : "no",
>  		     (flags & RTC_DM_BINARY) ? "no" : "yes",
>  		     (flags & RTC_24H) ? "yes" : "no",
> @@ -494,8 +496,11 @@
>  		     (flags & RTC_AIE) ? "yes" : "no",
>  		     irq_active ? "yes" : "no",
>  		     (flags & RTC_PIE) ? "yes" : "no",
> -		     0L /* freq */,
> -		     (flags & RTC_BATT_BAD) ? "bad" : "okay");
> +		     0L /* freq */
> +#ifdef RTC_BATT_BAD
> +		     ,(flags & RTC_BATT_BAD) ? "bad" : "okay")
> +#endif
> +		     ;
>  	if (!get_rtc_pll(&pll))
>  	    p += sprintf(p,
>  			 "PLL adjustment\t: %d\n"

Thanks for this patch.

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
