Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWGST6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWGST6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWGST6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 15:58:50 -0400
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:23007 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030236AbWGST6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 15:58:49 -0400
Date: Wed, 19 Jul 2006 21:58:37 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nils Faerber <nils@kernelconcepts.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] Watchdog: i8xx_tco remove pci_find_device
Message-ID: <20060719195837.GA2317@infomag.infomag.iguana.be>
References: <20060719002225.85BFC201A1@srebbe.iguana.be> <20060719061154.GA2438@infomag.infomag.iguana.be> <44BDF68D.9040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BDF68D.9040104@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> > Why the pci_dev_put's? We aren't registering the PCI devices. See
> > the comment above the MODULE_DEVICE_TABLE:
> > /*
> >  * Data for PCI driver interface
> >  *
> >  * This data only exists for exporting the supported
> >  * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
> >  * register a pci_driver, because someone else might one day
> >  * want to register another driver on the same PCI id.
> >  */
> 
> Sure, but it's not registering, but telling the subsystem, we use the device, so
> that user can't hotunplug it since some driver uses it and reads and writes its
> registers. It's purpose of refcounting in pci_dev_{put,get}() (pci_dev_get is
> called in pci_get_device()).

I see now; it's the: 
#define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
that does this. Need to fix that in iTCO_wdt...

> > Since the I/O controller Hub has several functions we explicitely
> > do not register the PCI device...
> > 
> > PS: In the -mm tree there is allready a replacement for this driver...
> > Plan is to get this one into linus tree soon.
> 
> This patch is against 2.6.18-rc1-mm2. (Maybe you mean there are some patches
> coming to -rc2-mm1?)

Nope. iTCO_wdt is going to replace i8xx_tco after testing.

Greetings,
Wim.

