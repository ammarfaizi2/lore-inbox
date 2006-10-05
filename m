Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWJEHRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWJEHRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWJEHRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:17:42 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:47506 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751519AbWJEHRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:17:41 -0400
From: Duncan Sands <baldrick@free.fr>
To: usbatm@lists.infradead.org
Subject: Re: [PATCH 1/3] UEAGLE : be suspend friendly
Date: Thu, 5 Oct 2006 09:17:35 +0200
User-Agent: KMail/1.9.4
Cc: Pavel Machek <pavel@ucw.cz>, matthieu castet <castet.matthieu@free.fr>,
       greg@kroah.com, ueagle <ueagleatm-dev@gna.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <4522BE19.1070103@free.fr> <20061004220548.GC8667@elf.ucw.cz>
In-Reply-To: <20061004220548.GC8667@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050917.36442.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > Signed-off-by: matthieu castet <castet.matthieu@free.fr>
> > Index: linux/drivers/usb/atm/ueagle-atm.c
> > ===================================================================
> > --- linux.orig/drivers/usb/atm/ueagle-atm.c	2006-09-22 21:39:56.000000000 +0200
> > +++ linux/drivers/usb/atm/ueagle-atm.c	2006-09-22 21:40:45.000000000 +0200
> > @@ -1177,6 +1177,9 @@
> >  			ret = uea_stat(sc);
> >  		if (ret != -EAGAIN)
> >  			msleep(1000);
> > + 		if (try_to_freeze())
> > +			uea_err(INS_TO_USBDEV(sc), "suspend/resume not supported, "
> > +				"please unplug/replug your modem\n");
> 
> Plug/unplug should be easy enough to simulate from usb driver, no?

if a USB driver doesn't define suspend/resume methods, then the core simply
unplugs it on suspend, and replugs on resume (IIRC).  Maybe Matthieu is trying
for something better - hopefully he will explain.  Since this is a modem, it
would be nice if the internet connection sprang back to life on resume, which
requires more work than unplug/plug.  I've no idea what needs to be done to achieve
this.  These modems use the ATM networking layer by the way, I don't know if that
makes things easier or harder.

Ciao,

Duncan.
