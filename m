Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbVCJXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbVCJXQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263405AbVCJXOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:14:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:40922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263385AbVCJXK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:29 -0500
Date: Thu, 10 Mar 2005 15:08:35 -0800
From: Greg KH <greg@kroah.com>
To: khali@linux-fr.org, rddunlap@osdl.org, dst@bostream.nu, andrei@arhont.com,
       icampbell@arcom.com, rbultje@ronald.bitfreak.net, kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [05/11] Fix i2c messsage flags in video drivers
Message-ID: <20050310230835.GF22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------


While working on the saa7110 driver I found a problem with the way
various video drivers (found on Zoran-based boards) prepare i2c messages
to be used by i2c_transfer. The drivers improperly copy the i2c client
flags as the message flags, while both sets are mostly unrelated. The
net effect in this case is to trigger an I2C block read instead of the
expected I2C block write. The fix is simply not to pass any flag,
because none are needed.

I think this patch qualifies hands down as a "critical bug fix" to be
included in whatever bug-fix-only trees exist these days. As far as I
can see, all Zoran-based boards are broken in 2.6.11 without this patch.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/adv7170.c linux-2.6.11-bk3/drivers/media/video/adv7170.c
--- linux-2.6.11-bk3/drivers/media/video.orig/adv7170.c	Tue Mar  8 10:27:14 2005
+++ linux-2.6.11-bk3/drivers/media/video/adv7170.c	Tue Mar  8 12:19:04 2005
@@ -130,7 +130,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/adv7175.c linux-2.6.11-bk3/drivers/media/video/adv7175.c
--- linux-2.6.11-bk3/drivers/media/video.orig/adv7175.c	Tue Mar  8 10:27:14 2005
+++ linux-2.6.11-bk3/drivers/media/video/adv7175.c	Tue Mar  8 12:18:57 2005
@@ -126,7 +126,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/bt819.c linux-2.6.11-bk3/drivers/media/video/bt819.c
--- linux-2.6.11-bk3/drivers/media/video.orig/bt819.c	Tue Mar  8 10:27:15 2005
+++ linux-2.6.11-bk3/drivers/media/video/bt819.c	Tue Mar  8 12:18:51 2005
@@ -146,7 +146,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/saa7114.c linux-2.6.11-bk3/drivers/media/video/saa7114.c
--- linux-2.6.11-bk3/drivers/media/video.orig/saa7114.c	Tue Mar  8 10:27:15 2005
+++ linux-2.6.11-bk3/drivers/media/video/saa7114.c	Tue Mar  8 12:18:20 2005
@@ -163,7 +163,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/saa7185.c linux-2.6.11-bk3/drivers/media/video/saa7185.c
--- linux-2.6.11-bk3/drivers/media/video.orig/saa7185.c	Tue Mar  8 10:27:15 2005
+++ linux-2.6.11-bk3/drivers/media/video/saa7185.c	Tue Mar  8 12:18:12 2005
@@ -118,7 +118,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;



-- 
Jean Delvare
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

