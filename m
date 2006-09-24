Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWIXN7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWIXN7B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 09:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWIXN7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 09:59:01 -0400
Received: from aun.it.uu.se ([130.238.12.36]:37553 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750821AbWIXN7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 09:59:00 -0400
Date: Sun, 24 Sep 2006 15:58:46 +0200 (MEST)
Message-Id: <200609241358.k8ODwkZJ016350@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net, greg@kroah.com
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Cc: linux-kernel@vger.kernel.org, simoneau@ele.uri.edu,
       sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 17:05:31 -0700 (PDT), David Miller wrote:
>[USB]: Fix alignment of buffer passed down to ->hub_control()
>
>Implementations assume the buffer is at least 4 byte aligned.
>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>
>diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>index fb4d058..7766d7b 100644
>--- a/drivers/usb/core/hcd.c
>+++ b/drivers/usb/core/hcd.c
>@@ -344,7 +344,8 @@ static int rh_call_control (struct usb_h
> 	struct usb_ctrlrequest *cmd;
>  	u16		typeReq, wValue, wIndex, wLength;
> 	u8		*ubuf = urb->transfer_buffer;
>-	u8		tbuf [sizeof (struct usb_hub_descriptor)];
>+	u8		tbuf [sizeof (struct usb_hub_descriptor)]
>+		__attribute__((aligned(4)));
> 	const u8	*bufp = tbuf;
> 	int		len = 0;
> 	int		patch_wakeup = 0;
>

Thanks, this eliminated the USB alignment traps in my
gcc-4.1.1 compiled sparc64 kernel.

/Mikael
