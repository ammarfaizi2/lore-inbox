Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbQKGStZ>; Tue, 7 Nov 2000 13:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQKGStP>; Tue, 7 Nov 2000 13:49:15 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:49669 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129036AbQKGStH>; Tue, 7 Nov 2000 13:49:07 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC56@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Russell King'" <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
        "'dwmw2@infradead.org'" <dwmw2@infradead.org>
Subject: RE: USB init order dependencies.
Date: Tue, 7 Nov 2000 10:48:39 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Russell King [mailto:rmk@arm.linux.org.uk]
> 
> Dunlap, Randy writes:
> > I'm not following your argument very well.  I've read it
> > and reread it several times.
> > Does adding a call to usb_init() in init/main.c cause
> > USB to be init 2 times?
> 
> No.  As I said elsewhere in this thread, the USB OHCI chip is 
> not accessible
> until other board-specific initialisation has happened.  This 
> is done via an
> initcall.  Unfortunately, moving usb_init() back into 
> init/main.c will mean
> that USB is again initialised before any initcalls, which 
> means for these
> boards USB will be non-functional without additional changes 
> over and above just moving usb_init().
> 
> I hope this helps you understand the problem.

Yes, that does help.

David Woodhouse wrote:
> But OHCI init isn't called from usb_init() is it?

No, it's not.  It's another __initcall (module_init).

> The proposal is only to move the single call to usb_init() back into 
> init/main.c - not to move all the USB initcalls back.

Yes, your proposal is to init only "usbcore" from init/main.c.
I still don't see a need to do this in test10.
It's fixed now AFAIK.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
