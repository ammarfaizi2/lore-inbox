Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbTAPLhX>; Thu, 16 Jan 2003 06:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbTAPLhX>; Thu, 16 Jan 2003 06:37:23 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:22795 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S266478AbTAPLhV>; Thu, 16 Jan 2003 06:37:21 -0500
Date: Thu, 16 Jan 2003 12:47:17 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Greg KH <greg@kroah.com>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, john.cagle@hp.com,
       dan.zink@hp.com
Subject: Re: [PATCH-2.4.20] PCI-X hotplug support for Compaq driver
Message-ID: <20030116114717.GC1222@tmathiasen>
References: <20030115095513.GA2761@tmathiasen> <20030115230554.GC25816@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115230554.GC25816@kroah.com>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure. I started out doing the patch for 2.5, but hit some hotplug bugs so I
decided to get it working for 2.4 first and then port it to 2.5. I'll get on
that.

A few comments below.
 
> > +static char *get_speed_string (int speed)
> > +{
> > +	switch(speed) {
> > +		case(PCI_SPEED_33MHz):
> > +			return "33MHz PCI";
> > +		case(PCI_SPEED_66MHz):
> > +			return "66MHz PCI";
> > +		case(PCI_SPEED_50MHz_PCIX):
> > +			return "50MHz PCI-X";
> > +		case(PCI_SPEED_66MHz_PCIX):
> > +			return "66MHz PCI-X";
> > +		case(PCI_SPEED_100MHz_PCIX):
> > +			return "100MHz PCI-X";
> > +		case(PCI_SPEED_133MHz_PCIX):
> > +			return "133MHz PCI-X";
> > +		default:
> > +			return "UNKNOWN";
> > +	}
> > +}
> 
> Ick, why?  Just for a debugging message?  That /proc file is on the
> short list of things to delete :)
>

I wanted the user to be able to know exactly which bus speed/mode the driver
switched to in case of a freq/mode change. Besides that it also put the info in
proc as you mention.

> > --- linux-2.4.20/drivers/hotplug/pci_hotplug.h	Thu Nov 28 17:53:13 2002
> > +++ linux-2.4.20-pcix/drivers/hotplug/pci_hotplug.h	Mon Jan  6 22:54:47 2003
> > @@ -33,9 +33,10 @@
> >  enum pci_bus_speed {
> >  	PCI_SPEED_33MHz			= 0x00,
> >  	PCI_SPEED_66MHz			= 0x01,
> > -	PCI_SPEED_66MHz_PCIX		= 0x02,
> > -	PCI_SPEED_100MHz_PCIX		= 0x03,
> > -	PCI_SPEED_133MHz_PCIX		= 0x04,
> > +	PCI_SPEED_50MHz_PCIX		= 0x02,
> > +	PCI_SPEED_66MHz_PCIX		= 0x03,
> > +	PCI_SPEED_100MHz_PCIX		= 0x04,
> > +	PCI_SPEED_133MHz_PCIX		= 0x05,
> >  	PCI_SPEED_66MHz_PCIX_266	= 0x09,
> >  	PCI_SPEED_100MHz_PCIX_266	= 0x0a,
> >  	PCI_SPEED_133MHz_PCIX_266	= 0x0b,
> 
> Where are you getting the PCI_SPEED_50MHz_PCIX value from?  I took these
> values from the Hotplug PCI draft spec.  Has 02 been reserved for 50MHz
> PCIX and the other values changed?
> 
> If it's not in the spec, I'd recommend adding it to the end of the list,
> with a big comment about why it's different from the spec values.
>

Sure, we used to ship a system that only supported 50MHz PCI-X, but I'll have
to get more details on that.

Torben

