Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbUL2IBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUL2IBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUL2HkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:40:06 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:13999 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261394AbUL2Hd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/16] evdev: return -EINVAL if read buffer is too small
Date: Wed, 29 Dec 2004 02:22:23 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290220.50228.dtor_core@ameritech.net> <200412290221.33869.dtor_core@ameritech.net>
In-Reply-To: <200412290221.33869.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290222.25300.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1957.1.32, 2004-11-12 01:28:33-05:00, dtor_core@ameritech.net
  Input: evdev - return -EINVAL from evdev_read if read buffer
         is too small.
  
         Based on the patch by James Lamanna.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 evdev.c |    3 +++
 1 files changed, 3 insertions(+)


===================================================================



diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2004-12-29 01:47:32 -05:00
+++ b/drivers/input/evdev.c	2004-12-29 01:47:32 -05:00
@@ -169,6 +169,9 @@
 	struct evdev_list *list = file->private_data;
 	int retval;
 
+	if (count < sizeof(struct input_event))
+		return -EINVAL;
+
 	if (list->head == list->tail && list->evdev->exist && (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
