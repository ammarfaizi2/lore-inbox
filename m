Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVKBXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVKBXas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVKBXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:30:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:63697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030198AbVKBXab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:30:31 -0500
Date: Wed, 2 Nov 2005 13:39:39 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       usbatm@lists.infradead.org, matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051102213939.GB23247@kroah.com>
References: <4363F9B5.6010907@free.fr> <20051102080316.GA17989@kroah.com> <200511020945.28345.oliver@neukum.org> <200511020952.56673.duncan.sands@math.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511020952.56673.duncan.sands@math.u-psud.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 09:52:56AM +0100, Duncan Sands wrote:
> On Wednesday 2 November 2005 09:45, Oliver Neukum wrote:
> > Am Mittwoch, 2. November 2005 09:03 schrieb Greg KH:
> > > On Wed, Nov 02, 2005 at 08:54:22AM +0100, Duncan Sands wrote:
> > > > > > + * sometime hotplug don't have time to give the firmware the
> > > > > > + * first time, retry it.
> > > > > > + */
> > > > > > +static int sleepy_request_firmware(const struct firmware **fw, 
> > > > > > +		const char *name, struct device *dev)
> > > > > > +{
> > > > > > +	if (request_firmware(fw, name, dev) == 0)
> > > > > > +		return 0;
> > > > > > +	msleep(1000);
> > > > > > +	return request_firmware(fw, name, dev);
> > > > > > +}
> > > > > 
> > > > > No, use the async firmware download mode instead of this.  That will
> > > > > solve all of your problems.
> > > > 
> > > > Hi Greg, it looks like you understand what the problem is here.  Could
> > > > you please explain to us lesser mortals ;)
> > > 
> > > If you use the async mode, there is no timeout.  When userspace gets
> > > around to giving you the firmware, then you continue on with the rest of
> > > your device initialization (don't block the usb probe function though.)
> > 
> > How would you handle errors in setting up the device?
> > A driver cannot reject a device after probe, yet you need to handle
> > errors appearing only after the firmware is in the device.
> 
> Isn't that the case anyway with the sync version?

Yes.

> After all, sync loading of firmware from the probe method is
> unacceptable, since it can block khubd for a long time (also, if the
> firmware lives on a USB device that gets disconnected just as probe
> for the device that loads firmware is called, or some variation of
> this theme, couldn't horrible blockage happen?).

Yes it could.  That's why you should use the async version :)

One of these days I'll start multi-threading the device probe stuff, and
it will not be that big of a deal...[1]

thanks,

greg k-h

[1] Yes, I know the usb core and drivers will not expect this, and work
will be needed to get this working properly.
