Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUAOAY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266363AbUAOAYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:24:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:7068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266360AbUAOAYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:24:20 -0500
Date: Wed, 14 Jan 2004 16:23:34 -0800
From: Greg KH <greg@kroah.com>
To: George Anzinger <george@mvista.com>
Cc: Matt Mackall <mpm@selenic.com>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net,
       discuss@x86-64.org, ak@suse.de, shivaram.upadhyayula@wipro.com,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Message-ID: <20040115002334.GC10153@kroah.com>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401101611.53510.amitkale@emsyssoft.com> <400237F0.9020407@mvista.com> <200401122020.08578.amitkale@emsyssoft.com> <40046296.1050702@mvista.com> <20040114063155.GF28521@waste.org> <4005A03A.40409@mvista.com> <20040114232631.GB9983@kroah.com> <4005D8A5.3010002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4005D8A5.3010002@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 04:02:45PM -0800, George Anzinger wrote:
> Greg KH wrote:
> >On Wed, Jan 14, 2004 at 12:02:02PM -0800, George Anzinger wrote:
> >
> >>Right.  I had hoped that we might one day be able to use the USB and I am 
> >>sure there are others.
> >
> >
> >Raw USB?  Or some kind of USB to serial device?
> >
> >Remember, USB needs interrupts to work, see the kdb patches for the mess
> >that people have tried to go through to send usb data without interrupts
> >(doesn't really work...)
> 
> I gave up on USB when I asked the following questions:
> 1. How many different HW USB master devices need to be supported (i.e. 
> appear on your normal line of MBs)? (answer, too many)

There are only 3, UHCI, OHCI, and EHCI.  You can forget about EHCI, as
all EHCI controllers contain either a UHCI or OHCI controller embedded
in them (EHCI only handles the USB2 high speed data.)  So you really
only have to handle 2.

> 2. Can I isolate a USB port from the kernel so that it does not even know 
> it is there? (answer: NO)

Sorry, this is correct.  Unless you want to take over the whole pci
device that the USB controller is on.  That's a possiblity you might
want to look into.

thanks,

greg k-h
