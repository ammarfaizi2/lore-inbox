Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbUKEAsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbUKEAsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUKEAsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:48:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:31454 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262512AbUKEAso convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:48:44 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157053960@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:25 -0800
Message-Id: <10996157054012@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.8, 2004/11/04 10:57:45-08:00, tj@home-tj.org

[PATCH] driver-model: device_add() error path reference counting fix

 df_05_device_add_ref_fix.patch

 In device_add(), @dev wan't put'd properly when it has zero length
bus_id (error path).  Fixed.


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-11-04 16:30:24 -08:00
+++ b/drivers/base/core.c	2004-11-04 16:30:24 -08:00
@@ -209,12 +209,12 @@
  */
 int device_add(struct device *dev)
 {
-	struct device * parent;
-	int error;
+	struct device *parent = NULL;
+	int error = -EINVAL;
 
 	dev = get_device(dev);
 	if (!dev || !strlen(dev->bus_id))
-		return -EINVAL;
+		goto Error;
 
 	parent = get_device(dev->parent);
 

