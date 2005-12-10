Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVLJBqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVLJBqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 20:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLJBqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 20:46:14 -0500
Received: from bay103-f22.bay103.hotmail.com ([65.54.174.32]:3233 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S964850AbVLJBqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 20:46:13 -0500
Message-ID: <BAY103-F22CCAF1888F2839F97DCCBDF440@phx.gbl>
X-Originating-IP: [70.131.112.137]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <200512091254.44770.bjorn.helgaas@hp.com>
From: "Jason Dravet" <dravet@hotmail.com>
To: bjorn.helgaas@hp.com
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Date: Fri, 09 Dec 2005 19:46:12 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 10 Dec 2005 01:46:13.0200 (UTC) FILETIME=[808BE500:01C5FD2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>To: "Jason Dravet" <dravet@hotmail.com>
>CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
>Subject: Re: wrong number of serial port detected
>Date: Fri, 9 Dec 2005 12:54:44 -0700
>
>On Friday 09 December 2005 7:37 am, Jason Dravet wrote:
> > The question I have
> > is with all of this plug and play stuff in our PCs shouldn't it be 
>possible
> > to get the correct number of ports, ask the bios or the pci bus or
> > something?
>
>Yes.  ACPI (or even PNPBIOS) should tell us about all the "legacy"
>ports, and PCI or other bus enumeration should tell us about all the
>rest.
>
>So in theory, if we have some flavor of PNP, we should be able to
>ignore all the compiled-in stuff in SERIAL_PORT_DFNS, which is what
>leads to the duplicate port detection.  I've considered doing that
>(and ia64 already does it), but it would almost certainly break
>systems because of BIOS bugs, so I'm not sure it's worth the risk.

I agree that breaking things is bad, but it would be interesting to see what 
would happen and if anyone complains.  A gut feeling is that very few people 
use more than the two serial ports that come on their motherboards.  Where I 
work out of the 2,500 PCs on campus, only 3 or 4 PCs actually use a serial 
port.  I think this would be a good survey for slashdot.  I don't use the 
serial ports on my PCs.  I do use the serial ports on my servers.  The 
serial ports on the servers connect to a digi terminal server.  One serial 
port is the management interface to the server, the other is setup for 
serial login.

The reason I started this thread is because I wanted to know why/how I was 
seeing 32 serial ports in /dev when I have 0 enabled on my PC and I have 2 
serial ports on my servers.  Thanks to the responses I have a better 
understanding of what is going on.

>Having all the extra /dev/ttyS entries is a little different problem.
>That is basically so "setserial /dev/ttySx" can be used to work around
>the fact that the serial driver doesn't know about all existing devices.
>If it did, setserial should be superfluous.  Maybe there'd be a way to
>implement that functionality via sysfs and get rid of the extra
>/dev/ttyS entries.  That'd be kind of cool.

sysfs is way outside my area of understanding.  Anything that moves to a 
more accurate /dev directory is good in my book.

Thanks,
Jason


