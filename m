Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTJKN3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTJKN3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:29:17 -0400
Received: from hades.mk.cvut.cz ([147.32.96.3]:27093 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S263305AbTJKN3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:29:13 -0400
Message-ID: <3F8805A7.6080306@kmlinux.fjfi.cvut.cz>
Date: Sat, 11 Oct 2003 15:29:11 +0200
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030916
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] sensors/w83781d.c creates useless sysfs entries
Content-Type: multipart/mixed;
 boundary="------------060605020901060807020408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060605020901060807020408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

here is a trivial fix for Winbond sensor driver, which currently creates 
useless entries in sys/bus/i2c due to missing braces after if statements 
- author probably forgot about the macro expansion.

Regards,
-- 
Jindrich Makovicka

--------------060605020901060807020408
Content-Type: text/plain;
 name="w83781d.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="w83781d.c.patch"

--- w83781d.c.orig	2003-10-02 08:17:20.000000000 +0200
+++ w83781d.c	2003-10-11 14:45:59.000000000 +0200
@@ -1347,8 +1347,10 @@
 	}
 
 	device_create_file_in(new_client, 0);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s && kind != w83697hf) {
 		device_create_file_in(new_client, 1);
+	}
+	
 	device_create_file_in(new_client, 2);
 	device_create_file_in(new_client, 3);
 	device_create_file_in(new_client, 4);
@@ -1361,25 +1363,30 @@
 
 	device_create_file_fan(new_client, 1);
 	device_create_file_fan(new_client, 2);
-	if (kind != w83697hf)
+	if (kind != w83697hf) {
 		device_create_file_fan(new_client, 3);
+	}
 
 	device_create_file_temp(new_client, 1);
 	device_create_file_temp(new_client, 2);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s && kind != w83697hf) {
 		device_create_file_temp(new_client, 3);
-
-	if (kind != w83697hf)
+	}
+	
+	if (kind != w83697hf) {
 		device_create_file_vid(new_client);
-
-	if (kind != w83697hf)
+	}
+	
+	if (kind != w83697hf) {
 		device_create_file_vrm(new_client);
-
+	}
+	
 	device_create_file_fan_div(new_client, 1);
 	device_create_file_fan_div(new_client, 2);
-	if (kind != w83697hf)
+	if (kind != w83697hf) {
 		device_create_file_fan_div(new_client, 3);
-
+	}
+	
 	device_create_file_alarms(new_client);
 
 	device_create_file_beep(new_client);

--------------060605020901060807020408--

