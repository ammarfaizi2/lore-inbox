Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVF1J4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVF1J4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVF1J4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:56:14 -0400
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:16055
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S261172AbVF1Jz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:55:59 -0400
Message-ID: <42C11EA0.2040307@cola.voip.idv.tw>
Date: Tue, 28 Jun 2005 17:55:44 +0800
From: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, akpm@osdl.org
Subject: [PATCH] fix semaphore handling in __unregister_chrdev_region
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010502000507070607030209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502000507070607030209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Maybe this up() should be down() instead?

Best Regards,
Wen-chien Jesse Sung


Signed-off-by: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>

--------------010502000507070607030209
Content-Type: text/plain;
 name="fix-semaphore-handling-in-__unregister_chrdev_region.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-semaphore-handling-in-__unregister_chrdev_region.diff"

--- linux-2.6.12-git9.orig/fs/char_dev.c	2005-06-28 16:43:27.000000000 +0800
+++ linux-2.6.12-git9/fs/char_dev.c	2005-06-28 16:52:01.000000000 +0800
@@ -150,7 +150,7 @@ __unregister_chrdev_region(unsigned majo
 	struct char_device_struct *cd = NULL, **cp;
 	int i = major_to_index(major);
 
-	up(&chrdevs_lock);
+	down(&chrdevs_lock);
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
 		if ((*cp)->major == major &&
 		    (*cp)->baseminor == baseminor &&

--------------010502000507070607030209--
