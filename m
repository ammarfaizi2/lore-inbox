Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937757AbWLFWru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937757AbWLFWru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937758AbWLFWru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:47:50 -0500
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:18790 "EHLO
	nlpi015.sbcis.sbc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937757AbWLFWrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:47:49 -0500
X-ORBL: [67.117.73.34]
Date: Wed, 6 Dec 2006 14:45:12 -0800
From: Tony Lindgren <tony@atomide.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Komal Shah <komal_shah802003@yahoo.com>,
       David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
Message-ID: <20061206224511.GC10391@atomide.com>
References: <1154689868.12791.267626769@webmail.messagingengine.com> <20060805103113.058ce8fe.khali@linux-fr.org> <20060807145832.GF10387@atomide.com> <20060810102944.a12329b9.khali@linux-fr.org> <20060810131925.GJ30195@atomide.com> <20061204184908.909bad9b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204184908.909bad9b.khali@linux-fr.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Jean Delvare <khali@linux-fr.org> [061204 09:49]:
> Hi Tony, all,
> 
> On Thu, 10 Aug 2006 16:19:26 +0300, Tony Lindgren wrote:
> > * Jean Delvare <khali@linux-fr.org> [060810 11:30]:
> > > I've now taken Komal's patch (#4). Here is a proposed patch which brings
> > > the prescaler computation formula in line with your comment and table
> > > above. It could be applied on top of Komal's patch unless it causes a
> > > problem on some of the OMAP systems. For XOR = 13 MHz, it changes the
> > > prescaler from 0 to 1. For XOR = 19.2 MHz it changes the prescaler from
> > > 2 to 1.
> > 
> > OK cool. As far as I'm concerned, I'm fine with it too:
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >  
> > > I don't have any hardware to test it, though. If it happens to be
> > > better to be slightly over 12 MHz than slightly below 7 MHz, the
> > > "> 12000000" condition below can be replaced with "> 14000000".
> > 
> > Thanks, we'll test it on various omaps and let you know if it works.
> 
> Any news on this? I still have this patch in my local tree. Should I
> push it into Linux 2.6.20?
> 
> i2c: Fix OMAP clock prescaler to match the comment
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.18-rc4.orig/drivers/i2c/busses/i2c-omap.c	2006-08-10 09:56:54.000000000 +0200
> +++ linux-2.6.18-rc4/drivers/i2c/busses/i2c-omap.c	2006-08-10 10:12:03.000000000 +0200
> @@ -231,8 +231,8 @@
>  		 * 13		2		1
>  		 * 19.2		2		1
>  		 */
> -		if (fclk_rate > 16000000)
> -			psc = (fclk_rate + 8000000) / 12000000;
> +		if (fclk_rate > 12000000)
> +			psc = fclk_rate / 12000000;
>  	}
>  
>  	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */

Sorry for the delay in replying. Yes, it's safe to push. When the original
code was done, the max limit of 12MHz was ignored.

Regards,

Tony
