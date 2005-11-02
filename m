Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVKBXaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVKBXaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVKBXaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:30:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:59089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030196AbVKBXaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:30:20 -0500
Date: Wed, 2 Nov 2005 14:27:14 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: matthieu castet <castet.matthieu@free.fr>, duncan.sands@math.u-psud.fr,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051102222714.GA23543@kroah.com>
References: <4363F9B5.6010907@free.fr> <20051031155803.2e94069f.akpm@osdl.org> <200511011340.41266.duncan.sands@math.u-psud.fr> <43677257.4090506@free.fr> <20051102162958.11c1983a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102162958.11c1983a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 04:29:58PM +1100, Andrew Morton wrote:
> matthieu castet <castet.matthieu@free.fr> wrote:
> >
> > Hi Duncan,
> > 
> > Duncan Sands wrote:
> > > Hi Andrew,
> > > 
> > > 
> > > this code looks like a 'orrible hack to work around a common problem
> > > with USB modem's of this type: if the modem is plugged in while the
> > > system boots, the driver may look for firmware before the filesystem
> > 
> > No, it wasn't the problem, even when loading with insmod/modprobe the 
> > timeout occurs on some configurations. For example on 
> > http://atm.eagle-usb.org/wakka.php?wiki=TestUEagleAtmBaud123, you could 
> > see the 'firmware ueagle-atm/eagleIII.fw is not available' error.
> > 
> > It is only happen for pre-firmware modem (uea_load_firmware) ie where we 
> > just do a request_firmware in the probe without any initialisation before.
> > So the problem seems to appear when we do a request_firmware too early 
> > in the usb_probe.
> > 
> 
> Can you please work out exactly what's happening and come up with a more
> solid solution than msleep(1)?

The fix is to use the async firmware interface, no sleeping or timeouts
needed.

thanks,

greg k-h
