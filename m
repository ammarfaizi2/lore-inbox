Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWIMVzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWIMVzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWIMVzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:55:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49546 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751220AbWIMVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:55:09 -0400
Date: Wed, 13 Sep 2006 17:55:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609132332.57435.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609131749230.8180-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Rafael J. Wysocki wrote:

> > Try this patch instead.  It looks for problems occurring a little earlier 
> > in the call chain.
> 
> I've applied both patches at a time (I hope they don't conflict).
> 
> The dmesg output is attached.

The dmesg output shows the root-hub device state is set wrong.

I have to leave now, so I can't give you another patch to try.  You can 
experiment as follows...

Look in drivers/usb/host/ehci-pci.c, at ehci_pci_resume().  The part of 
interest is everything following the "restart:" statement label.

Try adding some ehci_dbg() lines in there (copy the form of the line just
after restart:).  We want to follow the value of
hcd->self.root_hub->state.  Initially it should be equal to
USB_STATE_SUSPENDED (= 8), and it shouldn't change.  But somewhere it is
getting set to USB_STATE_CONFIGURED (= 7).  I don't know where, but almost 
certainly somewhere in this routine.  If you can find out where that 
happens, I'd appreciate it.

Alan Stern

