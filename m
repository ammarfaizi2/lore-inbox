Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUDEVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbUDEVWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:22:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:19363 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262963AbUDEVUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:20:42 -0400
Date: Mon, 5 Apr 2004 12:30:04 -0700
From: Greg KH <greg@kroah.com>
To: wdebruij@dds.nl
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE] various linux kernel devtools : device handling/memory mapping/profiling/etc
Message-ID: <20040405193004.GA3545@kroah.com>
References: <1081191622.4071acc6e100c@webmail.dds.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081191622.4071acc6e100c@webmail.dds.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 09:00:22PM +0200, wdebruij@dds.nl wrote:
> 
> 
> On Monday 05 April 2004 18:23, Greg KH wrote:
> > I don't see anything in there that will work properly for udev.  Am I
> > just missing the code somewhere?  Remember, for udev to work, you have
> > to create stuff in sysfs, which I don't see this code doing.
> indeed, automatic creation of the device files is not yet incorporated under 
> udev,

Huh?

> but at least it then reverts back to the oldstyle (mknod) device file 
> system, right? That's a work in progress as my systems don't actually use 
> udev just yet.

I don't think you understand how udev works.  Who are you thinking does
the mknod of the device files?  udev does it only if it sees a file
called "dev" in sysfs for a device.  Your wrapper does not do this at
all (it could be changed to use class_simple to get it, if you so
desired.)

> > Ick, you are using pci_find_device() which is racy, depreciated, and
> > does not play nice with the rest of the kernel.  Yes, it's the lowest
> > common denominater accross 2.2, 2.4, and 2.6, but please don't sink to
> > that level if you don't have to.  For 2.6 it's just not acceptable.
> 
> hmm, really? thanks for the tip. I basically looked at O'Reilly's book
> when I coded that. Do you have a quick alternative for me to use?

pci_register_driver() as Documentation/pci.txt says to use.  Works just
wonderful from 2.4 to 2.6, and I think it's even been backported to work
on 2.2 if you so desire.

> > I agree that at times the current kernel driver api learning curve is a
> > bit steep.  But people are working to reduce that curve where they can,
> > and it's one of my main priorities for 2.7.  Any help and suggestions
> > that you might have in that area are greatly appreciated.
> >
> perhaps some of this code (when cleaned up) can serve as a guide.

Well, feel free to submit portions of it as patches that clean up the
current API, if you think it will help out any.  In my short glance, I
didn't really see anything that would help out all that much, but I'm
probably missing something.

thanks,

greg k-h
