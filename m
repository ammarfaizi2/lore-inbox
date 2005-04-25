Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVDYUT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDYUT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVDYURL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:17:11 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:45225 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S262773AbVDYUPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:15:42 -0400
Date: Mon, 25 Apr 2005 16:11:33 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>,
       ". Linux-pm mailing list" <linux-pm@lists.osdl.org>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425201133.GB3951@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	akpm@osdl.org, cramerj@intel.com,
	USB development list <linux-usb-devel@lists.sourceforge.net>,
	Pavel Machek <pavel@ucw.cz>,
	". Linux-pm mailing list" <linux-pm@lists.osdl.org>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <426D439D.6080705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426D439D.6080705@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
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
> 
> which covers all the cases.
> 
> Add a ->shutdown hook is more of a hack.  If you want to introduce this 
> facility in a systematic way, introduce a 'kexec reboot' option which 
> walks the device tree and shuts down hardware.
> 
> ->shutdown is just a piecemeal, uncoordinated effort (uncoordinated in 
> the sense that driver shutdowns occur in an undefined order).
> 
> 	Jeff

I agree, though I think "->remove" may be more than we need.  Another
potential use of this might be to prepare devices just before removing power.

Thanks,
Adam
