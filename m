Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVIRVaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVIRVaw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVIRVaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:30:52 -0400
Received: from mx1.rowland.org ([192.131.102.7]:58385 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932212AbVIRVav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:30:51 -0400
Date: Sun, 18 Sep 2005 17:30:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] URB_ASYNC_UNLINK b0rkage
In-Reply-To: <20050918190526.GB787@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.44L0.0509181718360.2126-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005, Alexey Dobriyan wrote:

> Perhaps, another press release to explain breakage of allmodconfig is
> needed.
> ------------------------------------------------------------------------
> drivers/usb/host/hc_crisv10.c:	if (urb->transfer_flags & URB_ASYNC_UNLINK) {
> drivers/usb/host/hc_crisv10.c:		/* If URB_ASYNC_UNLINK is set:
> drivers/usb/host/hc_crisv10.c:		warn("URB_ASYNC_UNLINK set, ignoring.");
> drivers/usb/misc/uss720.c:	/* rq->urb->transfer_flags |= URB_ASYNC_UNLINK; */
> drivers/isdn/hisax/st5481_b.c:	b_out->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
> drivers/isdn/hisax/st5481_b.c:	b_out->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
> drivers/isdn/hisax/st5481_usb.c:	in->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
> drivers/isdn/hisax/st5481_usb.c:	in->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
> Documentation/usb/URB.txt:the URB_ASYNC_UNLINK flag in urb->transfer flags before calling

hc_crisv10 is long out-of-date and doesn't even build, as you saw.  Is 
anyone still using it?  It probably should be removed from the Makefile.

The line in drivers/usb/misc/uss720.c is just a comment.  Presumably it 
can be taken out with no harm done.

In my kernel tree, the st5481 source files don't include the lines you 
show.  What source version are you using?

Finally, the URB.txt documentation file clearly states at the beginning 
that it is out of date.  However it wouldn't hurt to fix it up a little.  
I'll send in a patch to do so.

Alan Stern

