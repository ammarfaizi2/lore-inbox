Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbTCTFHC>; Thu, 20 Mar 2003 00:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbTCTFHC>; Thu, 20 Mar 2003 00:07:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30219 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261385AbTCTFHA>;
	Thu, 20 Mar 2003 00:07:00 -0500
Date: Wed, 19 Mar 2003 21:05:37 -0800
From: Greg KH <greg@kroah.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, maxk@qualcomm.com
Cc: linux-kernel@vger.kernel.org, Alexander Hoogerhuis <alexh@ihatent.com>
Subject: Re: Sleeping in illegal context with 2.5.65-mm2
Message-ID: <20030320050537.GA19436@kroah.com>
References: <20030320043931.GC18787@kroah.com> <Pine.LNX.4.44.0303192300410.11075-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303192300410.11075-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 11:03:51PM -0600, Kai Germaschewski wrote:
> On Wed, 19 Mar 2003, Greg KH wrote:
> 
> > > Debug: sleeping function called from illegal context at mm/slab.c:1723
> > > Call Trace:
> > >  [<c0119d92>] __might_sleep+0x5f/0x65
> > >  [<c013a097>] kmalloc+0x88/0x8f
> > >  [<c0238111>] usb_alloc_urb+0x21/0x51
> > >  [<f09180bc>] hci_usb_enable_intr+0x20/0xf8 [hci_usb]
> > 
> > The call to usb_alloc_urb() here is being done with the GFP_ATOMIC flag,
> > which is correct.  Do we need to fix up the warning message to prevent
> > false positives like this from happening?
> 
> Not in my tree: (drivers/bluetooth/hci_sb.c)
> 
>  	if (!(urb = usb_alloc_urb(0, GFP_KERNEL)))
> 		return -ENOMEM;

Doh, nevermind, I was looking at the wrong function, sorry.

> And the function is called in a write_lock_irqsave(), so the complaint is 
> justified. 

Max, you should probably fix this up.

> (Also, I think __might_sleep() deliberately doesn't get triggered for
> GFP_ATOMIC already, as you suggested).

Yeah, in digging deeper, it's a smart check, sorry.

thanks,

greg k-h
