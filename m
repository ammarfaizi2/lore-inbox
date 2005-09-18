Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVIRW1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVIRW1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVIRW1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 18:27:46 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:18588 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932235AbVIRW1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 18:27:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QqG8mfzOaTXucFTLDuH+eHol3CjB+ZOWAZ4oM7xVpiYFRay0KLBkMsd/HXk3IDR7FwxLcDBvU1yG9a2l2edx1pbvKWqwVsVLqxhUmibxeowzp6LIoTDEiw0G6rLi95vi7atToUrYSlwktthKj5AL1SeluKagfWMPF7SIwu50fO8=
Date: Mon, 19 Sep 2005 02:38:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Karsten Keil <kkeil@suse.de>
Subject: Re: [linux-usb-devel] URB_ASYNC_UNLINK b0rkage
Message-ID: <20050918223811.GA24046@mipter.zuzino.mipt.ru>
References: <20050918190526.GB787@mipter.zuzino.mipt.ru> <Pine.LNX.4.44L0.0509181718360.2126-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0509181718360.2126-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 05:30:50PM -0400, Alan Stern wrote:
> On Sun, 18 Sep 2005, Alexey Dobriyan wrote:
> > drivers/usb/host/hc_crisv10.c:	if (urb->transfer_flags & URB_ASYNC_UNLINK) {
> > drivers/usb/host/hc_crisv10.c:		/* If URB_ASYNC_UNLINK is set:
> > drivers/usb/host/hc_crisv10.c:		warn("URB_ASYNC_UNLINK set, ignoring.");
> > drivers/usb/misc/uss720.c:	/* rq->urb->transfer_flags |= URB_ASYNC_UNLINK; */
> > drivers/isdn/hisax/st5481_b.c:	b_out->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
> > drivers/isdn/hisax/st5481_b.c:	b_out->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
> > drivers/isdn/hisax/st5481_usb.c:	in->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
> > drivers/isdn/hisax/st5481_usb.c:	in->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
> > Documentation/usb/URB.txt:the URB_ASYNC_UNLINK flag in urb->transfer flags before calling
> 
> hc_crisv10 is long out-of-date and doesn't even build, as you saw.

Just grepped.

> Is anyone still using it?  It probably should be removed from the
> Makefile.

> In my kernel tree, the st5481 source files don't include the lines you 
> show.  What source version are you using?

23 hours ago:

commit 61ffcafafb3d985e1ab8463be0187b421614775c
Author: Karsten Keil <kkeil@suse.de>
Date:   Sat Sep 17 23:52:42 2005 +0200

    [PATCH] Fix ST 5481 USB driver

    The old driver was not fully adapted to new USB ABI and does not
    work.

+	in->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(in->urb[0]);
+	in->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(in->urb[1]);

