Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTETWl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTETWl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:41:59 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:44440 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261312AbTETWlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:41:55 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 03/14] USB speedtouch: replace yield()
Date: Wed, 21 May 2003 00:54:49 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210054.49187.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use set_current_state (TASK_RUNNING); schedule(); instead.

 speedtch.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:05 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:05 2003
@@ -1298,7 +1298,8 @@
 		if (completed == count)
 			break;
 
-		yield ();
+		set_current_state (TASK_RUNNING);
+		schedule ();
 	} while (1);
 
 	dbg ("udsl_usb_disconnect: flushing");
@@ -1337,7 +1338,8 @@
 		if (count == UDSL_NUM_SND_URBS)
 			break;
 
-		yield ();
+		set_current_state (TASK_RUNNING);
+		schedule ();
 	} while (1);
 
 	dbg ("udsl_usb_disconnect: flushing");

