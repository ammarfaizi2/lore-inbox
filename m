Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbTCZVSe>; Wed, 26 Mar 2003 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbTCZVSd>; Wed, 26 Mar 2003 16:18:33 -0500
Received: from [12.47.58.223] ([12.47.58.223]:13867 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S262564AbTCZVSb>; Wed, 26 Mar 2003 16:18:31 -0500
Date: Wed, 26 Mar 2003 13:30:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.66] slab corruption
Message-Id: <20030326133021.43f75e1c.akpm@digeo.com>
In-Reply-To: <871y0uhriz.fsf@echidna.jochen.org>
References: <871y0uhriz.fsf@echidna.jochen.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2003 21:29:37.0572 (UTC) FILETIME=[CD7EBE40:01C2F3DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein <jochen@jochen.org> wrote:
>
> 
> This is when shutting down.  I have the two patches from Jack Simmons
> for the illegal context and the broken cursor applied and nothing
> else.
> 
> uhci-hcd 00:07.2: remove, state 3
> usb usb1: USB disconnect, address 1

There's some nastiness in the USB disconnect code.  Does David Brownell's
patch help?

--- 1.15/drivers/usb/core/urb.c	Thu Mar 13 10:45:40 2003
+++ edited/drivers/usb/core/urb.c	Thu Mar 20 11:17:55 2003
@@ -384,11 +384,11 @@
 	/* FIXME
 	 * We should not care about the state here, but the host controllers
 	 * die a horrible death if we unlink a urb for a device that has been
-	 * physically removed.
+	 * physically removed.  (after driver->disconnect returns...)
 	 */
 	if (urb &&
 	    urb->dev &&
-	    (urb->dev->state >= USB_STATE_DEFAULT) &&
+	    // (urb->dev->state >= USB_STATE_DEFAULT) &&
 	    urb->dev->bus &&
 	    urb->dev->bus->op)
 		return urb->dev->bus->op->unlink_urb(urb);


