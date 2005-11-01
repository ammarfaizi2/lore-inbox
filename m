Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVKAMko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVKAMko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVKAMkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:40:43 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:38119 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750778AbVKAMkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:40:43 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Tue, 1 Nov 2005 13:40:41 +0100
User-Agent: KMail/1.8.3
Cc: matthieu castet <castet.matthieu@free.fr>,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       linux-kernel@vger.kernel.org
References: <4363F9B5.6010907@free.fr> <20051031155803.2e94069f.akpm@osdl.org>
In-Reply-To: <20051031155803.2e94069f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011340.41266.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> > +/*
> > + * sometime hotplug don't have time to give the firmware the
> > + * first time, retry it.
> > + */
> > +static int sleepy_request_firmware(const struct firmware **fw, 
> > +		const char *name, struct device *dev)
> > +{
> > +	if (request_firmware(fw, name, dev) == 0)
> > +		return 0;
> > +	msleep(1000);
> > +	return request_firmware(fw, name, dev);
> > +}
> 
> egad.   Is there no better way?

this code looks like a 'orrible hack to work around a common problem
with USB modem's of this type: if the modem is plugged in while the
system boots, the driver may look for firmware before the filesystem
holding the firmware is mounted; I guess the delay usually gives
the filesystem enough time to be mounted.  I'm told that the correct
solution is to stick the firmware in an initramfs as well.  That's a
pity: it would be nice if users could just dump the firmware in an
appropriate directory and have everything work [*].  As it is, they
also have to regenerate an initramfs.

Ciao,

Duncan.

[*] For legal reasons, users usually have to download and install
the firmware themselves.  For the speedtouch modems I don't know
of any distribution which comes with the firmware preinstalled.
