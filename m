Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292783AbSB0TRS>; Wed, 27 Feb 2002 14:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292899AbSB0TRA>; Wed, 27 Feb 2002 14:17:00 -0500
Received: from b.smtp-out.sonic.net ([208.201.224.39]:63874 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S292817AbSB0TQY>; Wed, 27 Feb 2002 14:16:24 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Wed, 27 Feb 2002 11:15:26 -0800
From: dhinds <dhinds@sonic.net>
To: linux-kernel@vger.rutgers.edu
Subject: Re: pcmcia problems with IDE & cardbus
Message-ID: <20020227111526.B13182@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:

> "unable to get IRQ 10" is somewhat funny, since IRQ-10 is used by 
> the cardbus device. what I don't understand is if the IDE-drive 
> sould get its own interrupt or not. 

The card should (must) share the PCI interrupt with the CardBus bridge
device.  However, the IDE driver assumes that it should have exclusive
use of the interrupt, because it doesn't believe that this is a PCI
IDE device (well, it is sort of an ISA IDE device sitting behind a PCI
bridge).

> and finally an ugly detail: when removing the ComapctFlash and 
> unloading pcmcia, ide_cs will still have the ioport-ressources 
> clailed form /proc/ioport. seems there's a call to *_unregister 
> missing. 

The ide_cs driver does call ide_unregister().  The problem is that the
IDE driver doesn't clean up properly if you hot-eject an interface
that has active devices associated with it.  Use "cardctl eject"
before you eject an IDE card.

-- Dave

