Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUKNVOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUKNVOx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 16:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUKNVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 16:14:53 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:5385 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S261324AbUKNVOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 16:14:51 -0500
Message-ID: <4196D2F8.3020203@gentoo.org>
Date: Sun, 14 Nov 2004 03:37:28 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bcollins@debian.org
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] raw1394: __copy_from_user check
Content-Type: multipart/mixed;
 boundary="------------050005010105030202050603"
X-Spam-Score: -5.8 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CT9ti-0009bX-BB*unto/nPAjJk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050005010105030202050603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add a check for the return value of __copy_to_user
Depends on the previous whitespace fix patch.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------050005010105030202050603
Content-Type: text/plain;
 name="raw1394-02-check-copy-from-user.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="raw1394-02-check-copy-from-user.patch"

--- linux/drivers/ieee1394/raw1394.c.orig	2004-11-14 03:02:30.000000000 +0000
+++ linux/drivers/ieee1394/raw1394.c	2004-11-14 03:12:12.928827600 +0000
@@ -447,9 +447,12 @@ static ssize_t raw1394_read(struct file 
 			req->req.error = RAW1394_ERROR_MEMFAULT;
 		}
 	}
-	__copy_to_user(buffer, &req->req, sizeof(req->req));
 
 	free_pending_request(req);
+
+	if (__copy_to_user(buffer, &req->req, sizeof(req->req)))
+		return -EFAULT;
+
 	return sizeof(struct raw1394_request);
 }
 

--------------050005010105030202050603--
