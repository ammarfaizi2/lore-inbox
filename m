Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWCRAIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWCRAIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWCRAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:08:43 -0500
Received: from waste.org ([64.81.244.121]:64159 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751742AbWCRAIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:08:43 -0500
Date: Fri, 17 Mar 2006 17:58:56 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] RTC: Remove RTC UIP synchronization on MIPS Footbridge
Message-ID: <20060317235856.GD25452@waste.org>
References: <2.132654658@selenic.com> <8.132654658@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8.132654658@selenic.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 05:30:36PM -0600, Matt Mackall wrote:
> Remove RTC UIP synchronization on MIPS Footbridge

Urgh, this is obviously ARM. And I noticed my per-patch cc:es got
lost.
 
> Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Index: rtc/arch/arm/mach-footbridge/time.c
> ===================================================================
> --- rtc.orig/arch/arm/mach-footbridge/time.c	2005-10-27 19:02:08.000000000 -0500
> +++ rtc/arch/arm/mach-footbridge/time.c	2006-03-12 13:00:51.000000000 -0600
> @@ -34,27 +34,12 @@ static int rtc_base;
>  static unsigned long __init get_isa_cmos_time(void)
>  {
>  	unsigned int year, mon, day, hour, min, sec;
> -	int i;
>  
>  	// check to see if the RTC makes sense.....
>  	if ((CMOS_READ(RTC_VALID) & RTC_VRT) == 0)
>  		return mktime(1970, 1, 1, 0, 0, 0);
>  
> -	/* The Linux interpretation of the CMOS clock register contents:
> -	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
> -	 * RTC registers show the second which has precisely just started.
> -	 * Let's hope other operating systems interpret the RTC the same way.
> -	 */
> -	/* read RTC exactly on falling edge of update flag */
> -	for (i = 0 ; i < 1000000 ; i++) /* may take up to 1 second... */
> -		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
> -			break;
> -
> -	for (i = 0 ; i < 1000000 ; i++) /* must try at least 2.228 ms */
> -		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
> -			break;
> -
> -	do { /* Isn't this overkill ? UIP above should guarantee consistency */
> +	do {
>  		sec  = CMOS_READ(RTC_SECONDS);
>  		min  = CMOS_READ(RTC_MINUTES);
>  		hour = CMOS_READ(RTC_HOURS);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Mathematics is the supreme nostalgia of our time.
