Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTFZV2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTFZV2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:28:19 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:49820 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262771AbTFZV2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:28:09 -0400
From: Oliver Neukum <oliver@neukum.org>
To: ranty@debian.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: orinoco_usb Request For Comments
Date: Thu, 26 Jun 2003 23:41:18 +0200
User-Agent: KMail/1.5.1
Cc: Jeff Garzik <jgarzik@pobox.com>, orinoco-devel@lists.sf.net, jt@hpl.hp.com
References: <20030626205811.GA25783@ranty.pantax.net>
In-Reply-To: <20030626205811.GA25783@ranty.pantax.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306262341.19110.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Please comment, how much of that or what else needs to be done to get
>  it in the kernel?

	if(dev->read.urb->status == -EINPROGRESS){
		warn("%s: Unlinking pending IN urb", __FUNCTION__);
		retval = bridge_remove_in_urb(dev);
		if(retval){
			dbg("retval %d status %d", retval,
			    dev->read.urb->status);
		}
	}

Unlink unconditionally.

		/* We don't like racing :) */
		ctx->outurb->transfer_flags &= ~URB_ASYNC_UNLINK;
		usb_unlink_urb(ctx->outurb);
		del_timer_sync(&ctx->timer);

But neither do we like sleeping in interrupt. You can't simply unset the flag
if somebody else may be needing it.

More when I am rested :-)

	Regards
		Oliver

