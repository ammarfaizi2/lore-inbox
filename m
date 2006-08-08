Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWHHM5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWHHM5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWHHM5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:57:36 -0400
Received: from web37915.mail.mud.yahoo.com ([209.191.91.177]:12678 "HELO
	web37915.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964878AbWHHM5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:57:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QeRVZIDUU+rrbkUZeYQUGkBspf4cpaXd/ByPLLVthVvgXOh/Vyc5Y0ntgNAaWAX23FAmT+cpGX9jD4t2vT2SEEWJucRgrlmagkBdwZlOKEjq+ZmZN7LQgcuiWX6saYUmo1d5jJilEjerR8Gf85DzGhwny9lpicJXFbdeV6ljfRw=  ;
Message-ID: <20060808125730.51136.qmail@web37915.mail.mud.yahoo.com>
Date: Tue, 8 Aug 2006 05:57:30 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
To: Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>
Cc: Komal Shah <komal_shah802003@yahoo.com>,
       David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, i2c@lm-sensors.org
In-Reply-To: <20060807145832.GF10387@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * Jean Delvare <khali@linux-fr.org> [060805 11:31]:
> > 
> > > >> +		if (armxor_rate > 16000000)
> > > >> +			psc = (armxor_rate + 8000000) / 12000000;
> > > >> +		else
> > > >> +			psc = 0;
> > > 
> > > >Can you please explain this formula?
> > > 
> > > The OMAP core uses 8-bit value to divide the system clock (SCLK)
> and
> > > generates its own sampling clock (ICLK), and the core logic is
> sampled
> > > at clock rate of the system clock for the module, divided by
> (prescaler value + 1)
> > 
> > I should have been more precise, I guess. What surprises me are the
> > numbers themselves. It's frequent to see forumlae of the form
> > "a = (b + c/2) / c" to divide with proper rounding, but here you
> have
> > 2c/3 instread of c/2. My question was more like: is it intentional,
> or a
> > typo? Also, with the code above, psc will never have value 1. The
> "if"
> > part will always compute to at least 2, and the "else" part to 0.
> Is
> > this OK?
> > 
> 
> Hmmm, this sounds like a bug somewhere. TRM for 5912 says the I2C
> clock
> must be prescaled to be between 7 - 12 MHz [1]. The XOR input clock
> is
> typically 12, 13 or 19.2 MHz. So we should have code that produces:
> 
> XOR Mhz	Divider	Prescaler
> 12	1	0
> 13	2	1
> 19.2	2	1
> 
> Then again the original old code produces something different too
> [2]...
> 
> I suspect the original code had some hw workarounds and and later
> code
> may have a conversion bug somewhere :)
> 
> I suggest we keep the code as is for now since it's known to work on
> all omaps, and then submit a follow-up patch later once we have
> verified that that code based on the TRM works on all omaps.

I have updated the driver with all other review comments except comment
on formula above by Jean. I can some part of description from Tony's
explanation along with removing the following code line

/* Set Own Address */
omap_i2c_write_reg(dev, OMAP_I2C_OA_REG, dev->own_address);
 
As it is not needed. Please confirm so that I can send the revised
patch  soon.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
