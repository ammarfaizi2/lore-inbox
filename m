Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275494AbTHMU3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275499AbTHMU3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:29:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8887 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275494AbTHMU3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:29:33 -0400
Message-ID: <3F3A9FA1.8000708@pobox.com>
Date: Wed, 13 Aug 2003 16:29:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com> <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
> 
>>enums are easy  putting direct references would be annoying, but I also 
>>argue it's potentially broken and wrong to store and export that 
>>information publicly anyway.  The use of enums instead of pointers is 
>>practically required because there is a many-to-one relationship of ids 
>>to board information structs.
> 
> 
> The hard part is that it's actually many-to-many.  The same card can have
> multiple drivers.  one driver can support many cards.

pci_device_tables are (and must be) at per-driver granularity.  Sure the 
same card can have multiple drivers, but that doesn't really matter in 
this context, simply because I/we cannot break that per-driver 
granularity.  Any solution must maintain per-driver granularity.


> Let me give you a true story that your solution needs to address.
> I recently got myself a Compaq Evo with an eepro100 onboard.  So I took
> my Debian 3.0 CD and tried to install on it.  Failed because the eepro
> on the board had PCI IDs that were more recent than the driver.
> 
> So I took the driver module, put it on a floppy, hand-edited the binary
> to replace one of the PCI IDs with the ones that came back from lspci.
> Stuck the floppy back in the Evo, loaded the hacked module and finished
> the install.  Then compiled a new kernel ;-)
> 
> I haven't seen anything to address this in a nicer way yet.

Well, the step I wish to take - moving the ids from location X to 
location Y, would have no effect on that scenario, positive or negative.

	Jeff



