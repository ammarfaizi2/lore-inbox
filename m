Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131412AbRAYQr7>; Thu, 25 Jan 2001 11:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRAYQrj>; Thu, 25 Jan 2001 11:47:39 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:29719 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S131412AbRAYQrh>; Thu, 25 Jan 2001 11:47:37 -0500
Message-ID: <3A70588B.4692D937@metabyte.com>
Date: Thu, 25 Jan 2001 08:47:07 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: patchlet for cs46xx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2001 16:47:34.0967 (UTC) FILETIME=[847FA470:01C086EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the nitpicking, bust since 2.4 is now "stable"...
-- Pete

diff -ur -X dontdiff linux-2.4.0-ac9/drivers/sound/cs46xx.c linux-2.4.0-ac9-p3/drivers/sound/cs46xx.c
--- linux-2.4.0-ac9/drivers/sound/cs46xx.c	Sun Jan 14 15:27:58 2001
+++ linux-2.4.0-ac9-p3/drivers/sound/cs46xx.c	Wed Jan 24 21:28:30 2001
@@ -2726,7 +2726,7 @@
 			cinfo.blocks = dmabuf->count/dmabuf->divisor >> dmabuf->fragshift;
 			cinfo.ptr = dmabuf->hwptr/dmabuf->divisor;
 			spin_unlock_irqrestore(&state->card->lock, flags);
-			return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+			return copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ? -EFAULT : 0;
 		}
 		return -ENODEV;
 
@@ -2757,7 +2757,7 @@
 			    "cs46xx: GETOPTR bytes=%d blocks=%d ptr=%d\n",
 				cinfo.bytes,cinfo.blocks,cinfo.ptr) );
 			spin_unlock_irqrestore(&state->card->lock, flags);
-			return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+			return copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ? -EFAULT : 0;
 		}
 		return -ENODEV;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
