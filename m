Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313032AbSDCDGv>; Tue, 2 Apr 2002 22:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313036AbSDCDGd>; Tue, 2 Apr 2002 22:06:33 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:58572 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313032AbSDCDGW>;
	Tue, 2 Apr 2002 22:06:22 -0500
Date: Tue, 2 Apr 2002 19:06:21 -0800
To: Greg KH <greg@kroah.com>
Cc: irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] : ir257_usb_disconnect_atomic-2.diff
Message-ID: <20020402190621.A25089@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020402182413.G24912@bougret.hpl.hp.com> <20020403030038.GA6366@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 07:00:38PM -0800, Greg KH wrote:
> On Tue, Apr 02, 2002 at 06:24:13PM -0800, Jean Tourrilhes wrote:
> > @@ -1519,33 +1544,47 @@ static void *irda_usb_probe(struct usb_d
> >  /*
> >   * The current irda-usb device is removed, the USB layer tell us
> >   * to shut it down...
> > + * One of the constraints is that when we exit this function,
> > + * we cannot use the usb_device no more. Gone. Destroyed. kfree().
> > + * Most other subsystem allow you to destroy the instance at a time
> > + * when it's convenient to you, to postpone it to a later date, but
> > + * not the USB subsystem.
> > + * So, we must make bloody sure that everything gets deactivated.
> > + * Jean II
> 
> That's one of the next things I'm going to be working on fixing :)

	By the time you will "fix" that, all the USB driver will be
fixed to workaround this issue. Actually, it force to be a bit more
careful about the disconnect, and avoid zombies instances all over the
place, so is not such a bad thing after all.

> The patch looks good.  Thanks for setting the proper GFP_* flag.

	That was Martin... Don't need to thank, because the impact is
limited to the IrDA driver...

> greg k-h

	Have fun...

	Jean
