Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbUKDF7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbUKDF7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 00:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUKDF7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 00:59:22 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:24009 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262084AbUKDF7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 00:59:17 -0500
Subject: [PATCH] Use add_hotplug_env_var() in firmware loader
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-P3mrvbys7tYykU7mqurN"
Date: Thu, 04 Nov 2004 06:59:07 +0100
Message-Id: <1099547947.7022.3.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P3mrvbys7tYykU7mqurN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The add_hotplug_env_var() function is available and so use it in the
firmware class code.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-P3mrvbys7tYykU7mqurN
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/base/firmware_class.c 1.23 vs edited =====
--- 1.23/drivers/base/firmware_class.c	2004-10-28 09:39:58 +02:00
+++ edited/drivers/base/firmware_class.c	2004-11-02 06:47:50 +01:00
@@ -94,19 +94,17 @@
 		       int num_envp, char *buffer, int buffer_size)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	int i = 0;
-	char *scratch = buffer;
+	int i = 0, len = 0;
 
 	if (!test_bit(FW_STATUS_READY, &fw_priv->status))
 		return -ENODEV;
 
-	if (buffer_size < (FIRMWARE_NAME_MAX + 10))
-		return -ENOMEM;
-	if (num_envp < 1)
+	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
+			"FIRMWARE=%s", fw_priv->fw_id))
 		return -ENOMEM;
 
-	envp[i++] = scratch;
-	scratch += sprintf(scratch, "FIRMWARE=%s", fw_priv->fw_id) + 1;
+	envp[i++] = NULL;
+
 	return 0;
 }
 

--=-P3mrvbys7tYykU7mqurN--

