Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264069AbUKZUyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbUKZUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbUKZUq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:46:58 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:34487 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264125AbUKZUar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:30:47 -0500
Subject: Re: [PATCH] fix unnecessary increment in firmware_class_hotplug()
From: Marcel Holtmann <marcel@holtmann.org>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <20041125201935.213944c9.tokunaga.keiich@jp.fujitsu.com>
References: <20041125201935.213944c9.tokunaga.keiich@jp.fujitsu.com>
Content-Type: multipart/mixed; boundary="=-ctrC57uegPp7IIA6Ar3B"
Date: Fri, 26 Nov 2004 21:30:24 +0100
Message-Id: <1101501024.6514.52.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ctrC57uegPp7IIA6Ar3B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Keiichiro,

>   This patch is to fix unnecessary increment of 'i' used to
> specify an element of an arry 'envp[]' in firmware_class_hotplug().
> The 'i' is already incremented in add_hotplug_env_var(), actually.

you are right. The incrementation is wrong, but it doesn't have any
negative effect. However the same applies for the usb_hotplug() function
in drivers/usb/core/usb.c.

> Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


--=-ctrC57uegPp7IIA6Ar3B
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/usb/core/usb.c 1.182 vs edited =====
--- 1.182/drivers/usb/core/usb.c	2004-11-07 23:31:07 +01:00
+++ edited/drivers/usb/core/usb.c	2004-11-26 21:27:08 +01:00
@@ -656,7 +656,7 @@
 			return -ENOMEM;
 	}
 
-	envp[i++] = NULL;
+	envp[i] = NULL;
 
 	return 0;
 }
===== drivers/base/firmware_class.c 1.24 vs edited =====
--- 1.24/drivers/base/firmware_class.c	2004-11-08 03:16:05 +01:00
+++ edited/drivers/base/firmware_class.c	2004-11-26 21:26:48 +01:00
@@ -103,7 +103,7 @@
 			"FIRMWARE=%s", fw_priv->fw_id))
 		return -ENOMEM;
 
-	envp[i++] = NULL;
+	envp[i] = NULL;
 
 	return 0;
 }

--=-ctrC57uegPp7IIA6Ar3B--

