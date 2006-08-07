Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWHGQLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWHGQLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWHGQLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:11:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:395 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932189AbWHGQLY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:11:24 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: David Hollis <dhollis@davehollis.com>
Subject: Re: [PATCH] please review mcs7830 (DeLOCK USB etherner) driver
Date: Mon, 7 Aug 2006 18:11:09 +0200
User-Agent: KMail/1.9.1
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <1154962496.2496.12.camel@dhollis-lnx.sunera.com>
In-Reply-To: <1154962496.2496.12.camel@dhollis-lnx.sunera.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608071811.09978.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 16:54, David Hollis wrote:
> These values are dupes of the MII_xxxx constants from linux/mii.h.  It
> would be clearer and more consistent to use those instead

ok

> These values are device specific so you would want to define them here.
> Following the MII_xxxxx naming convention may be helpful.

ok

> > +
> > +static DEFINE_MUTEX(mcs7830_phy_mutex);
> > +
> 
> Does this need to be global?  Isn't it really just to prevent
> simultaneous access to the adapters PHY?  What if you have multiple
> adapters installed?

It's very rarely held, so I don't expect this to be a bottleneck,
even with a large number of adapters.

The implementation is slightly simpler this way, but I can move
the mutex to struct usbnet instead if you prefer.

> > +     dev->in = usb_rcvbulkpipe(dev->udev, 1);
> > +     dev->out = usb_sndbulkpipe(dev->udev, 2);
> 
> Couldn't you use usbnet_getendpoints() here.  It will also pick up the
> status pipe.

Yes. usbnet_getendpoints() didn't work at first, but I think
I found the problem with it now. I'll change that once I
have the interrupts sorted out.

> use MII_BMSR here instead of the magic value '1'.

ok

	Arnd <><
