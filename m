Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965818AbWKHOfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818AbWKHOfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965822AbWKHOfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:35:42 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:52230 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965818AbWKHOf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:27 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/33] usb: pvrusb2-hdw free unlink urb cleanup
Date: Wed, 8 Nov 2006 15:34:31 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611062228.38937.m.kozlowski@tuxland.pl> <200611071030.57152.m.kozlowski@tuxland.pl> <20061107013702.46b5710f.akpm@osdl.org>
In-Reply-To: <20061107013702.46b5710f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611081534.33363.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup
- usb_unlink_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/media/video/pvrusb2/pvrusb2-hdw.c	2006-11-06 17:07:44.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/pvrusb2/pvrusb2-hdw.c	2006-11-06 20:53:42.000000000 +0100
@@ -1953,8 +1953,8 @@ struct pvr2_hdw *pvr2_hdw_create(struct 
 	return hdw;
  fail:
 	if (hdw) {
-		if (hdw->ctl_read_urb) usb_free_urb(hdw->ctl_read_urb);
-		if (hdw->ctl_write_urb) usb_free_urb(hdw->ctl_write_urb);
+		usb_free_urb(hdw->ctl_read_urb);
+		usb_free_urb(hdw->ctl_write_urb);
 		if (hdw->ctl_read_buffer) kfree(hdw->ctl_read_buffer);
 		if (hdw->ctl_write_buffer) kfree(hdw->ctl_write_buffer);
 		if (hdw->controls) kfree(hdw->controls);
@@ -2575,12 +2575,10 @@ static void pvr2_ctl_timeout(unsigned lo
 	struct pvr2_hdw *hdw = (struct pvr2_hdw *)data;
 	if (hdw->ctl_write_pend_flag || hdw->ctl_read_pend_flag) {
 		hdw->ctl_timeout_flag = !0;
-		if (hdw->ctl_write_pend_flag && hdw->ctl_write_urb) {
+		if (hdw->ctl_write_pend_flag)
 			usb_unlink_urb(hdw->ctl_write_urb);
-		}
-		if (hdw->ctl_read_pend_flag && hdw->ctl_read_urb) {
+		if (hdw->ctl_read_pend_flag)
 			usb_unlink_urb(hdw->ctl_read_urb);
-		}
 	}
 }
 
