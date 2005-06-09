Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVFIH2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVFIH2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 03:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVFIH2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 03:28:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:9154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262304AbVFIH2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 03:28:16 -0400
Date: Thu, 9 Jun 2005 00:15:23 -0700
From: Greg KH <greg@kroah.com>
To: Rui Sousa <rui.sousa@laposte.net>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       dmitry pervushin <dpervushin@ru.mvista.com>,
       linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: [RFC] SPI core
Message-ID: <20050609071523.GE22729@kroah.com>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <20050531233215.GB23881@kroah.com> <20050602040655.GE4906@jupiter.solarsys.private> <20050602045145.GA7838@kroah.com> <1117717356.5794.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117717356.5794.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:02:35PM +0200, Rui Sousa wrote:
> Hi Greg,
> 
> On Wed, 2005-06-01 at 21:51 -0700, Greg KH wrote:
> > On Thu, Jun 02, 2005 at 12:06:55AM -0400, Mark M. Hoffman wrote:
> > > * Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> > > > This code is _very_ close to just a copy of the i2c core code.  Why
> > > > duplicate it and not work with the i2c people instead?
> > > 
> > > It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
> > > reply at the time, but I do agree that SPI and I2C/SMBus are different
> > > enough to warrant independent subsystems.
> > 
> > Independant is fine.  But direct copies, including making the same
> > mistakes (i2c dev interface, i2c driver model mess) isn't :)
> 
> I have also worked on a(nother) SPI layer implementation. Like Dmitry, I
> ended up following closely the i2c implementation, so, I'm curious to
> know more details on what you call "i2c driver model mess".

The fact that the i2c drivers are not really true "drivers" in the
driver model.  We bind them by hand to the device and then register the
device with the core.  That isn't a nice thing to do...

Also the sysfs representation of the sensor stuff is tied to the i2c
sysfs code very tightly, which isn't good for other types of sensors.
It should be in the class portion of sysfs, and the recent hwmon patches
are moving it in that direction.

thanks,

greg k-h
