Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTEFBwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTEFBwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:52:14 -0400
Received: from ausadmmsrr504.aus.amer.dell.com ([143.166.83.91]:28174 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S262253AbTEFBwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:52:13 -0400
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <1052186678.19726.9.camel@iguana.localdomain>
From: Matt_Domsch@Dell.com
To: greg@kroah.com, mochel@osdl.org
cc: alan@redhat.com, linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Date: Mon, 5 May 2003 21:04:35 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12A9C7BD3394223-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I like this patch a _lot_ better, nice job.

Thanks.

>   Only one comment:
> > +        if (error < 0)
> > +                return error;
> > +        return count;
> > +
> > +
> > +     return count;
> > +}
> 
> Oops, lost the tabs at the end of the function :)

Duh.  Good eyes.  Fixed.

> This function will not link up a device to a driver properly within
> the driver core, only with the pci code.  So if you do this, the
> driver core still thinks you have a device that is unbound, right? 
> Also, the symlinks don't get created from the bus to the device I
> think, correct?

I think you're right.

> Unfortunatly, looking at the driver core real quickly, I don't see a
> simple way to kick the probe cycle off again for all pci devices, but
> I'm probably just missing something somewhere...

I think drivers/base/bus.c: driver_attach() is what we want, which will
walk the list of the bus's devices and run bus_match() which is
pci_bus_match() which will scan for us.  Just need to un-static
driver_attach() I expect.  Pat, does this sound right?

If that works, probe_each_pci_dev() can go away.  I'll play with it some
more.

Thanks,
Matt
-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


