Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbTCTEwy>; Wed, 19 Mar 2003 23:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbTCTEwy>; Wed, 19 Mar 2003 23:52:54 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42477 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261382AbTCTEwx>; Wed, 19 Mar 2003 23:52:53 -0500
Date: Wed, 19 Mar 2003 23:03:51 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, Alexander Hoogerhuis <alexh@ihatent.com>
Subject: Re: Sleeping in illegal context with 2.5.65-mm2
In-Reply-To: <20030320043931.GC18787@kroah.com>
Message-ID: <Pine.LNX.4.44.0303192300410.11075-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Greg KH wrote:

> > Debug: sleeping function called from illegal context at mm/slab.c:1723
> > Call Trace:
> >  [<c0119d92>] __might_sleep+0x5f/0x65
> >  [<c013a097>] kmalloc+0x88/0x8f
> >  [<c0238111>] usb_alloc_urb+0x21/0x51
> >  [<f09180bc>] hci_usb_enable_intr+0x20/0xf8 [hci_usb]
> 
> The call to usb_alloc_urb() here is being done with the GFP_ATOMIC flag,
> which is correct.  Do we need to fix up the warning message to prevent
> false positives like this from happening?

Not in my tree: (drivers/bluetooth/hci_sb.c)

 	if (!(urb = usb_alloc_urb(0, GFP_KERNEL)))
		return -ENOMEM;

And the function is called in a write_lock_irqsave(), so the complaint is 
justified. (Also, I think __might_sleep() deliberately doesn't get 
triggered for GFP_ATOMIC already, as you suggested).

--Kai

