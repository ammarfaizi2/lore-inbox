Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbWJPHlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWJPHlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWJPHlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:41:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12592 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161193AbWJPHlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:41:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ldBXLMEOKHKshbdkecskx9n2ePlyRwYvKS7THtI1hOeuUdjJpU8p94lTRtcOou8WG7afth+/Ms6hAf57Mj6pvfcJvIEDhr1079OGMfyMuE0R7KEWPO+5aix+IHHn09URDAxgzHEvr8Sn+BZ2twQTqg7vFnYsvO+QGZiijXRnSuk=
Date: Mon, 16 Oct 2006 00:40:51 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] drivers/usb/serial/mos7840.c: check kmalloc()
 return value.
Message-Id: <20061016004051.be46e13b.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function mos7840_get_reg(), in file drivers/usb/serial/mos7840.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 021be39..91d474b 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -475,6 +475,14 @@ static int mos7840_get_reg(struct moschi
 	int ret = 0;
 	buffer = (__u8 *) mcs->ctrl_buf;
 
+	/* The memory for ctrl_buf is allocated in
+	 * mos7840_startup(), but it is not checked if
+	 * kmalloc failed. So, mcs->ctrl_buf might be NULL.
+	 * So, it should be checked here.
+	 */
+	if (!buffer)
+		return -ENOMEM;
+
 //      dr=(struct usb_ctrlrequest *)(buffer);
 	dr = (void *)(buffer + 2);
 	dr->bRequestType = MCS_RD_RTYPE;
