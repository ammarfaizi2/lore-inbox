Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWEPARH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWEPARH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWEPARH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:17:07 -0400
Received: from webmail-v.pelco.com ([12.104.148.44]:2839 "EHLO
	exchft2.pelco.org") by vger.kernel.org with ESMTP id S1750866AbWEPARG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:17:06 -0400
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Importance: normal
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] to make HID read block
Date: Mon, 15 May 2006 17:17:04 -0700
Message-ID: <6AEF81150769044DAD3056466B03847802BADE20@CA-EVS01.pelco.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] to make HID read block
Thread-Index: AcZ4fVjLp+UNDzS1RT6wp2vf9wVbMQ==
From: "Micon, David" <DMicon@pelco.com>
To: <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2006 00:17:07.0507 (UTC) FILETIME=[111EA030:01C6787E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a read of a HID device block until data is available.
Without it, the read goes into a busy-wait loop until data is available.
 
diff -rupN linux-2.6.16.16.orig/drivers/usb/input/hiddev.c
linux-2.6.16.16/drivers/usb/input/hiddev.c
--- linux-2.6.16.16.orig/drivers/usb/input/hiddev.c 2006-03-19
21:53:29.000000000 -0800
+++ linux-2.6.16.16/drivers/usb/input/hiddev.c 2006-05-12
16:39:08.000000000 -0700
@@ -318,6 +318,7 @@ static ssize_t hiddev_read(struct file *
     }
 
     schedule();
+    set_current_state(TASK_INTERRUPTIBLE);
    }
 
    set_current_state(TASK_RUNNING);

 
 
Signed-off-by: David Micon dmicon@pelco.com


Confidentiality Notice:

The information contained in this transmission is legally privileged and confidential, intended only for the use of the individual(s) or entities named above.  This email and any files transmitted with it are the property of Pelco.  If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any review, disclosure, copying, distribution, retention, or any action taken or omitted to be taken in reliance on it is prohibited and may be unlawful. 

If you receive this communication in error, please notify us immediately by telephone call to +1-559-292-1981 or forward the e-mail to administrator@pelco.com and then permanently delete the e-mail and destroy all soft and hard copies of the message and any attachments. Thank you for your cooperation.
