Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265703AbUFIH0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbUFIH0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 03:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUFIH0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 03:26:10 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:1897 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265684AbUFIHZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 03:25:55 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Suppress platform device suffixes
Date: Wed, 9 Jun 2004 02:24:03 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <200406090222.45805.dtor_core@ameritech.net>
In-Reply-To: <200406090222.45805.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406090224.04876.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1834, 2004-06-08 23:46:49-05:00, dtor_core@ameritech.net
  sysfs: Do not add numeric suffix to platform device name if device
         id is set to -1. This can be used when there can be only one
         instance of a device (like i8042).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 platform.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-06-09 01:26:06 -05:00
+++ b/drivers/base/platform.c	2004-06-09 01:26:06 -05:00
@@ -33,7 +33,10 @@
 
 	pdev->dev.bus = &platform_bus_type;
 
-	snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
+	if (pdev->id != -1)
+		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
+	else
+		strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
 
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 pdev->dev.bus_id, pdev->dev.parent->bus_id);
