Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTETWnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTETWnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:43:45 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:29987 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261326AbTETWmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:42:51 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 04/14] USB speedtouch: add defensive memory barriers
Date: Wed, 21 May 2003 00:55:45 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210055.45564.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Defend against future maintainers.

 speedtch.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:14 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:14 2003
@@ -1220,6 +1220,7 @@
 
 finish:
 	/* ready for ATM callbacks */
+	wmb ();
 	instance->atm_dev->dev_data = instance;
 
 	usb_set_intfdata (intf, instance);
@@ -1358,6 +1359,7 @@
 	for (i = 0; i < UDSL_NUM_SND_BUFS; i++)
 		kfree (instance->send_buffers [i].base);
 
+	wmb ();
 	instance->usb_dev = NULL;
 
 	/* ATM finalize */

