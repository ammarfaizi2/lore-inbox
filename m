Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162332AbWHJNVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162332AbWHJNVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162328AbWHJNVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:21:14 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:3014 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1162327AbWHJNVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:21:13 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 10 Aug 2006 16:19:26 +0300
From: Tony Lindgren <tony@atomide.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Komal Shah <komal_shah802003@yahoo.com>,
       David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
Message-ID: <20060810131925.GJ30195@atomide.com>
References: <1154689868.12791.267626769@webmail.messagingengine.com> <20060805103113.058ce8fe.khali@linux-fr.org> <20060807145832.GF10387@atomide.com> <20060810102944.a12329b9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810102944.a12329b9.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [060810 11:30]:
> Hi Tony, Komal,
> 
> > Hmmm, this sounds like a bug somewhere. TRM for 5912 says the I2C clock
> > must be prescaled to be between 7 - 12 MHz [1]. The XOR input clock is
> > typically 12, 13 or 19.2 MHz. So we should have code that produces:
> > 
> > XOR Mhz	Divider	Prescaler
> > 12		1	0
> > 13		2	1
> > 19.2		2	1
> 
> Not that 13 MHz cannot actually be prescaled between 7 and 12 MHz, no
> matter how you look at it.

True :) But that's what the docs say..
 
> > Then again the original old code produces something different too [2]...
> > 
> > I suspect the original code had some hw workarounds and and later code
> > may have a conversion bug somewhere :)
> > 
> > I suggest we keep the code as is for now since it's known to work on
> > all omaps, and then submit a follow-up patch later once we have
> > verified that that code based on the TRM works on all omaps.
> 
> I've now taken Komal's patch (#4). Here is a proposed patch which brings
> the prescaler computation formula in line with your comment and table
> above. It could be applied on top of Komal's patch unless it causes a
> problem on some of the OMAP systems. For XOR = 13 MHz, it changes the
> prescaler from 0 to 1. For XOR = 19.2 MHz it changes the prescaler from
> 2 to 1.

OK cool. As far as I'm concerned, I'm fine with it too:
Signed-off-by: Tony Lindgren <tony@atomide.com>
 
> I don't have any hardware to test it, though. If it happens to be
> better to be slightly over 12 MHz than slightly below 7 MHz, the
> "> 12000000" condition below can be replaced with "> 14000000".

Thanks, we'll test it on various omaps and let you know if it works.

Tony
