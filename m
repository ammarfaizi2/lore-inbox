Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSIWUTr>; Mon, 23 Sep 2002 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSIWUTr>; Mon, 23 Sep 2002 16:19:47 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:10765 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261373AbSIWUTl>; Mon, 23 Sep 2002 16:19:41 -0400
Subject: Re: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
In-Reply-To: <20020923200554.GG18769@kroah.com>
To: Greg KH <greg@kroah.com>
Date: Mon, 23 Sep 2002 22:24:44 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, mdharm-usb@one-eyed-alien.net,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17tZl6-000164-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
> That's Matt's call, not mine.  And generating a patch for 2.4.20-pre7
> and 2.5.38 would help out in getting it accepted :)

Below is the patch for 2.4.20-pre7.  I'm not brave enough to test 2.5.x
kernels just yet...

Thanks,
Marek

--- orig/linux-2.4.20-pre7/drivers/usb/storage/unusual_devs.h	2002-09-21 12:27:12.000000000 +0200
+++ linux-2.4.20-pre7/drivers/usb/storage/unusual_devs.h	2002-09-23 22:09:18.000000000 +0200
@@ -485,6 +485,17 @@
 		US_FL_MODE_XLATE ),
 #endif
 
+/* Datafab KECF-USB / Sagatek DCS-CF (Datafab DF-UG-07 chip).
+ * Submitted by Marek Michalkiewicz <marekm@amelek.gda.pl>.
+ * Needed for FIX_INQUIRY.  Only revision 1.13 tested.
+ * See also http://martin.wilck.bei.t-online.de/#kecf .
+ */
+UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
+		"Datafab",
+		"KECF-USB",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY ),
+
 /* Casio QV 2x00/3x00/4000/8000 digital still cameras are not conformant
  * to the USB storage specification in two ways:
  * - They tell us they are using transport protocol CBI. In reality they


