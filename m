Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbUKLGlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbUKLGlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUKLGjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:39:18 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:18078 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262469AbUKLGfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:35:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/7] evdev_read: report -EINVAL when buffer is to small 
Date: Fri, 12 Nov 2004 01:32:43 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411120127.01473.dtor_core@ameritech.net> <200411120130.54103.dtor_core@ameritech.net> <200411120131.54268.dtor_core@ameritech.net>
In-Reply-To: <200411120131.54268.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411120132.44833.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1989, 2004-11-12 00:36:10-05:00, dtor_core@ameritech.net
  Input: evdev - return -EINVAL from evdev_read if read buffer
         is too small.
  
         Based on the patch by James Lamanna.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 evdev.c |    3 +++
 1 files changed, 3 insertions(+)


===================================================================



diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2004-11-12 01:01:02 -05:00
+++ b/drivers/input/evdev.c	2004-11-12 01:01:02 -05:00
@@ -169,6 +169,9 @@
 	struct evdev_list *list = file->private_data;
 	int retval;
 
+	if (count < sizeof(struct input_event))
+		return -EINVAL;
+
 	if (list->head == list->tail && list->evdev->exist && (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
