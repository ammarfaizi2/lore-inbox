Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVDYUIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVDYUIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVDYUIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:08:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:37823 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262768AbVDYUIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:08:21 -0400
Date: Mon, 25 Apr 2005 13:07:46 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425200746.GA24433@kroah.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <426D439D.6080705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426D439D.6080705@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 03:23:09PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >Well it seems that people are starting to want to hook the reboot
> >notifier, or the device shutdown facility in order to properly shutdown
> >pci drivers to make kexec work nicer.
> >
> >So here's a patch for the PCI core that allows pci drivers to now just
> >add a "shutdown" notifier function that will be called when the system
> >is being shutdown.  It happens just after the reboot notifier happens,
> >and it should happen in the proper device tree order, so everyone should
> >be happy.
> >
> >Any objections to this patch?
> 
> Traditionally the proper place -has- been
> * the reboot notifier
> * the ->remove hook (hot unplug, and module remove)

The latter doesn't get called on power-down, which is what the recent
patches for the kexec "fixes" seem to want.

> which covers all the cases.

But do we really want every pci driver adding a reboot notifier?  It's
simple, yes, but a lot of extra code everywhere, that I'm pretty sure
the shutdown() hook was ment to handle.

> Add a ->shutdown hook is more of a hack.  If you want to introduce this 
> facility in a systematic way, introduce a 'kexec reboot' option which 
> walks the device tree and shuts down hardware.

Why would "kexec reboot" be any different from the "normal" system
shutdown?

> ->shutdown is just a piecemeal, uncoordinated effort (uncoordinated in 
> the sense that driver shutdowns occur in an undefined order).

->shutdown looks like it walks the device tree and shuts down the
hardware in the proper order, why do you think it is an undefined order?

thanks,

greg k-h
