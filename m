Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUJ3QSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUJ3QSe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUJ3QRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:17:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:42648 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261241AbUJ3P3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:29:22 -0400
Date: Fri, 29 Oct 2004 21:16:15 -0700
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: linux-kernel@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
Message-ID: <20041030041615.GH1584@kroah.com>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net> <41688985.7030607@ppp0.net> <41693CF9.10905@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41693CF9.10905@ppp0.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 03:45:29PM +0200, Jan Dittmer wrote:
> Jan Dittmer wrote:
> > Jan Dittmer wrote:
> > 
> >>Greg KH wrote:
> >>
> >>
> >>>Please just add the "rescan" support to fakephp, and everyone will be
> >>>happy...
> >>
> >>
> >>Well, I started to work on this for fun. What I currently have is a
> >>stand-alone module which rescans the pci bus on insert and enables
> >>previously disabled devices. This works (at least with my ieee1394 port).
> >>Problem is, that fakephp does not get notified about this new pci device
> >>and no new file is created in /sys/bus/pci/slots. So I'm going to add
> >>this rescan functionality directly to fakephp.
> >>Question is: where? My current idea is a fake hotplug slot "rescan" in
> >>/sys/bus/pci/slots , where you can write "1" into the "power" attribute.
> >>FWIW I've attached the standalone module and a kernel patch which rips
> >>out the pci_bus_add_device functionality from pci_bus_add_devices.
> > 
> > 
> > Well, here is a quick & dirty hack, which adds this function to
> > enable_slot in fakephp. So if you write "1" in the power attribute of
> > any slot, the whole bus gets rescanned (you still need the
> > pci_bus_add_device.patch from the previous mail).
> 
> Well one last update. This version also handles deactivation of
> subfunctions correctly, ie. when the parent should be disabled, all
> subfunctions will be disabled first.

Nice, I like it.  Care to resend this in 2 different emails, with a good
description in the subject line, and in the body of the email, and a
"Signed-off-by:" line in it too (as per the
Documentation/SubmittingPatches file) so I can apply these to the tree?

thanks,

greg k-h
