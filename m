Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWJKHNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWJKHNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030677AbWJKHNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:13:09 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:54319 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030675AbWJKHNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:13:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=KT/9WtQUPPk3CTNxbc0gpTCD3SaQ6BjH/+CJA/t391Va4OXnh3oZUnFBYCf6dniXIXCKUWCzojGTrqvuG8KYgU5iyFcf7lOaQOj91T/MziVkZDeSgTKD6I2oIK1g1U+J/oInKkG+JBUch9AOryRId2esGnn3EZTuqm7GulTH4lg=
Date: Wed, 11 Oct 2006 00:13:03 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc1] drivers/media/video/se401.c: stop streaming if
 no memory available.
Message-Id: <20061011001303.7f433e7b.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Stop streaming if no memory available. function: se401_start_stream(), file: drivers/media/video/se401.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/se401.c b/drivers/media/video/se401.c
index 7d598e0..779bb99 100644
--- a/drivers/media/video/se401.c
+++ b/drivers/media/video/se401.c
@@ -474,8 +474,11 @@ static int se401_start_stream(struct usb
 
 	for (i=0; i<SE401_NUMSBUF; i++) {
 		urb=usb_alloc_urb(0, GFP_KERNEL);
-		if(!urb)
+		/* No memory, stop streaming */
+		if(!urb) {
+			se401_stop_stream(se401);
 			return -ENOMEM;
+		}
 
 		usb_fill_bulk_urb(urb, se401->dev,
 			usb_rcvbulkpipe(se401->dev, SE401_VIDEO_ENDPOINT),
