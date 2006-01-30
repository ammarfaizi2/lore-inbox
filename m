Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWA3QZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWA3QZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWA3QZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:25:03 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:32685 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932362AbWA3QZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:25:01 -0500
Date: Mon, 30 Jan 2006 11:24:35 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 2.6.15/2.6.16-git] Fix off-by-one for num_values in	uref_multi
 requests
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz
Message-id: <1138638276.4456.121.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this when working with a HAPP UGCI device. It has a usage with 7
indexes. I could read them all one at a time, but using a multiref it
would only allow me to read the first 6. The patch below fixed it.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

--- a/drivers/usb/input/hiddev.c
+++ b/drivers/usb/input/hiddev.c
@@ -632,7 +632,7 @@ static int hiddev_ioctl(struct inode *in
 
 			else if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
 				 (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
-				  uref->usage_index + uref_multi->num_values >= field->report_count))
+				  uref->usage_index + uref_multi->num_values > field->report_count))
 				goto inval;
 			}
 

-- 
Ben Collins
Kernel Developer - Ubuntu Linux

