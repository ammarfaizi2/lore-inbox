Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVKZU1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVKZU1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVKZU1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:27:54 -0500
Received: from mx1.rowland.org ([192.131.102.7]:53262 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750731AbVKZU1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:27:53 -0500
Date: Sat, 26 Nov 2005 15:27:51 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Patrizio Bassi <patrizio.bassi@gmail.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <pavel@ucw.cz>, <shaohua.li@intel.com>, <akpm@osdl.org>
Subject: Re: 2.6.15-rc2-git5 continues to fail suspending (USB issue)
In-Reply-To: <43881A1C.6040608@gmail.com>
Message-ID: <Pine.LNX.4.44L0.0511261522220.15363-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2005, Patrizio Bassi wrote:

> >You wrote about it on lkml, not linux-usb-devel.  So it might not have 
> >been noticed by the USB developers.
> >
> >  
> >
> o sorry you're right. i tought usb team followed the main ml too.

Some do and some don't.

> globespan device is a zyxel prestige 630 adsl modem using eciadsl
> userspace drivers.
> after killing the driver it suspended and resumed.
> 
> but i got a problem, trying to restart driver.
> 
> [EciAdsl 3/5] Synchronization...
> 
>  ERROR reading interrupts
> *** glibc detected *** double free or corruption (fasttop): 0x0804f158 ***
> /usr/bin/eciadsl-start: line 517: 11399 Abortito               
> "$BIN_DIR/eciadsl-synch" $synch_options
> ERROR: failed to get synchronization
> 
> usb 2-2: usbfs: USBDEVFS_CONTROL failed cmd eciadsl-synch rqt 192 rq 222
> len 13 ret -110
> 
> tried 3 times, always the same.
> so i manually unplugged modem and replugged.
> works perfectly (as usual).
> 
> seems a problem on suspending and resuming attached device.

Maybe it's a problem in the device.

> i've access to eciadsl cvs so i can patch it.
> the first problem (no suspend) i think can be fixed binding some signals
> in userspace, which?

There are no signals sent to userspace on suspend.  It's too late to send 
signals, because all tasks have already been frozen.

Instead the usbfs code has to be changed to handle suspend/resume events 
on behalf of userspace drivers.  Or you could use that patch I mentioned 
before; it unbinds drivers that don't have suspend methods.

> the second seems an init problem, that i leave to you :)

I can't do anything about it, since I don't have one of those modems.

Alan Stern

