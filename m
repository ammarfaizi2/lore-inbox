Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWJKUIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWJKUIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWJKUIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:08:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161200AbWJKUIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:08:43 -0400
Date: Wed, 11 Oct 2006 13:08:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: Early keyboard initialization?
Message-Id: <20061011130832.c9e9b4d5.akpm@osdl.org>
In-Reply-To: <200610072158.55659.dtor@insightbb.com>
References: <20061006204254.GD5489@bouh.residence.ens-lyon.fr>
	<200610072158.55659.dtor@insightbb.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006 21:58:54 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> On Friday 06 October 2006 16:42, Samuel Thibault wrote:
> > Hi,
> > 
> > Is there any reason for initializing the input layer and keyboards so
> > late?  Since prevents from being able to perform alt-sysrqs early, and
> > blind people who use speakup would like to get early control over the
> > speech.  Here is the patch that they use.
> >

It'd be nice to get sysrq working as early as poss.

> It looks like the change will only work for non-USB input devices since
> USB subsystem is initialized much later.

USB is usually modular (isn't it?)

> Greg, is there a reason why USB can't be initialized earlier?

Greg's in hiding.

> Btw, I don't think we need to initialize gameport early and maybe not
> entire input but split off input/keyboard in the same fashion that
> input/serio and input/gameport are split off.
>
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > --- /usr/src/linux-2.6.18/drivers/Makefile.orig	2006-10-06 11:34:15.000000000 -0400
> > +++ drivers/Makefile	2006-10-06 11:34:15.000000000 -0400
> > @@ -27,6 +27,9 @@
> >  
> >  obj-y				+= serial/
> >  obj-$(CONFIG_PARPORT)		+= parport/
> > +obj-$(CONFIG_SERIO)		+= input/serio/
> > +obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> > +obj-$(CONFIG_INPUT)		+= input/
> >  obj-y				+= base/ block/ misc/ mfd/ net/ media/
> >  obj-$(CONFIG_NUBUS)		+= nubus/
> >  obj-$(CONFIG_ATM)		+= atm/
> > @@ -50,9 +53,6 @@
> >  obj-$(CONFIG_USB)		+= usb/
> >  obj-$(CONFIG_PCI)		+= usb/
> >  obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
> > -obj-$(CONFIG_SERIO)		+= input/serio/
> > -obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> > -obj-$(CONFIG_INPUT)		+= input/
> >  obj-$(CONFIG_I2O)		+= message/
> >  obj-$(CONFIG_RTC_LIB)		+= rtc/
> >  obj-$(CONFIG_I2C)		+= i2c/

Anyway, I'll duck this.  Samuel, an appropriate way to make this happen
would be to talk Dmitry into a patch, let it cook in his tree for a couple
of months, then merge it into 2.6.20-early.

