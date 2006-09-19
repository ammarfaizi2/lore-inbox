Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWISWBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWISWBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWISWBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:01:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9411 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751166AbWISWBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:01:46 -0400
Date: Tue, 19 Sep 2006 22:02:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 Re] drivers: add lcd display support
Message-ID: <20060919200224.GD7246@elf.ucw.cz>
References: <20060915030508.2900b9dd.maxextreme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915030508.2900b9dd.maxextreme@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please tell me if you agree.
> 
> Adds LCD Display support.
> Adds ks0108 LCD controller support.
> Adds cfag12864b LCD display support.
> 
> Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>


> diff -uprN -X linux-2.6.18-rc7/Documentation/dontdiff linux-2.6.18-rc7-vanilla/drivers/lcddisplay/cfag12864b.c linux-2.6.18-rc7/drivers/lcddisplay/cfag12864b.c
> --- linux-2.6.18-rc7-vanilla/drivers/lcddisplay/cfag12864b.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.18-rc7/drivers/lcddisplay/cfag12864b.c	2006-09-13 05:03:29.000000000 +0200
> @@ -0,0 +1,558 @@
> +/*
> + *    Filename: cfag12864b.c
> + *     Version: 0.1.0
> + * Description: cfag12864b LCD Display Driver
> + *     License: GPL

v2 or v2 and later? 

> +static const unsigned int cfag12864b_firstminor = 0;

No need to initialize to zero.

> +static const unsigned int cfag12864b_ndevices = 1;
> +static const char * cfag12864b_name = NAME;
                      ~- kill this space.

> +#define bit(n) ((unsigned char)(1<<(n)))
> +#define nobit(n) ((unsigned char)(~bit(n)))

Uh? We have generic functions for this.

> +static unsigned char cfag12864b_state = 0;

No zeros.

> +static void cfag12864b_e(unsigned char state)
> +{
> +	if(state)
          ~ missing space.

> +		cfag12864b_state |= bit(0);
> +	else
> +		cfag12864b_state &= nobit(0);
> +	cfag12864b_set();

This repeats few times, perhaps you could create helper for that?
> +static void cfag12864b_secondcontroller(unsigned char state)
> +{
> +	if(state)
> +		cfag12864b_cs2(0);
> +	else
> +		cfag12864b_cs2(1);
> +}

Is this needed?

> +		/*if(address != tmpaddress) {
> +			address = tmpaddress;
> +			cfag12864b_address(address);
> +			cfag12864b_nop();
> +		}*/
> +
> +		/*if(tmpcontroller == 0) {
> +			if(address != tmpaddress) {
> +				address = tmpaddress;
> +				cfag12864b_address(address);
> +			}
> +		}
> +		else {
> +			cfag12864b_address(tmpaddress);
> +			cfag12864b_nop();
> +		}*/

Remove unused code, do not comment it out.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
