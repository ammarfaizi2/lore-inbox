Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422859AbWJFTBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbWJFTBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWJFTBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:01:05 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:58323 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1422859AbWJFS63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:58:29 -0400
Date: Fri, 06 Oct 2006 14:58:09 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [Patch] Memory leak in drivers/usb/serial/airprime.c
In-reply-to: <1160044314.6153.2.camel@alice>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <1160161089.28125.212.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.6.3
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1160044314.6153.2.camel@alice>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. And I really thought I'd plugged all the leaks....

Acked-by: Andy Gay <andy@andynet.net>

On Thu, 2006-10-05 at 12:31 +0200, Eric Sesterhenn wrote:
> hi,
> 
> the commit http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5dda171202f94127e49c12daf780cdae1b4e668b
> added a memory leak. In case we cant allocate an urb, we dont free
> the buffer and leak it. Coverity id #1438
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.19-rc1/drivers/usb/serial/airprime.c.orig	2006-10-05 12:25:56.000000000 +0200
> +++ linux-2.6.19-rc1/drivers/usb/serial/airprime.c	2006-10-05 12:26:35.000000000 +0200
> @@ -133,6 +133,7 @@ static int airprime_open(struct usb_seri
>  		}
>  		urb = usb_alloc_urb(0, GFP_KERNEL);
>  		if (!urb) {
> +			kfree(buffer);
>  			dev_err(&port->dev, "%s - no more urbs?\n",
>  				__FUNCTION__);
>  			result = -ENOMEM;
> 
> 
> 

