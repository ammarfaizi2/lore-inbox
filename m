Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287011AbSAGUsb>; Mon, 7 Jan 2002 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287003AbSAGUsM>; Mon, 7 Jan 2002 15:48:12 -0500
Received: from daytona.gci.com ([205.140.80.57]:56075 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S287025AbSAGUr6>;
	Mon, 7 Jan 2002 15:47:58 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31506DB4631@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Rene Engelhard <mail@rene-engelhard.de>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: RE: [PATCH] Getting ScanLogic USB-ATAPI Adapter to work
Date: Mon, 7 Jan 2002 11:47:46 -0900 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene,

I think that while this patch may work for you, it's not the right way
to go about it.

Instead of changing the source for all devices that use transport.c,
you should create a flag (see usb.h), say US_FL_SLIDE_BUG, and set
it within the definition in unusual_devs.h

Then the logic in transport.c can check for that flag and work around
the bug as needed -- as not all storage devices will require that
workaround.

I'm in the process of recompiling my 2.5.2-pre9 kernel with the above
workaround to see if it solves my issues as well.  Unfortunately, my
device is at home, and I'm at work.  I'll post later tonight or tomorrow
morning my results.

Greg? Your opinions on the right way to work this?

> -----Original Message-----
> From: Rene Engelhard [mailto:mail@rene-engelhard.de]
> Sent: Monday, January 07, 2002 11:18 AM
> To: Greg KH
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] Getting ScanLogic USB-ATAPI Adapter to work
> 
> 
> Hi Greg, hi Kernel-Hackers,
> 
> a long time ago I bought the Adapter mentioned above and got it
> working.
> 
> Now, 6 months after that I bought it, my testing is over and I got the
> result: The device is working by changing the usb-storage 
> sources; this
> has not affected any other thing. All my devices (3 of USB) 
> runs perfectly.
> 
> So I send you this patch.
> 
> It's against 2.5.2-pre9 and the patch from Alan with the comment that
> you need SCSI Support is applied in my tree, so this is needed before
> applying this patch (but I saw you did it Greg, you can do this)
> 
> Because of testing this patch 6 months, I do not consider to say that
> this patch is experimental, so I did not write $CONFIG_EXPERIMENTAL at
> the end of the dep_mbool statement.
> 
> I have attached it to this mail.
> 
> Rene
> 
