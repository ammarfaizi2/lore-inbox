Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUJHDG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUJHDG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUJHDCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:02:25 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:63349 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267815AbUJHC7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 22:59:15 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Driver core change request
Date: Thu, 7 Oct 2004 21:59:10 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
References: <200410062354.18885.dtor_core@ameritech.net> <20041007214004.GA23570@kroah.com>
In-Reply-To: <20041007214004.GA23570@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410072159.11578.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 October 2004 04:40 pm, Greg KH wrote:
> On Wed, Oct 06, 2004 at 11:54:18PM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > I am reworking my sysfs serio patches (trying to get dynamic psmouse
> > protocol switching) and I am wondering if we could export device_attach
> > function. Serio system allows user to request device rescan - force current
> > driver to let go off the device and find another suitable driver. Also user
> > can manually request device to be disconnected/connected to a driver. By
> > having device_attach exported I could get rid of some duplicated code.
> 
> driver_attach() is global, so I don't have a problem with making
> device_attach() global either.  Just send me a patch :)
> 

OK. BTW, while driver_attach is global it is not exported. Should I mark both
of them EXPORT_GPL_ONLY? 

> > 
> > I.e driver_probe_device is exported. Does it have a chance to be accepted?
> 
> What's wrong with doing what the pci core does in this situation and
> call driver_attach()?
> 

Well, I need to be able to work with a specific port so when I am doing

	echo -n "serio_raw" > /sys/bus/serio/devices/serio1/driver

I want only serio1 be affected, not every disconnected port that can work
with serio_raw. driver_attach() will claim all of them. 

The difference is that serio system allows you to have several drivers
that can drive the same hardware and user gets to chose which driver gets
the honors. I.e given 4 PS/2 ports in the system user might want to have
raw access to port #2 (via serio_raw) while using standard psmouse driver
for the rest of them. With PCI if you have 2 drivers and 2 exactly same
cards you do not have ability to bind first driver to one of the cards and
second driver to the other.

-- 
Dmitry
