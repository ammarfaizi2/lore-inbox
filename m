Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVKBIEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVKBIEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVKBIEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:04:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:27583 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932624AbVKBIEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:04:51 -0500
Date: Wed, 2 Nov 2005 00:03:16 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: usbatm@lists.infradead.org, matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051102080316.GA17989@kroah.com>
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <200511020854.22799.duncan.sands@math.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511020854.22799.duncan.sands@math.u-psud.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 08:54:22AM +0100, Duncan Sands wrote:
> > > + * sometime hotplug don't have time to give the firmware the
> > > + * first time, retry it.
> > > + */
> > > +static int sleepy_request_firmware(const struct firmware **fw, 
> > > +		const char *name, struct device *dev)
> > > +{
> > > +	if (request_firmware(fw, name, dev) == 0)
> > > +		return 0;
> > > +	msleep(1000);
> > > +	return request_firmware(fw, name, dev);
> > > +}
> > 
> > No, use the async firmware download mode instead of this.  That will
> > solve all of your problems.
> 
> Hi Greg, it looks like you understand what the problem is here.  Could
> you please explain to us lesser mortals ;)

If you use the async mode, there is no timeout.  When userspace gets
around to giving you the firmware, then you continue on with the rest of
your device initialization (don't block the usb probe function though.)

Everyone should switch to that interface, then we would not have any
timeout issues anymore...

thanks,

greg k-h
