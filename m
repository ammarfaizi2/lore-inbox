Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbUDQTwc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbUDQTwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:52:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:21262 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S264033AbUDQTwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:52:31 -0400
Date: Sat, 17 Apr 2004 15:52:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sf.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Frederic Detienne <fd@cisco.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs
 only on the disconnected interface
In-Reply-To: <200404172053.38655.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0404171541210.14737-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004, Duncan Sands wrote:

> On Saturday 17 April 2004 20:31, Duncan Sands wrote:
> > Alan, do you have a suggestion for how best to go from
> > a struct usb_interface to an index?

The only way is by searching the interface list.  That was part of the 
reason I left findintfif() alone rather than replacing it with a call to 
usb_ifnum_to_if().

> (though probably usbfs shouldn't use indices at all,
> just interface numbers and struct usb_interface).

It's true that code is generally cleaner using numbers rather than
indices, and that's how I've been modifying the USB drivers when they need
it.  In general I would expect an interface number to be not much larger 
than the index (i.e., normally not many numbers will be skipped), so the 
bitmask size should be adequate in either case.  We probably don't have to 
worry about trying to support devices with a single interface numbered 77 
-- but if you wanted to then you'd have to use the index.

Alan Stern

