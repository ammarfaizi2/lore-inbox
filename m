Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTLHQPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTLHQPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:15:51 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:56546 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264605AbTLHQPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:15:32 -0500
From: Duncan Sands <baldrick@free.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Mon, 8 Dec 2003 17:15:15 +0100
User-Agent: KMail/1.5.4
Cc: Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <3FC4E8C8.4070902@free.fr> <200312081110.28590.baldrick@free.fr> <3FD4A0C2.4090109@pacbell.net>
In-Reply-To: <3FD4A0C2.4090109@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081715.15359.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 17:03, David Brownell wrote:
> Duncan Sands wrote:
> > Hi Vince, I'm not sure, but it looks like a bug in the USB core.
> > I was kind of expecting this :)  My patch causes devio.c to hold
> > a reference to the usb_device maybe long after the device has
> > been disconnected.  This is supposed to be OK, but from your
>
> ... no, that's not supposed to be OK.  Returning from disconnect()
> means that a device driver is no longer referencing the interface
> the driver bound to, or ep0.

Well, I thought Greg wanted it to be OK :)  Anyway, I don't use
the device after disconnect except to take the semaphore
(dev->serialize), check for disconnection (dev->state), and
of course to execute a usb_put_dev.  Surely this usage should
be OK?

Ciao,

Duncan.
