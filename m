Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbTCTEkv>; Wed, 19 Mar 2003 23:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbTCTEkv>; Wed, 19 Mar 2003 23:40:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:23307 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263205AbTCTEku>;
	Wed, 19 Mar 2003 23:40:50 -0500
Date: Wed, 19 Mar 2003 20:39:32 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Hoogerhuis <alexh@ihatent.com>
Subject: Re: Sleeping in illegal context with 2.5.65-mm2
Message-ID: <20030320043931.GC18787@kroah.com>
References: <87fzpi217i.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzpi217i.fsf@lapper.ihatent.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 03:58:41AM +0100, Alexander Hoogerhuis wrote:
> Caught this one while booting my laptop:
> 
> drivers/usb/core/usb.c: registered new driver hci_usb
> Module bluetooth cannot be unloaded due to unsafe usage in include/linux/module.h:457
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c0119d92>] __might_sleep+0x5f/0x65
>  [<c013a097>] kmalloc+0x88/0x8f
>  [<c0238111>] usb_alloc_urb+0x21/0x51
>  [<f09180bc>] hci_usb_enable_intr+0x20/0xf8 [hci_usb]

The call to usb_alloc_urb() here is being done with the GFP_ATOMIC flag,
which is correct.  Do we need to fix up the warning message to prevent
false positives like this from happening?

thanks,

greg k-h
