Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267729AbUG3QBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267729AbUG3QBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbUG3QBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 12:01:36 -0400
Received: from [145.253.187.130] ([145.253.187.130]:15376 "EHLO
	proxy.baslerweb.com") by vger.kernel.org with ESMTP id S267729AbUG3QBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 12:01:32 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Device class reference counting
Date: Fri, 30 Jul 2004 18:03:00 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301803.00269.thomas.koeller@baslerweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a little issue with reference counting for
device classes in 2.6.8-rc2. Patch attached. Please
cc me on any responses, as I am not subsribed to
this list.

tk



--- linux-mips/drivers/base/class.c	2004-07-14 16:21:33.000000000 +0200
+++ linux-mips-work/drivers/base/class.c	2004-07-30 17:51:09.477331128 +0200
@@ -353,8 +353,8 @@
 	struct class_interface * class_intf;
 	int error;
 
-	class_dev = class_device_get(class_dev);
-	if (!class_dev || !strlen(class_dev->class_id))
+	if (!strlen(class_dev->class_id)
+		|| !(class_dev = class_device_get(class_dev)))
 		return -EINVAL;
 
 	parent = class_get(class_dev->class);

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
