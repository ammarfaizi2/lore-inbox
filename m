Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWHJEqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWHJEqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 00:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWHJEqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 00:46:34 -0400
Received: from mx1.suse.de ([195.135.220.2]:64210 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161020AbWHJEqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 00:46:33 -0400
Date: Wed, 9 Aug 2006 21:46:09 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
Message-ID: <20060810044609.GA22802@kroah.com>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809221857.GG3691@stusta.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:18:57AM +0200, Adrian Bunk wrote:
> On Wed, Aug 09, 2006 at 11:01:43PM +0100, Alan Cox wrote:
> > Ar Mer, 2006-08-09 am 23:21 +0200, ysgrifennodd Adrian Bunk:
> > > It might be a bit out of the scope of this thread, but why do some many 
> > > subsystems use the /dev/sd* namespace?
> > > 
> > > Real SCSI devices use it.
> > > The USB mass storage driver uses it.
> > 
> > USB storage is real SCSI.
> 
> Real SCSI for a developer, for a user it's USB.

So?  Users of Linux know to look for their USB storage devices in
/dev/sd* because of this.

> And things become even more confusing considering that the drive might 
> show up as /dev/sda or /dev/uba depending on the driver used.

And udev causes this to be moot, as people use the /dev/disk/by-*
symlinks, which are the same if they use the usb-storage or ub driver.

Same thing will happen for the changes that Alan is going to do (which I
think is the right thing to have happen.)

> > > libata uses it.
> > > 
> > > I'd expext SATA or PATA devices at /dev/hd* or perhaps at /dev/ata* - 
> > > but why are they at /dev/sd*?
> > 
> > ATA uses the top half of the scsi stack so ends up using the top layer
> > scsi drivers. Its probably more efficient than writing new driver
> > clones, especially as non disk ATA is also real SCSI (or very close).
> 
> You are talking about kernel<->kernel and kernel<->hardware interfaces.
> 
> I'm more concerned about the kernel<->userspace interface.
> 
> > You can use /dev/ata if you want - its just a udev problem ;)
> 
> Or by adding some manual links if using a static /dev.

Sure, but most distros don't have a static /dev anymore.

> But I'm still not getting the point why the /dev/sd* namespace has to be 
> used.

Because it has for USB storage devices since the 2.2 kernel.

Ok, 2.3, but then quickly backported to 2.2...  You want to break that
userspace interface?  :)

thanks,

greg k-h
