Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVCXV0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVCXV0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVCXV0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:26:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12559 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261714AbVCXV0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:26:05 -0500
Date: Thu, 24 Mar 2005 22:26:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/input/serio/libps2.c: ps2_command: add a missing check
Message-ID: <20050324212602.GD3966@stusta.de>
References: <20050324031447.GY1948@stusta.de> <200503240013.16573.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503240013.16573.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 12:13:16AM -0500, Dmitry Torokhov wrote:
> On Wednesday 23 March 2005 22:14, Adrian Bunk wrote:
> > The Coverity checker noted that while all other uses of param in 
> > ps2_command() were guarded by a NULL check, this one wasn't.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c.old	2005-03-24 02:37:08.000000000 +0100
> > +++ linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c	2005-03-24 02:38:28.000000000 +0100
> > @@ -106,9 +106,10 @@ int ps2_command(struct ps2dev *ps2dev, u
> >  			command == PS2_CMD_RESET_BAT ? 1000 : 200))
> >  			goto out;
> >  
> > -	for (i = 0; i < send; i++)
> > -		if (ps2_sendbyte(ps2dev, param[i], 200))
> > -			goto out;
> > +	if (param)
> > +		for (i = 0; i < send; i++)
> > +			if (ps2_sendbyte(ps2dev, param[i], 200))
> > +				goto out;
> >  
> 
> I somewhat disagree on this one. If caller specified that command requires
> arguments to be sent and it does not provide them I'd rather had it OOPS on
> the spot. With receiving, however, caller does not really have control over
> number of characters coming from the device so specifying NULL allows just
> ignore whatever response there is.

Understood.

Could this be handled with a BUG_ON?

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

