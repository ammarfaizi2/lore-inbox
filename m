Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSFZQDk>; Wed, 26 Jun 2002 12:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSFZQDj>; Wed, 26 Jun 2002 12:03:39 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:27404 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S316662AbSFZQDi>; Wed, 26 Jun 2002 12:03:38 -0400
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
In-Reply-To: <20020626152213.GE4611@kroah.com>
To: Greg KH <greg@kroah.com>
Date: Wed, 26 Jun 2002 18:03:26 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, marcelo@conectiva.com.br,
       mdharm-usb@one-eyed-alien.net, mwilck@freenet.de,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17NFGQ-00069b-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19-final is too close.  I'll trust Matt to tell me if the patch is
> ok or not technically, as it's his code.  I'd also prefer for you to
> work through him, as he is the maintainer, and not try to send things
> like this to Marcelo directly (read Documentation/SubmittingPatches).

OK, and sorry if sending directly to Marcelo was the wrong thing to do
(I wouldn't have done that if the patch might affect other devices).

I've just played a little more with this device, and here is the really
minimal patch (new entry in unusual_devs.h for the flags, no other
changes in the code) - there should be no doubt if it's OK technically,
as it makes a device work that previously didn't...

The device I have is called "Sagatek DCS-CF", but the name "Sagatek"
is only on the packaging, and the "DCS-CF" is only on a small sticker
at tbe bottom side.  So I left the name "Datafab" in the entry,
assuming it's really the same device inside (same vendor:product ID)
so I guess it's a Datafab product and Sagatek really just sells it...

Please at least consider this - later, the larger issue of limiting
INQUIRY to 36 bytes might have a different solution (in the SCSI code),
but in the meantime this micro-patch is sufficient.  Thanks.

Regards,
Marek

--- linux/drivers/usb/storage/unusual_devs.h.orig	Tue Jun 25 15:38:23 2002
+++ linux/drivers/usb/storage/unusual_devs.h	Wed Jun 26 17:45:59 2002
@@ -461,6 +461,13 @@
 		US_FL_MODE_XLATE ),
 #endif
 
+/* aka Sagatek DCS-CF */
+UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
+		"Datafab",
+		"KECF-USB",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY | US_FL_MODE_XLATE | US_FL_START_STOP ),
+
 /* Casio QV 2x00/3x00/4000/8000 digital still cameras are not conformant
  * to the USB storage specification in two ways:
  * - They tell us they are using transport protocol CBI. In reality they


