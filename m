Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbTISWOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 18:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTISWOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 18:14:42 -0400
Received: from ida.rowland.org ([192.131.102.52]:6660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261833AbTISWOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 18:14:31 -0400
Date: Fri, 19 Sep 2003 18:14:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: USB APM suspend
Message-ID: <Pine.LNX.4.44L0.0309191755590.763-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a piece from my system log, when I did "apm --suspend".  The 
usb_device_suspend/resume messages are things I added for debugging.

Sep 19 17:02:35 ida kernel: uhci-hcd 0000:00:07.2: suspend to state 3
Sep 19 17:02:35 ida kernel: drivers/usb/host/uhci-hcd.c: 6400: suspend_hc
Sep 19 17:02:35 ida kernel: usb_device_suspend: 1-1:0
Sep 19 17:02:35 ida kernel: usb_device_suspend: 1-1
Sep 19 17:02:35 ida kernel: usb_device_suspend: 1-0:0
Sep 19 17:02:35 ida kernel: usb_device_suspend: usb1
Sep 19 17:02:45 ida kernel: uhci-hcd 0000:00:07.2: suspend D4 --> D3
Sep 19 17:02:45 ida kernel: drivers/usb/host/uhci-hcd.c: 6400: wakeup_hc
Sep 19 17:02:45 ida kernel: usb_device_resume: usb1
Sep 19 17:02:45 ida kernel: usb_device_resume: 1-0:0
Sep 19 17:02:45 ida kernel: usb_device_resume: 1-1
Sep 19 17:02:45 ida kernel: usb_device_resume: 1-1:0
Sep 19 17:02:45 ida kernel: uhci-hcd 0000:00:07.2: can't resume, not suspended!

This has several odd things.  Note that both the first two "0000:00:07.2"  
messages were created by hcd-pci.c, in its usb_hcd_pci_suspend() routine.  

Why was this routine called twice?  (Don't be fooled by the timestamps; I 
think the "suspend D4 --> D3" message was created during the suspend but 
not read by syslogd until after the resume.)

Why doesn't usb_hcd_pci_resume() log a similar message when it is called?
A simple oversight?

Why was the host controller suspended _before_ its child USB devices?  

And why was it woken up twice?

Alan Stern


P.S.: Greg, what on Earth does "GREG: gregindex = 0" mean?

