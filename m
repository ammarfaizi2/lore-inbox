Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264268AbUEMP4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbUEMP4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUEMP4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:56:16 -0400
Received: from ida.rowland.org ([192.131.102.52]:25348 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264268AbUEMP4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:56:07 -0400
Date: Thu, 13 May 2004 11:56:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Nuno Ferreira <nuno.ferreira@graycell.biz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sf.net>
Subject: Re: 2.6.6 Oops disconnecting speedtouch usb modem
In-Reply-To: <200405131104.37266.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0405131132310.1543-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Duncan Sands wrote:

> Hi Nuno, I suspect it is caused by this patch (as246c - Allocate interface structures dynamically):
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108239223425404&w=2
> 
> Can you please revert it and see if that helps?  I think it is this bit that is causing the problem:
> 
>  /*
>   * usb_disable_device - Disable all the endpoints for a USB device
>   * @dev: the device whose endpoints are being disabled
> @@ -835,6 +831,7 @@
>                         dev_dbg (&dev->dev, "unregistering interface %s\n",
>                                 interface->dev.bus_id);
>                         device_unregister (&interface->dev);
> +                       dev->actconfig->interface[i] = NULL;
>                 }
>                 dev->actconfig = 0;
>                 if (dev->state == USB_STATE_CONFIGURED)
> @@ -1071,6 +1068,16 @@
>         return 0;
>  }

I don't see how that can be.  The stack dump is getting unwieldy so I
haven't duplicated it here, but if I'm reading it right the problem occurs
when usb_set_interface() is called by usb_unbind_interface(), which itself
is called indirectly by device_unregister() above.  The pointer for the
interface being unregistered has not yet been set to NULL, hence this
shouldn't cause an oops.

Alan Stern


