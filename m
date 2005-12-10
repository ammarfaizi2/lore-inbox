Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVLJR4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVLJR4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 12:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVLJR4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 12:56:14 -0500
Received: from bay103-f14.bay103.hotmail.com ([65.54.174.24]:41646 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S964944AbVLJR4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 12:56:13 -0500
Message-ID: <BAY103-F14F00806E485B60FFA140CDF440@phx.gbl>
X-Originating-IP: [70.131.119.231]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <20051210154628.GA22707@flint.arm.linux.org.uk>
From: "Jason Dravet" <dravet@hotmail.com>
To: rmk+lkml@arm.linux.org.uk
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Date: Sat, 10 Dec 2005 11:56:12 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 10 Dec 2005 17:56:13.0237 (UTC) FILETIME=[0278C650:01C5FDB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Russell King <rmk+lkml@arm.linux.org.uk>
>To: Jason Dravet <dravet@hotmail.com>
>CC: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org
>Subject: Re: wrong number of serial port detected
>Date: Sat, 10 Dec 2005 15:46:28 +0000
>
>On Sat, Dec 10, 2005 at 08:24:59AM -0600, Jason Dravet wrote:
> > How is this for an idea?  The serial driver enumerates ACPI, PNPBIOS, or
> > whaterver it needs for the onboard serial ports.  If you have a PCI 
>based
> > serial card it would show up in the emuneration of the PCI bus, right?  
>For
> > the case of ISA serial cards couldn't they have an option in 
>modprobe.conf
> > to tell the kernel about the ISA serial card and the proper number of
> > serial ports on the card itself?
>
>That's already thought about and rejected.
>
>If you want to pass a string telling the serial module where the ports
>are, you could be looking at a very _long_ string.  You need to specify
>the IO address, IRQ and base baud as a minimum for every port, along
>with optional flags.
>
>Assuming 5 characters for the IO address, 1 for the IRQ, and 6 for
>the baud base, plus 2 for separators between each of these, and one
>character separator per group, you're looking at 15 characters
>minimum per port.  For 8 ports, that's 120 characters.  16 would
>be 240 characters.  If the driver is built-in to the kernel, you're
>limited to 255 characters to describe all kernel options, so you
>couldn't hope to describe 32 ports.

I was not aware that it worked like that.  My last experience with ISA cards 
was to put a line in the modules.conf that pointed to the base IO and IRQ 
for the card.  There was a serperate file that setup the serial ports.  This 
was way back in RedHat 6.x days.  Thank you for the new information.

>The alternative is something like Dave's patch which allows you to
>tell the driver the number of ports you want to support and setserial.

Dave's patch is good and I look forward to seeing it in the kernel.

Thanks,
Jason


