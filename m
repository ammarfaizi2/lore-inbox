Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTKNP5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 10:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTKNP5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 10:57:38 -0500
Received: from ida.rowland.org ([192.131.102.52]:13828 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262746AbTKNP5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 10:57:35 -0500
Date: Fri, 14 Nov 2003 10:57:34 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
cc: linux-usb-devel@lists.sourceforge.net,
       <linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [BUG] Still having problems with an USB Drive
In-Reply-To: <20031113233659.GA881@ime.usp.br>
Message-ID: <Pine.LNX.4.44L0.0311141045000.1063-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Rogério Brito wrote:

> Yes, thinking more about the problem, that seems to be the case. David
> Brownell already told me that.
> 
> I sent him an e-mail telling what I see when I modify my
> /etc/hotplug/usb.rc script to contain "modprobe -q uhci-hcd debug=2".

An alternative is after you have loaded uhci-hcd but before your device is 
plugged in, do

	echo 4 > /proc/driver/uhci/...

where ... is the file corresponding to the controller you plug your device 
into.  Debugging level 4 will provide more information than level 2, in 
any case.

> > Forget about usb-storage and hotplug scripts.  If you can't even get
> > to the point where your device show up in /proc/bus/usb/devices then
> > nothing else will work.
> 
> Yes, the strange thing is that sometimes, the drive is detected and it
> works. Sometimes, it doesn't.  Most of the time, it doesn't.  And when
> it doesn't work and I try to turn hotplug off, I get unkillable
> processes (khubd is in state D).
> 
> Anyway, what should I do? Should I just boot into single user mode
> without hotplug enabled and load the modules by hand?

That would be a good way of testing.

> > Judging from your dmesg output, you have an external hub (ALCOR
> > Generic USB Hub) into which your device is plugged.  The device
> > contains an internal hub (Leading Driver Co., LTD. USB Embedded Hub)
> > and the drive is attached through that internal hub.
> 
> I don't really know much about my USB setup. I have an Asus A7V
> motherboad and according to its manual (which I just checked), it has 2
> USB ports and two USB "leads" (in one of those, I plugged a small cable
> to a daughterboard, which gives me more USB ports).
> 
> Perhaps this small daughterboard is a new hub?

Judging from your latest dmesg postings, it is.

> Anyway, it seems that I have problems regardless of which port I connect
> my USB drive to. But I can make tests to confirm that if anybody tells
> me what to do.
> 
> Oh, BTW, Leading Driver is the USB drive (perhaps it's an internal hub
> in the drive?). It may be recognized as more than just one USB device,
> but I'm not certain of that, since I don't know what I'm talking about.

It definitely is getting recognized as more than one USB device, but 
that's the point where things go wrong.

> > But an attempt to communicate with the drive failed.  It could be a
> > problem with the external hub, the internal hub, or the drive itself;
> > it's not likely to be a problem with the kernel.  The error message
> 
> Ok.
> 
> > 	hub 2-2.2:1.0: transfer --> -75
> > 
> > indicates a problem with the internal hub, but there's no way to tell what 
> > that problem is.  The other error message
> 
> Is there any way to discover what may be the reason of the problem? Any
> higher debugging level would help with that?

The only way I can think of is by comparison with what happens when the 
device works.  That's why I suggested trying another computer.  Another 
approach would be to use a USB logging programs to see what happens when 
you use your device under Windows.

> > 	usb 2-2.2.1: control timeout on ep0in
> > 
> > indicates a problem communicating with the drive, but that could be caused 
> > by the internal hub not working right.
> 
> Right.

Also, if you can collect and post the dmesg output from one of those 
occasions when the device does work, perhaps that will help.

Alan Stern

