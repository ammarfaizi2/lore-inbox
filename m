Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTFKMdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTFKMdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:33:31 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:271 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264426AbTFKMd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:33:29 -0400
Date: Wed, 11 Jun 2003 13:47:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
Message-ID: <20030611134709.A9432@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1055290315109@kroah.com> <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Jun 11, 2003 at 01:37:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:37:37PM +0100, Alan Cox wrote:
> On Mer, 2003-06-11 at 01:11, Greg KH wrote:
> >  			/* user supplied value */
> >  			system_bus_speed = idebus_parameter;
> > -		} else if (pci_present()) {
> > +		} else if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) != NULL) {
> 
> That is just gross. pci_present() is far more readable even if you make
> it an inline in pci.h that is pci_find_device(PCI_ANY_ID, PCI_ANY_ID,
> NULL)

The whole surround code seems rather bogus.  Most of the drivers actually
using this are PCI ones so we _know_ pci is present when this gets
called.  And for the few other it should probably be a per-driver
thing instead, i.e. if the device hangs of a specific pci bus use
the ide busspeed, else not.
