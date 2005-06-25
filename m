Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263329AbVFYEQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbVFYEQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbVFYEQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:16:53 -0400
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:30598 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263329AbVFYEQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:16:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Fri, 24 Jun 2005 23:16:10 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
References: <20050624051229.GA24621@kroah.com> <Pine.LNX.4.50.0506240855460.24799-100000@monsoon.he.net> <20050625032715.GB3934@kroah.com>
In-Reply-To: <20050625032715.GB3934@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506242316.10958.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 22:27, Greg KH wrote:
> On Fri, Jun 24, 2005 at 08:57:15AM -0700, Patrick Mochel wrote:
> > 
> > On Thu, 23 Jun 2005, Greg KH wrote:
> > 
> > > This adds a single file, "unbind", to the sysfs directory of every
> > > device that is currently bound to a driver.  To unbind the driver from
> > > the device, write anything to this file and they will be disconnected
> > > from each other.
> > 
> > Do you think it would be better to put the 'unbind' file in the driver's
> > directory and have it accept the bus ID of a device that it's bound to?
> > This would make it more similar to the complementary 'bind' functionality.
>

It is more complex this way. You need to do additional parsing...
 
> Yeah, you are right, I'll make that change.  Heh, symmetry, what a
> concept...
>

Actually, I think that both should be in device's directory. When unbinding
a device you normally don't care what driver it is bound to, you just want
to make sure that there is no driver bound to the device afterwards. I.e it
is a operation on device. When binding you could argue both ways, but then
again you usually have a piece of hardware you want to assign specific driver
for, so I'd say it is operation on device as well.

Also, some buses may implement other similar operatons, like rescan and
reconnect (serio/gameport buses). They are similar to "bind" except that
you do not specify driver at all. If bind/unbind is in the driver and
connect/reconnect are in the device's directory it will be complete mess.  
 
-- 
Dmitry
