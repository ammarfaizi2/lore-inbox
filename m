Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSJGF2l>; Mon, 7 Oct 2002 01:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbSJGF2l>; Mon, 7 Oct 2002 01:28:41 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:55714 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S262884AbSJGF2i>; Mon, 7 Oct 2002 01:28:38 -0400
Message-Id: <m17yQWr-006fhTC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "John Tyner" <jtyner@cs.ucr.edu>, "Greg KH" <greg@kroah.com>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Mon, 7 Oct 2002 06:55:13 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
References: <001c01c26ce4$39b67f80$0a00a8c0@refresco> <m17yJwh-006imUC@Mail.ZEDAT.FU-Berlin.DE> <000e01c26d8f$987153f0$0a00a8c0@refresco>
In-Reply-To: <000e01c26d8f$987153f0$0a00a8c0@refresco>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a patch against 2.5.40 with __dev* uses removed and the error
> checking in the open routine fixed.
>
> Let me know if the ordering of the video_unregister_device and tasklet_kill
> is still an issue.

It isn't. But the disconnect is still wrong. You fail to unlink the current 
urb. This has to be done before you kill the tasklet. And you have to use a 
flag and a spinlock to guard against a race with the completion handler.
There's a recent discussion on this in the usb archives. And you need to
defer freeing the memory if the device is open.
Have a look at how pwc does it. It should be correct in that regard.

And while you at it, could you rename the tasklet from ...bh... to ...tl... ?
It's no longer a bottom half.

	Regards
		Oliver
 
