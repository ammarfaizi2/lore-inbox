Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWFUXA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWFUXA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWFUXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:00:59 -0400
Received: from tim.rpsys.net ([194.106.48.114]:35509 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030379AbWFUXA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:00:58 -0400
Subject: [patch] Fix input modalias sysfs attribute return size
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 00:00:46 +0100
Message-Id: <1150930846.5549.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When writing some udev rules using the input system's modalias
attribute, udevinfo showed it as being ignored. Debugging revealed the
52 character string was over 128 bytes long according to udev (and hence
ignored).

The problem appears to be in the kernel where a max_t in input.c should
really be a min_t.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.17/drivers/input/input.c
===================================================================
--- linux-2.6.17.orig/drivers/input/input.c	2006-06-21 23:47:11.000000000 +0100
+++ linux-2.6.17/drivers/input/input.c	2006-06-21 23:47:48.000000000 +0100
@@ -629,7 +629,7 @@
 
 	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
 
-	return max_t(int, len, PAGE_SIZE);
+	return min_t(int, len, PAGE_SIZE);
 }
 static CLASS_DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
 



