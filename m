Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUDROk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 10:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUDROk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 10:40:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56590 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S261204AbUDROkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 10:40:55 -0400
Date: Sun, 18 Apr 2004 10:40:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       Frederic Detienne <fd@cisco.com>
Subject: Re: [linux-usb-devel] [PATCH 1/9] USB usbfs: take a reference to
 the usb device
In-Reply-To: <200404181136.32308.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0404181037350.7619-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2004, Duncan Sands wrote:

> > > gives correctness, but at the cost of a probable performance hit.  In
> > > later steps we can (1) turn dev->serialize into a rwsem
> >
> > Rwsems are _slower_ in the normal case of no contention.
> 
> Right, but remember that dev->serialize is per device, not per interface.  So if two
> programs grab different interfaces of the same device using usbfs, or if multiple
> threads in the same program beat on the same interface, then they could lose time
> fighting for dev->serialize when in fact they could run in parallel.  Personally I doubt
> it matters much, but since most of usbfs only requires read access to the data structures
> protected by dev->serialize, it seems logical to use a rwsem.

There was a lengthy discussion about this a few months ago.  On the whole, 
people felt that using an rwsem wasn't a good idea.

Personally, I think that contention for a single device will be very rare, 
so we don't need to consider it and can leave things as they are.

Alan Stern

