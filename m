Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVJ3AlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVJ3AlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVJ3AlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:41:20 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:9654 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932225AbVJ3AlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:41:19 -0400
Subject: [PATCH / 2.6.14] prevent dmesg warning in zr36067 driver
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: akpm@osdl.org
Cc: casteyde.christian@free.fr, mjpeg-developer@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-LDAFd4bBqhZUDZCOuwfA"
Date: Sat, 29 Oct 2005 20:42:03 -0400
Message-Id: <1130632924.2690.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LDAFd4bBqhZUDZCOuwfA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

attached patch fixes the warning "Debug: sleeping function called from
invalid context at include/asm/semaphore.h:102" that the zr36067 driver
emits every time an application using JPEG capture starts up (e.g.
mjpegtools' lavrec). The warning is harmless, but clogs up the dmesg
output. This was logged as bugzilla #5403. (Thanks to Christian Casteyde
for helping me in fixing this long-standing annoyance.)

Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>

Cheers,
Ronald

--=-LDAFd4bBqhZUDZCOuwfA
Content-Disposition: attachment; filename=p
Content-Type: text/plain; name=p; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14/drivers/media/video/zoran_driver.c.old	2005-10-29 20:36:24.000000000 -0400
+++ linux-2.6.14/drivers/media/video/zoran_driver.c	2005-10-29 20:36:48.000000000 -0400
@@ -996,8 +996,6 @@
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&zr->spinlock, flags);
-
 	if (fh->jpg_buffers.active == ZORAN_FREE) {
 		if (zr->jpg_buffers.active == ZORAN_FREE) {
 			zr->jpg_buffers = fh->jpg_buffers;
@@ -1016,6 +1014,8 @@
 		zr36057_enable_jpg(zr, mode);
 	}
 
+	spin_lock_irqsave(&zr->spinlock, flags);
+
 	if (!res) {
 		switch (zr->jpg_buffers.buffer[num].state) {
 		case BUZ_STATE_DONE:

--=-LDAFd4bBqhZUDZCOuwfA--

