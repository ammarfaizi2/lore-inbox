Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314159AbSDMASe>; Fri, 12 Apr 2002 20:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314160AbSDMASd>; Fri, 12 Apr 2002 20:18:33 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:13771 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S314159AbSDMASc>; Fri, 12 Apr 2002 20:18:32 -0400
Date: Fri, 12 Apr 2002 17:16:49 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: usbnet: prolific fails reset
To: Kurt Garloff <kurt@garloff.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <0b7901c1e280$81b07140$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <20020412224832.D1832@nbkurt.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt --

Thanks for the patch, I'll check it out.  "-32" should be a protocol
stall (Intel <asm/errno.h> I assume) that could be retried ... it'd
be better done in device-specific code (pl_reset) than in the
generic layer though.  I'll look at providing a "real" fix, and may
ask you to check out a different patch.

Those Prolific chips are perhaps not as finely crafted as I'd like
to see, there are a bunch of "gotchas" ... this could be a good
way to work around one of them, but I suspect you'll still find that
under load testing, you'll be glad the TX watchdog is so good
at barking (sometimes every few seconds)!

- Dave



----- Original Message ----- 
From: "Kurt Garloff" <kurt@garloff.de>
To: "David Brownell" <dbrownell@users.sourceforge.net>
Cc: "Linux kernel list" <linux-kernel@vger.kernel.org>
Sent: Friday, April 12, 2002 1:48 PM
Subject: usbnet: prolific fails reset


Hi David,

got a USB network cable and was happy to see that it's supported by usbnet.
Good job, thanks!
usb0: register usbnet 001/004, Prolific PL-2301/PL-2302

However:
Upon ifconfig,
usb-uhci.c: interrupt, status 3, frame# 922
usb0: open reset fail (-32) usbnet 001/004, Prolific PL-2301/PL-2302

The ifconfig fails to up the interface, consequently.

Attached patch prevents the driver from returning the reset failure.
Guess what: The networking worked just fine then.
Probably the real solution is different ...

Patch is against 2.4.16.

Regards,
-- 
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)


