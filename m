Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUFJGrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUFJGrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUFJGrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:47:14 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:25516 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266189AbUFJGqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:46:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 1/3] Suppress platform device suffixes - take 2
Date: Thu, 10 Jun 2004 01:42:13 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <20040609231920.GA9132@kroah.com> <200406100140.30621.dtor_core@ameritech.net>
In-Reply-To: <200406100140.30621.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406100142.14861.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1766, 2004-06-09 23:55:59-05:00, dtor_core@ameritech.net
  sysfs: Do not add numeric suffix to platform device name if device
         id is set to -1. This can be used when there can be only one
         instance of a device (like i8042).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 platform.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-06-10 01:33:27 -05:00
+++ b/drivers/base/platform.c	2004-06-10 01:33:27 -05:00
@@ -33,7 +33,10 @@
 
 	pdev->dev.bus = &platform_bus_type;
 	
-	snprintf(pdev->dev.bus_id,BUS_ID_SIZE,"%s%u",pdev->name,pdev->id);
+	if (pdev->id != -1)
+		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
+	else
+		strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
 
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 pdev->dev.bus_id,pdev->dev.parent->bus_id);
