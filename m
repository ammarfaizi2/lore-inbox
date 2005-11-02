Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbVKBIop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbVKBIop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbVKBIop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:44:45 -0500
Received: from mail1.kontent.de ([81.88.34.36]:14548 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932659AbVKBIop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:44:45 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Wed, 2 Nov 2005 09:45:28 +0100
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, Duncan Sands <duncan.sands@math.u-psud.fr>,
       usbatm@lists.infradead.org, matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <4363F9B5.6010907@free.fr> <200511020854.22799.duncan.sands@math.u-psud.fr> <20051102080316.GA17989@kroah.com>
In-Reply-To: <20051102080316.GA17989@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020945.28345.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 2. November 2005 09:03 schrieb Greg KH:
> On Wed, Nov 02, 2005 at 08:54:22AM +0100, Duncan Sands wrote:
> > > > + * sometime hotplug don't have time to give the firmware the
> > > > + * first time, retry it.
> > > > + */
> > > > +static int sleepy_request_firmware(const struct firmware **fw, 
> > > > +		const char *name, struct device *dev)
> > > > +{
> > > > +	if (request_firmware(fw, name, dev) == 0)
> > > > +		return 0;
> > > > +	msleep(1000);
> > > > +	return request_firmware(fw, name, dev);
> > > > +}
> > > 
> > > No, use the async firmware download mode instead of this.  That will
> > > solve all of your problems.
> > 
> > Hi Greg, it looks like you understand what the problem is here.  Could
> > you please explain to us lesser mortals ;)
> 
> If you use the async mode, there is no timeout.  When userspace gets
> around to giving you the firmware, then you continue on with the rest of
> your device initialization (don't block the usb probe function though.)

How would you handle errors in setting up the device?
A driver cannot reject a device after probe, yet you need to handle
errors appearing only after the firmware is in the device.

	Regards
		Oliver
