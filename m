Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269187AbUINHz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbUINHz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbUINHz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:55:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:19382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269187AbUINHzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:55:25 -0400
Date: Tue, 14 Sep 2004 00:47:39 -0700
From: Greg KH <greg@kroah.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.9-rc1-mm4, visor.c, Badness in usb_unlink_urb
Message-ID: <20040914074739.GA22875@kroah.com>
References: <20040910082601.GA32746@gamma.logic.tuwien.ac.at> <200409101148.37587.petkov@uni-muenster.de> <20040910140152.GA15589@kroah.com> <200409102024.32082.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409102024.32082.petkov@uni-muenster.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 08:24:31PM +0200, Borislav Petkov wrote:
> Hi Greg,
> I'll be happy to tackle the other drivers. Question: Does usb_unlink_urb have 
> to be replaced only for synchronious unlinking

Yes.

> and if so, is the wrapping function responsible for checking the
> URB_ASYNC_UNLINK transfer flag? Here's a patch:

The driver should know how to shut down the urb.

> Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> 
> --- linux-2.6.9-rc1-mm/drivers/usb/class/audio.c.orig 2004-09-10 20:05:17.000000000 +0200
> +++ linux-2.6.9-rc1-mm/drivers/usb/class/audio.c 2004-09-10 20:23:12.000000000 +0200
> @@ -635,13 +635,13 @@ static void usbin_stop(struct usb_audiod
>    spin_unlock_irqrestore(&as->lock, flags);
>    if (notkilled && signal_pending(current)) {
>     if (i & FLG_URB0RUNNING)
> -    usb_unlink_urb(u->durb[0].urb);
> +    usb_kill_urb(u->durb[0].urb);

Ick, the tabs are stripped out :(

thanks,

greg k-h
