Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWHTTnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWHTTnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWHTTnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:43:07 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:25864 "EHLO
	smtp-vbr17.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751172AbWHTTnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:43:06 -0400
Date: Sun, 20 Aug 2006 21:42:44 +0200
From: thunder7@xs4all.nl
To: Roman Zippel <zippel@linux-m68k.org>
Cc: thunder7@xs4all.nl, Helge Hafting <helgehaf@aitel.hist.no>,
       Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed, bisect finished
Message-ID: <20060820194244.GA3997@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181134.02427.ak@suse.de> <44E588AB.3050900@aitel.hist.no> <200608181255.46999.ak@suse.de> <20060819105031.GA3190@aitel.hist.no> <Pine.LNX.4.64.0608201859130.6762@scrub.home> <20060820175128.GA4217@amd64.of.nowhere> <Pine.LNX.4.64.0608202120180.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608202120180.6761@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>
Date: Sun, Aug 20, 2006 at 09:24:05PM +0200
> 
> Thanks for testing, it's a silly sign problem. gcc turned the divide into 
> an unsigned one.
> 
> bye, Roman
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> ---
>  kernel/time/ntp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6-mm/kernel/time/ntp.c
> ===================================================================
> --- linux-2.6-mm.orig/kernel/time/ntp.c
> +++ linux-2.6-mm/kernel/time/ntp.c
> @@ -41,7 +41,7 @@ static long time_reftime;		/* time at la
>  long time_adjust;
>  
>  #define CLOCK_TICK_OVERFLOW	(LATCH * HZ - CLOCK_TICK_RATE)
> -#define CLOCK_TICK_ADJUST	(((s64)CLOCK_TICK_OVERFLOW * NSEC_PER_SEC) / CLOCK_TICK_RATE)
> +#define CLOCK_TICK_ADJUST	(((s64)CLOCK_TICK_OVERFLOW * NSEC_PER_SEC) / (s64)CLOCK_TICK_RATE)
>  
>  static void ntp_update_frequency(void)
>  {
> 
This fixes my problems. Might I suggest this for the hot-fixes/
directory of 2.6.18-rc4-mm2?

Kind regards,
Jurriaan
-- 
Borg-Cola: Not the choice of The Next Generation.
Debian (Unstable) GNU/Linux 2.6.18-rc4-mm2 4423 bogomips load 0.57
