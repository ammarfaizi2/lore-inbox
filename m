Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313319AbSDGNsJ>; Sun, 7 Apr 2002 09:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313322AbSDGNsI>; Sun, 7 Apr 2002 09:48:08 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:36103 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313319AbSDGNsH>;
	Sun, 7 Apr 2002 09:48:07 -0400
Date: Sun, 7 Apr 2002 09:48:06 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: WatchDog Driver Updates
In-Reply-To: <E16uCo2-000632-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204070938490.3791-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Apr 2002, Alan Cox wrote:

> > > 5. WDIOC_GETSTATUS is supposed to return the WDIOF_* flags.  Returning
> > >    "watchdog active" as bit 0 causes it to indicate WDIOF_OVERHEAT.
> >
> > Hmm...I'm not seeing any standards here.  Some drivers would just send
>
> Documentation/* in current -ac

2.4.19-pre5-ac3

Right, Documentation/watchdog.txt:
The i810 TCO watchdog driver also implements the WDIOC_GETSTATUS and
WDIOC_GETBOOTSTATUS ioctl()s. WDIOC_GETSTATUS returns the actual counter value
and WDIOC_GETBOOTSTATUS returns the value of TCO2 Status Register (see Intel's
documentation for the 82801AA and 82801AB datasheet).

Documentation/watchdog-api.txt lists each driver and how the ones that
implement GETSTATUS do so in a 'silly' manner.  While it also does mention
how cards are supposed to return WDIOF_* (and list supported flags in the
options), it also shows how all of 3 out of 20 watchdog drivers actually
follow that convention.  7 return the number 1, 1 returns the number of ticks,
and 1 returns whether the card is enabled or disabled.  So following the
standards embodied in the code, every driver should just return 1 ;-).

Ah-ha, the crown jewels!
Documentation/pcwd-watchdog.txt:
        WDIOC_GETSTATUS
                This returns the status of the card, with the bits of
                WDIOF_* bitwise-anded into the value.  (The comments
                are in linux/pcwd.h)
Although, this is hidden away in a driver specific file (and even references
a file which no longer exists).  I guess I'll clean all this up in my next
patch.

Regards,
Rob Radez


