Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUGOAqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUGOAqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUGOAe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:34:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:41088 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266071AbUGOAUI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:08 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <10898507032619@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:23 -0700
Message-Id: <10898507032799@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.12.6, 2004/07/14 16:09:44-07:00, dtor_core@ameritech.net

[PATCH] Driver core: Fix OOPS in device_platform_unregister

Driver core: platform_device_unregister should release resources first
             and only then call device_unregister, otherwise if there
             are no more references to the device it will be freed and
             the fucntion will try to access freed memory.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-07-14 17:11:09 -07:00
+++ b/drivers/base/platform.c	2004-07-14 17:11:09 -07:00
@@ -146,13 +146,13 @@
 	int i;
 
 	if (pdev) {
-		device_unregister(&pdev->dev);
-
 		for (i = 0; i < pdev->num_resources; i++) {
 			struct resource *r = &pdev->resource[i];
 			if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
 				release_resource(r);
 		}
+
+		device_unregister(&pdev->dev);
 	}
 }
 

