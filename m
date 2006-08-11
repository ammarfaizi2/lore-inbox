Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWHKKZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWHKKZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 06:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWHKKZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 06:25:57 -0400
Received: from web37914.mail.mud.yahoo.com ([209.191.91.176]:43645 "HELO
	web37914.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932085AbWHKKZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 06:25:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ahx4/p6mytbJEJ8xNA0gq4gISwuyffZZFUcpySdFG/PmzE+hhK+vOtlp+06Dq1TTNLFLG2t1Az/HpR+6W7WjS1nF11nneHfz/OgD2p50wdA98Bukvxu6FvVY2H+atDgQmmMoHyH7zjDJkBW8ZjEaXsgAYZVw0LTumJcNeAHnLw8=  ;
Message-ID: <20060811102552.57070.qmail@web37914.mail.mud.yahoo.com>
Date: Fri, 11 Aug 2006 03:25:52 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #4
To: Jean Delvare <khali@linux-fr.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       i2c@lm-sensors.org
In-Reply-To: <20060810095603.b63b7aa1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jean Delvare <khali@linux-fr.org> wrote:

> Hi Komal,
> 
> This one ended up in my spam box once again, although with a lower
> score (using the proper type for the attachement seems to have
> helped.)
> Maybe try with a shorter list of recipients next time, and add the
> name
> of people before their address.

I hope this doesn't end up in spam box ;). 

> 
> > Attached the updated patch as per the review comments on #3 patch.
> > 
> > Please consider it for the inclusion.
> 
> Looks good, I'll take it. One remaining objection:
> 
> > +static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> > +{
> > +	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
> > +		dev->iclk = clk_get(dev->dev, "i2c_ick");
> > +		if (IS_ERR(dev->iclk)) {
> > +			dev->iclk = NULL;
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	dev->fclk = clk_get(dev->dev, "i2c_fck");
> > +	if (IS_ERR(dev->fclk)) {
> > +		if (dev->iclk != NULL) {
> > +			clk_put(dev->iclk);
> > +			dev->iclk = NULL;
> > +			return -ENODEV;
> 
> I think this return shouldn't be there.
> 
> > +		}
> > +		dev->fclk = NULL;
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> I'll fix it myself if you agree, so that you don't have to resend a
> patch. Thanks for the good work! I'll send the patch upstream at the
> end of the week, so it should show in -mm soon.

I am fine with that change. Thanx for the review.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
