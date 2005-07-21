Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVGUPnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVGUPnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVGUPmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:42:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40685 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261775AbVGUPke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:40:34 -0400
Date: Thu, 21 Jul 2005 17:40:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       rmk@arm.linux.org.uk, vojtech@suse.cz
Subject: Re: [patch,rfc] Support for touchscreen on sharp zaurus sl-5500
Message-ID: <20050721154028.GC21475@atrey.karlin.mff.cuni.cz>
References: <20050721052455.GB7849@elf.ucw.cz> <200507210050.26306.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507210050.26306.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +config TOUCHSCREEN_COLLIE
> > +	tristate "Collie touchscreen (for Sharp SL-5500)"
> > +	depends on MCP_UCB1200 && INPUT
> 
> I don't think you need && INPUT here.

Fixed.

> >  obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
> >  obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
> > +obj-$(CONFIG_TOUCHSCREEN_COLLIE)+= collie_ts.o
> 
> A tab would be nice.

Actually, that would break lining-up. But you have to look at
resulting file, not a patch.

> > +static int ucb1x00_ts_open(struct input_dev *idev)
> > +{
> > +	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
> > +	int ret = 0;
> > +
> > +	if (down_interruptible(&ts->sem))
> > +		return -EINTR;
> > +
> > +	if (ts->use_count++ != 0)
> > +		goto out;
> > +
> 
> Please kill both ts->sem and ts->use_count - input core already serializes
> input_open and input_close.

Done. Still have to do the kthread conversion.

> > +
> > +MODULE_PARM(adcsync, "i");
> > +MODULE_PARM_DESC(adcsync, "Enable use of ADCSYNC signal");
> 
> Die, MODULE_PARM, die!

Dead :-).
							Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
