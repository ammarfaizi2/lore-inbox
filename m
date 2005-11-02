Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbVKBKtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbVKBKtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbVKBKtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:49:18 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:53848 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751564AbVKBKtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:49:18 -0500
Date: Wed, 2 Nov 2005 13:46:17 +0300
From: Roman Kagan <rkagan@sw.ru>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051102104617.GA2098@panda.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@sw.ru>,
	David Woodhouse <dwmw2@infradead.org>,
	Duncan Sands <duncan.sands@math.u-psud.fr>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net
References: <4363F9B5.6010907@free.fr> <20051031155803.2e94069f.akpm@osdl.org> <200511011340.41266.duncan.sands@math.u-psud.fr> <1130850242.21212.29.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130850242.21212.29.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 01:04:02PM +0000, David Woodhouse wrote:
> On Tue, 2005-11-01 at 13:40 +0100, Duncan Sands wrote:
> > this code looks like a 'orrible hack to work around a common problem
> > with USB modem's of this type: if the modem is plugged in while the
> > system boots, the driver may look for firmware before the filesystem
> > holding the firmware is mounted; I guess the delay usually gives
> > the filesystem enough time to be mounted.  I'm told that the correct
> > solution is to stick the firmware in an initramfs as well. 
> 
> Why can't we request the firmware again when the device is first used,
> if it wasn't present when the driver was first loaded?

Because the firmware loading can take long, and apps may legitimately
give up opening the device after a timeout.

Besides, it doesn't look logical.  An uninitialized device is not
particularly useful for anything but initialization.  You don't create,
say, a network device for your ethernet card until you're finished with
its PCI setup, do you?

I think the async firmware loading can do the job nicely, in a generic
manner.  BTW the usbatm drivers do it already (wasn't it you who
implemented it? :), long before request_firmware_nowait() was available.
So it's only a matter of tools adjusting, which seems to be going on.

Roman.
