Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTCDWqh>; Tue, 4 Mar 2003 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbTCDWqh>; Tue, 4 Mar 2003 17:46:37 -0500
Received: from havoc.daloft.com ([64.213.145.173]:19599 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262812AbTCDWqf>;
	Tue, 4 Mar 2003 17:46:35 -0500
Date: Tue, 4 Mar 2003 17:57:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs
Message-ID: <20030304225659.GB7120@gtf.org>
References: <1046753776.12441.92.camel@iguana> <Pine.LNX.4.44.0303041414270.23375-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303041414270.23375-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 02:22:13PM -0600, Kai Germaschewski wrote:
> On 3 Mar 2003, Matt Domsch wrote:
> 
> > /sys
> > `-- bus
> >     `-- pci
> >         `-- drivers
> >             `-- 3c59x
> >                 |-- dynamic_id_0  (these are simple DRIVER_ATTRs)
> >                 |-- dynamic_id_1
> >                 |-- dynamic_id_2
> >                 `-- new_id
> > 
> > Where dynamic_id_[012] are new dynamic entries, created by writing
> > values into new_id.  Both file types would be of the format (analogous
> > to pci_show_resources):
> > echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" > new_id
> > with fields being vendor, device, subvendor, subdevice, class,
> > class_mask.
> 
> I dont' think what you actually want is changing the id table - after all, 
> it's only walked when registering the driver (+ hotplug).
> 
> What you really want is a way to call the drivers' probe routine for a 
> device which isn't in its tables.
> 
> So why not simply
> 
> echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" > .../3c59x/probe

I think there is value in decoupling the two operations:

	echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" > .../3c59x/table
	echo 1 > .../3c59x/probe_it

Because you want the id table additions to be persistant in the face of
cardbus unplug/replug, and for the case where cardbus card may not be
present yet, but {will,may} be soon.

	Jeff



