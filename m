Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264168AbUDRN6L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 09:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbUDRN6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 09:58:11 -0400
Received: from mail1.kontent.de ([81.88.34.36]:9651 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264168AbUDRN6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 09:58:06 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Sun, 18 Apr 2004 15:57:58 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr> <200404172233.03552.oliver@neukum.org> <200404181136.32308.baldrick@free.fr>
In-Reply-To: <200404181136.32308.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404181557.59143.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > gives correctness, but at the cost of a probable performance hit.  In
> > > later steps we can (1) turn dev->serialize into a rwsem
> >
> > Rwsems are _slower_ in the normal case of no contention.
>
> Right, but remember that dev->serialize is per device, not per interface. 
> So if two programs grab different interfaces of the same device using
> usbfs, or if multiple threads in the same program beat on the same
> interface, then they could lose time fighting for dev->serialize when in
> fact they could run in parallel.  Personally I doubt it matters much, but
> since most of usbfs only requires read access to the data structures
> protected by dev->serialize, it seems logical to use a rwsem.

Multiple interfaces are uncommon. Devices with several interfaces bound
to usbfs are uncommoner. Concurrent use is still uncommoner. You are
slowing the common case.

> > > (2) push the acquisition of dev->serialize down to the lower levels as
> > > they are fixed up.
> >
> > Why?
>
> Efficiency.  The main reason is that the copy to/from user calls are inside
> the locked region :) As for the other places where the lock could be
> dropped, I guess measurement is required to see if it gains anything.

OK. I see. But IMHO usbfs is not written for speed anyway, so don't
worry too much.

	Regards
		Oliver

