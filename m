Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277300AbRJRADd>; Wed, 17 Oct 2001 20:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277301AbRJRADX>; Wed, 17 Oct 2001 20:03:23 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:20377 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S277300AbRJRADN>; Wed, 17 Oct 2001 20:03:13 -0400
Subject: Re: IDE CDROM problems -- No medium found -- 2.4.12-ac3
Date: 18 Oct 2001 02:03:42 +0200
Organization: Chemnitz University of Technology
Message-ID: <87k7xt7r1d.fsf@kosh.ultra.csn.tu-chemnitz.de>
In-Reply-To: <20011017161506.C930@wirex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
To: linux-kernel@vger.kernel.org
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

sarnold@wirex.com (Seth Arnold) writes:

> [...]
> mount will sometimes give:
> [...]
> $ mount /mnt/cdrom
> mount: No medium found

ide-cd.c is broken since 2.4.1 and gives bad status reports on most
ATAPI drives. Perhaps the attached patch helps...



Enrico

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=patch-cdrom.diff

--- linux/drivers/ide/ide-cd.c.orig	Tue May 29 11:24:24 2001
+++ linux/drivers/ide/ide-cd.c	Tue May 29 11:25:44 2001
@@ -2319,10 +2319,7 @@
 		 * any other way to detect this...
 		 */
 		if (sense.sense_key == NOT_READY) {
-			if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
-				return CDS_NO_DISC;
-			else
-				return CDS_TRAY_OPEN;
+			if (sense.asc == 0x3a) return CDS_TRAY_OPEN;
 		}
 
 		return CDS_DRIVE_NOT_READY;

--=-=-=--

