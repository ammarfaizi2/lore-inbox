Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbTLWOnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 09:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbTLWOnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 09:43:01 -0500
Received: from bay8-dav5.bay8.hotmail.com ([64.4.26.109]:26886 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265148AbTLWOm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 09:42:56 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>,
       "'Andre Hedrick'" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Tue, 23 Dec 2003 15:42:57 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C3C96B.70033D50"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE7BAC4.2040901@comcast.net>
Thread-Index: AcPJB7hF61wBTlK1TVCizY1/OfJoLwAWuWGw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV5Jher0wLmgf00011713@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2003 14:42:56.0041 (UTC) FILETIME=[0D689990:01C3C963]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C3C96B.70033D50
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

I just realised that I need to have the kernel patched with Walt's pdcraid
patch in order to get it to work. Conclusion: disable all Power Management
options and patch the kernel with Walt's pdcraid patch (attached). That will
do it. I think that Walt's patch should be included in the official kernel.

/Nicke 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 23 december 2003 04:47
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> The patch did not work for me, in fact there was no change at all 
> (anything affected to me). The Promise ataraid driver never gets loaded.
> 
> /Nicke

Not sure what else to try. I see that you've already posted to the ata-raid
list, so I'd hope that somebody else would reply from there. The pdcraid
driver has not received much attention lately, so it may very well be broken
for your configuration. Promise has released a binary/source combo driver
similar to Nvidia's that will still work in 2.4 - you might give that a try.
I have a
PDC20276 based onboard raid setup, however, I use 2.6 with device mapper to
use it. It's a bit of a pain to setup ATM - especially if you want to boot
from it, but it can be done. Good luck,

-Walt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_000B_01C3C96B.70033D50
Content-Type: application/octet-stream;
	name="pdcraid.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pdcraid.patch"

--- /usr/src/temp/linux-2.4.21-xfs/linux/drivers/ide/raid/pdcraid.c	=
2003-12-22 17:59:09.653139067 -0800
+++ linux/drivers/ide/raid/pdcraid.c	2003-07-21 20:47:14.000000000 -0700
@@ -361,7 +361,11 @@
 	if (ideinfo->sect=3D=3D0)
 		return 0;
-	lba =3D (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
-	lba =3D lba * (ideinfo->head*ideinfo->sect);
-	lba =3D lba - ideinfo->sect;
+	if (ideinfo->head!=3D255) {
+		lba =3D (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+		lba =3D lba * (ideinfo->head*ideinfo->sect);
+		lba =3D lba - ideinfo->sect; }
+	else {
+		lba =3D ideinfo->capacity - ideinfo->sect;
+	}
=20
 	return lba;

------=_NextPart_000_000B_01C3C96B.70033D50--
