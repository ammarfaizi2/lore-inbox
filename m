Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSJFW06>; Sun, 6 Oct 2002 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbSJFW05>; Sun, 6 Oct 2002 18:26:57 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:34089 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S262243AbSJFW04>; Sun, 6 Oct 2002 18:26:56 -0400
Message-Id: <m17yJwe-006imWC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "John Tyner" <jtyner@cs.ucr.edu>, "Greg KH" <greg@kroah.com>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Sun, 6 Oct 2002 23:44:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <000c01c26d7f$e3a068d0$0a00a8c0@refresco>
In-Reply-To: <000c01c26d7f$e3a068d0$0a00a8c0@refresco>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 October 2002 23:32, John Tyner wrote:
> > And you should probably kill the tasklet before you unregister the video
> > device.
>
> The more I think about this, the more I think that killing the tasklet
> after unregistering the device is the correct way.
>
> From what I can tell, there are two ways that the disconnect function can
> be called: a physical disconnect or a module removal.

And as a result of an ioctl() through usbfs.

> In the case of a physical disconnect, the ordering probably doesn't matter
> because the tasklet won't be scheduled again because urb's would fail to
> complete successfully.
>
> The case of module removal becomes a bit more complicated (for reasons
> concerning module unload races that are being discussed by people far
> smarter than I). But in any event, I think that it makes more sense to
> unregister the open/close/etc. interface so that there is less chance of
> trying to send another urb (thus causing another schedule of the tasklet)
> before actually killing the tasklet.
>
> This also brings up the (somewhat) rhetorical question I posed in the
> driver's disconnect function. What happens when a disconnect occurs while
> the device is open?

I can't tell right now. I'll sync up after returning home and look into the 
matter.

	Regards
		Oliver
