Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSIAHUi>; Sun, 1 Sep 2002 03:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSIAHUh>; Sun, 1 Sep 2002 03:20:37 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:12272 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S316532AbSIAHUg>; Sun, 1 Sep 2002 03:20:36 -0400
Subject: 2.5.33 USB storage depmod error fix
From: Nicholas Miell <nmiell@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 00:24:57 -0700
Message-Id: <1030865099.21053.31.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

show_trace isn't exported, nor is it defined by all architectures. (This
is what I use to get the usb-storage module to work; the more
appropriate solution would be to implement show_trace on all
architectures and properly export it.)

--- linux-2.5-build/drivers/usb/storage/transport.c.~1~	Sat Aug 17 12:07:00 2002
+++ linux-2.5-build/drivers/usb/storage/transport.c	Sun Sep  1 00:20:28 2002
@@ -350,7 +350,6 @@
 	 */
 	if (len != srb->request_bufflen) {
 		printk("USB len=%d, request_bufflen=%d\n", len, srb->request_bufflen);
-		show_trace(NULL);
 	}
 
 	return len;


