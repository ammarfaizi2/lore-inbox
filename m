Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbTIJXGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265982AbTIJXGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:06:33 -0400
Received: from gprs147-211.eurotel.cz ([160.218.147.211]:53888 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265980AbTIJXG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:06:28 -0400
Date: Thu, 11 Sep 2003 01:06:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: What happened to SUSPEND_SAVE_STATE?
Message-ID: <20030910230606.GE257@elf.ucw.cz>
References: <20030910201124.GA11449@elf.ucw.cz> <20030910204940.GA11571@elf.ucw.cz> <20030910232527.O30046@flint.arm.linux.org.uk> <20030910223640.GD257@elf.ucw.cz> <20030910234159.R30046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910234159.R30046@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
> > > --- a/drivers/pcmcia/i82365.c	Wed Sep 10 23:18:34 2003
> > > +++ b/drivers/pcmcia/i82365.c	Wed Sep 10 23:18:34 2003
> > > @@ -1351,11 +1351,27 @@
> > >  
> > >  /*====================================================================*/
> > >  
> > > +static int i82365_suspend(struct device *dev, u32 state, u32 level)
> > > +{
> > > +	int ret = 0;
> > > +	if (level == SUSPEND_SAVE_STATE)
> > > +		ret = pcmcia_socket_dev_suspend(dev, state);
> > > +	return ret;
> > > +}
> > > +
> > > +static int i82365_resume(struct device *dev, u32 level)
> > > +{
> > > +	int ret = 0;
> > > +	if (level == RESUME_RESTORE_STATE)
> > > +		ret = pcmcia_socket_dev_resume(dev);
> > > +	return ret;
> > > +}
> > > +
> > >  static struct device_driver i82365_driver = {
> > >  	.name = "i82365",
> > >  	.bus = &platform_bus_type,
> > > -	.suspend = pcmcia_socket_dev_suspend,
> > > -	.resume = pcmcia_socket_dev_resume,
> > > +	.suspend = i82365_suspend,
> > > +	.resume = i82365_resume,
> > >  };
> > >  
> > >  static struct platform_device i82365_device = {
> > 
> > I was not able to find *any* place in the tree that would call suspend
> > with SUSPEND_SAVE_STATE as level. Maybe just my grep was wrong?
> 
> It is correct for the time being.  Well, as far as the ARM tree goes.
> At the moment, the attitude towards platform devices seems to be "tough,
> live with it."  So, I have my own work-arounds, and until such time that
> mainline comes up with a solution, I'm happy.

Ok, it probably means I should not try to fix pcmcia tonight. Patrick,
what is the goal with "u32 level" in struct device_driver? Should the
code be fixed to call it with SUSPEND_SAVE_STATE etc? Or is there some
other plan?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
