Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275329AbTHMSF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275323AbTHMSDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:03:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:60838 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275322AbTHMSDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:03:00 -0400
Date: Wed, 13 Aug 2003 10:58:10 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813175810.GB3317@kroah.com>
References: <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <20030813175009.GA12128@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030813175009.GA12128@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 07:50:09PM +0200, Sam Ravnborg wrote:
> On Wed, Aug 13, 2003 at 10:31:51AM -0700, Greg KH wrote:
> > 
> > How about this patch?  If you like it I'll add the pci.h change to the
> > tree and let you take the tg3.c part.
> > 
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700) },
> Why not without the extra {}'s so something like this:
> 
> > +	PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701),
> > +	PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702),
> >  	{ 0, }
> >  };
> >  
> > +#define PCI_DEVICE(vend,dev) { \
> > +	.vendor = (vend), .device = (dev), \
> > +	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID }

No, you want to be able to add a ".driver_data = foo" after a
PCI_DEVICE() macro.  If you have the {} there, that prevents that from
happening.

thanks,

greg k-h
