Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSJFV1H>; Sun, 6 Oct 2002 17:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSJFV1H>; Sun, 6 Oct 2002 17:27:07 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:50379 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S262207AbSJFV1F>; Sun, 6 Oct 2002 17:27:05 -0400
Message-ID: <000c01c26d7f$e3a068d0$0a00a8c0@refresco>
From: "John Tyner" <jtyner@cs.ucr.edu>
To: "Oliver Neukum" <oliver@neukum.name>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Sun, 6 Oct 2002 14:32:35 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And you should probably kill the tasklet before you unregister the video
> device.

The more I think about this, the more I think that killing the tasklet after
unregistering the device is the correct way.

>From what I can tell, there are two ways that the disconnect function can be
called: a physical disconnect or a module removal.

In the case of a physical disconnect, the ordering probably doesn't matter
because the tasklet won't be scheduled again because urb's would fail to
complete successfully.

The case of module removal becomes a bit more complicated (for reasons
concerning module unload races that are being discussed by people far
smarter than I). But in any event, I think that it makes more sense to
unregister the open/close/etc. interface so that there is less chance of
trying to send another urb (thus causing another schedule of the tasklet)
before actually killing the tasklet.

This also brings up the (somewhat) rhetorical question I posed in the
driver's disconnect function. What happens when a disconnect occurs while
the device is open?

Thanks,
John

