Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTIVW3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbTIVW3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:29:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261287AbTIVW3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:29:09 -0400
Date: Mon, 22 Sep 2003 15:29:10 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Message-ID: <20030922222910.GA306@kroah.com>
References: <200307152214.38825.arvidjaar@mail.ru> <200308192319.01895.arvidjaar@mail.ru> <20030819194533.GA5738@kroah.com> <200308312025.41472.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308312025.41472.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 08:25:41PM +0400, Andrey Borzenkov wrote:
> On Tuesday 19 August 2003 23:45, Greg KH wrote:
> > That's what you are going to have to set the name file to in the
> > i2c_client structure, much like your patch did.  Then look at the
> > different name files in each device directory to see what kind of device
> > it is (chip, subclient, etc.)
> >
> 
> OK attached patch sets all names to just chip name for chips themselves and 
> "chipname subclient" when subclient ios registered.

Thanks, I've applied this and will send it off to Linus in a bit.


> > > 3. libsensors asks for hysteresis value. This one does not exist in sysfs
> > > (so all temp readings fail). Is it emulated by kernel or read off chip?
> >
> > The kernel is exporting all of the info that it knows about through
> > sysfs.
> 
> it just arbitrarily (re-)names them. "min" is not hysteresis; name is badly 
> chosen.

Do you have a proposed change to the current
Documentation/i2c/sysfs-interface document?  If you can think of better
names that make more sense, I'd be glad to change things to make it
easier.

> [...]
> > > 4. I do not have the slightest idea how ISA adapters look like in sysfs
> > > and where they are located. Anyone can give me example?
> >
> > They show up on the legacy bus:
> >
> > $ tree /sys/class/i2c-adapter/i2c-1/
> > /sys/class/i2c-adapter/i2c-1/
> >
> > |-- device -> ../../../devices/legacy/i2c-1
> >
> 
> This does not help much. Libsensors expects as adapter identification either 
> "i2c-N" or "isa". If I set it to "isa" I do not have any way to determine 
> sysfs path except by rescanning /sys/class/i2c-adapter every time. Having 
> /sys/class/i2-adapter/isa/... would be better, apparently it is assumed that 
> only one such adapter can exist.

No, we internally do not differentiate between isa and non-isa adapters,
so why should we force that on the user?  They work the same as far as
users notice, and now we are consistant in our naming.

thanks,

greg k-h
