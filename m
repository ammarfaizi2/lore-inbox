Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWEZWAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWEZWAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWEZWAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:00:24 -0400
Received: from webmail-v.pelco.com ([12.104.148.44]:46231 "EHLO
	exchft2.pelco.org") by vger.kernel.org with ESMTP id S1750873AbWEZWAX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:00:23 -0400
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
Content-class: urn:content-classes:message
MIME-Version: 1.0
Importance: normal
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] to make HID read block
Date: Fri, 26 May 2006 15:00:21 -0700
Message-ID: <6AEF81150769044DAD3056466B03847802E4D945@CA-EVS01.pelco.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] to make HID read block
Thread-Index: AcZ4fVjLp+UNDzS1RT6wp2vf9wVbMQ==
From: "Micon, David" <DMicon@pelco.com>
To: <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 May 2006 22:00:23.0057 (UTC) FILETIME=[C96E2810:01C6810F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a read of a HID device block until data is available.
Without it, the read goes into a busy-wait loop until data is available.
 
Signed-off-by: David Micon dmicon@pelco.com
 
diff -rupN linux-2.6.16.16.orig/drivers/usb/input/hiddev.c
linux-2.6.16.16/drivers/usb/input/hiddev.c
--- linux-2.6.16.16.orig/drivers/usb/input/hiddev.c 2006-03-19
21:53:29.000000000 -0800
+++ linux-2.6.16.16/drivers/usb/input/hiddev.c 2006-05-12 
+++ 16:39:08.000000000 -0700
@@ -318,6 +318,7 @@ static ssize_t hiddev_read(struct file *
     }
 
     schedule();
+    set_current_state(TASK_INTERRUPTIBLE);
    }
 
    set_current_state(TASK_RUNNING);


Confidentiality Notice:

The information contained in this transmission is legally privileged and confidential, intended only for the use of the individual(s) or entities named above.  This email and any files transmitted with it are the property of Pelco.  If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any review, disclosure, copying, distribution, retention, or any action taken or omitted to be taken in reliance on it is prohibited and may be unlawful. 

If you receive this communication in error, please notify us immediately by telephone call to +1-559-292-1981 or forward the e-mail to administrator@pelco.com and then permanently delete the e-mail and destroy all soft and hard copies of the message and any attachments. Thank you for your cooperation.
