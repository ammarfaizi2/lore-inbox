Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUFVSHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUFVSHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUFVSGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:06:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:32181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265053AbUFVRnU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:20 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926112618@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:52 -0700
Message-Id: <1087926112915@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.20, 2004/06/10 09:25:58-07:00, dtor_core@ameritech.net

[PATCH] Driver Core: Suppress platform device suffixes

Do not add numeric suffix to platform device name if device id is set to
-1. This can be used when there can be only one instance of a device
(like i8042).

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	Tue Jun 22 09:47:19 2004
+++ b/drivers/base/platform.c	Tue Jun 22 09:47:19 2004
@@ -117,7 +117,10 @@
 
 	pdev->dev.bus = &platform_bus_type;
 	
-	snprintf(pdev->dev.bus_id,BUS_ID_SIZE,"%s%u",pdev->name,pdev->id);
+	if (pdev->id != -1)
+		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
+	else
+		strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
 
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 pdev->dev.bus_id,pdev->dev.parent->bus_id);

