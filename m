Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTAQQrx>; Fri, 17 Jan 2003 11:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTAQQrx>; Fri, 17 Jan 2003 11:47:53 -0500
Received: from [213.171.53.133] ([213.171.53.133]:15635 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267597AbTAQQrw>;
	Fri, 17 Jan 2003 11:47:52 -0500
Date: Fri, 17 Jan 2003 19:56:44 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Adam Belay <ambx1@neo.rr.com>
cc: Samium Gromoff <deepfire@ibe.miee.ru>, LKML <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA and isapnp cards
In-Reply-To: <20030117111854.GA22551@neo.rr.com>
Message-ID: <Pine.BSF.4.05.10301171931290.71917-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Adam Belay wrote:

> On Fri, Jan 17, 2003 at 05:47:54PM +0300, Samium Gromoff wrote:
> >        As of 2.5.58, and since no related changes were introduced, in 2.5.59
> >  the build process of alsa/sb16pnp is broken.
> > 
> >        Obviously some callbacks are still unimplemented due to the 
> >  transition to the new 2.5 isapnp subsystem.
> > 
> >        The thing which made me to write this, is the fact that the situation
> >  persists since early 2.5.5x.
> > 
> >    (as of myself, it is the last thing which keeps me from using 2.5)
> > 
> > with regards and sincere hopes, Samium Gromoff
> 
> Hi Samium,
> 
> We are currently working to address this problem.  Rulsan has posted a partial fix
> for this that you may want to use as a temporary solution.  A more complete fix is
> coming soon.
> 
> Regards,
> Adam
> 
> 
> 
> --- sound/isa/sb/sb16.c~	2003-01-04 17:32:00.000000000 +0300
> +++ sound/isa/sb/sb16.c	2003-01-09 19:25:50.000000000 +0300
Hello Adam and other.
I've just posted another patch that works for PnP cards to you and Samium.
During the work on it, i've found some bugs, but I can't solve them.
At the end of patch there is hack for drivers/pnp/driver.c look at it.
devs -  member of pnp_card_device_id struct have got more then one id for
awe32 cards and when we request first device with 
const char *id=devs[0].id it contains "CTL0031CTL0021" instead "CTL0031"
and compare_pnp_id fails on it.
This bug can be solved in other way with allocation tmp buffer in driver,
copy id from table to buffer, add to the end \0 then request for device,
but I think that it's bad way. 
Any suggestions?
And next:
if probe function fails for some reasons. PnP layer does not do all clean
ups as i think. Because just after it I do the same command and ko loads
with oops. Some points on it:
   1) pnpc_driver has been registered, but after drv->probe fail, it's not
been unregistered.
   2) There is was some patch in 2.5.59 to driver-model that changed
something and it's may be a reason, I don't know exactly. 
Best regards, Ruslan.

