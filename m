Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVHLLLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVHLLLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 07:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVHLLLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 07:11:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30188 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750992AbVHLLLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 07:11:07 -0400
Date: Fri, 12 Aug 2005 13:11:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix ucb1x00 support on collie
Message-ID: <20050812111103.GD1826@elf.ucw.cz>
References: <20050731134617.GA25906@elf.ucw.cz> <20050731164245.B20106@flint.arm.linux.org.uk> <20050807150802.C22977@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807150802.C22977@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 
> > > diff --git a/drivers/misc/mcp-sa1100.c b/drivers/misc/mcp-sa1100.c
> > > --- a/drivers/misc/mcp-sa1100.c
> > > +++ b/drivers/misc/mcp-sa1100.c
> > > @@ -149,7 +149,7 @@ static int mcp_sa1100_probe(struct devic
> > >  	    !machine_is_graphicsmaster() && !machine_is_lart()           &&
> > >  	    !machine_is_omnimeter()      && !machine_is_pfs168()         &&
> > >  	    !machine_is_shannon()        && !machine_is_simpad()         &&
> > > -	    !machine_is_yopy())
> > > +	    !machine_is_yopy()		 && !machine_is_collie())
> > 
> > I think it's about time we did something better with this, like only
> > registering the platform device on those which use it.
> > 
> > > @@ -181,7 +187,10 @@ static int mcp_sa1100_probe(struct devic
> > >  
> > >  	Ser4MCSR = -1;
> > >  	Ser4MCCR1 = 0;
> > > -	Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
> > > +	if (machine_is_collie()) 
> > > +		Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
> > > +	else
> > > +		Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
> > 
> > And this setup should probably be passed as part of the platform device
> > data.
> 
> Ok, new set of patches on the ftp site with the above two items resolved.
> I've also moved it into drivers/mfd and linked that directory into
> kbuild.

Thanks, it seems to work okay here.

You still do:

Ser4MCCR0 = data->mccr0 | 0x7f7f;

...I'm not sure, but it seems to me I want MMCR0 to be set to
0x60000. Would it be better to move 7f7f constant (what is it, anyway)
to machine-specific code?

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
