Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSHZVz6>; Mon, 26 Aug 2002 17:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSHZVz5>; Mon, 26 Aug 2002 17:55:57 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:11242 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318237AbSHZVz5>; Mon, 26 Aug 2002 17:55:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: USB keyboards (patch)
Date: Tue, 27 Aug 2002 01:00:09 +0300
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208270100.09037.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech, Would you accept this for the 2.4 kernels?

The attached patch is required to use some (buggy?)
USB keyboards. IMHO it should not cause new problems
with other HID devices (though, testing with hardware that
I do not have is a good idea).

I'm using it with recent 2.4 kernels for some time now.

Just removing the call to usb_set_idle also works (but
it is less efficient).

The 2.5 kernels do not need this changes - they already call
the equivalent of usb_set_idle (only for input reports) after
reading the first report.

-- Itai

--- linux/drivers/usb/hid-core.c.orig	Sun Jul 21 01:19:32 2002
+++ linux/drivers/usb/hid-core.c	Sun Jul 21 02:19:31 2002
@@ -1065,8 +1065,8 @@
 			list = report_enum->report_list.next;
 			while (list != &report_enum->report_list) {
 				report = (struct hid_report *) list;
-				usb_set_idle(hid->dev, hid->ifnum, 0, report->id);
 				hid_read_report(hid, report);
+				usb_set_idle(hid->dev, hid->ifnum, 0, report->id);
 				list = list->next;
 			}
 		}


