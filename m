Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275372AbTHMTzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275341AbTHMTzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:55:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23734 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275332AbTHMTyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:54:14 -0400
Date: Wed, 13 Aug 2003 20:54:12 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
       davej@redhat.com, willy@debian.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk>
References: <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3A952C.4050708@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
> enums are easy  putting direct references would be annoying, but I also 
> argue it's potentially broken and wrong to store and export that 
> information publicly anyway.  The use of enums instead of pointers is 
> practically required because there is a many-to-one relationship of ids 
> to board information structs.

The hard part is that it's actually many-to-many.  The same card can have
multiple drivers.  one driver can support many cards.

Let me give you a true story that your solution needs to address.
I recently got myself a Compaq Evo with an eepro100 onboard.  So I took
my Debian 3.0 CD and tried to install on it.  Failed because the eepro
on the board had PCI IDs that were more recent than the driver.

So I took the driver module, put it on a floppy, hand-edited the binary
to replace one of the PCI IDs with the ones that came back from lspci.
Stuck the floppy back in the Evo, loaded the hacked module and finished
the install.  Then compiled a new kernel ;-)

I haven't seen anything to address this in a nicer way yet.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
