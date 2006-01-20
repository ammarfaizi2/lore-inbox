Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWATXLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWATXLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWATXLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:11:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15288 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751181AbWATXLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:11:05 -0500
Date: Fri, 20 Jan 2006 15:10:30 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       marcelo.tosatti@cyclades.com, zaitcev@redhat.com
Subject: Re: [PATCH 2.4.32] usb-uhci.c failing "-"
Message-Id: <20060120151030.433abdf6.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0601200928480.1049@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0601200928480.1049@pcgl.dsa-ac.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006 09:33:26 +0100 (CET), Guennadi Liakhovetski <gl@dsa-ac.de> wrote:

> Looks like a bug?

> --- a/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:27:50 2006
> +++ b/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:28:05 2006
> @@ -2505,7 +2505,7 @@
>   			((urb_priv_t*)urb->hcpriv)->flags=0;
>   		}
> 
> -		if ((urb->status != -ECONNABORTED) && (urb->status != ECONNRESET) &&
> +		if ((urb->status != -ECONNABORTED) && (urb->status != -ECONNRESET) &&
>   			    (urb->status != -ENOENT)) {

This is not what the author intended, obviously. But I am not quite sure
what happens because of it. Seems like we unlink some things which are
about to return anyway... and then return -104 instead of -84. This
may be relatively harmless. At worst, the driver resubmits and gets
its -84 that way.

I vote to apply this and see what happens. We are early in 2.4.33 cycle,
so it should be safe.

-- Pete
