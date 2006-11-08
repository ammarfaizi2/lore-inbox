Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965599AbWKHMq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965599AbWKHMq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965613AbWKHMq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:46:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:64724 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965599AbWKHMq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:46:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=bobKwANtQLRf5ATqon8OKwiv7i7ROto/0C631wt/YoqxNzXM9dtIERokKFR2Jqjm5sYnFnU8xCkUWfUyJf7ICKItoxBsXV70pbHIvlN8yTFVMr6Ej4hyOn+sb6SAqGiV0BGsZ5wcFNh9ecCLHX5YZ7/8fA763MA9LkSBHXr92Xo=
Date: Wed, 8 Nov 2006 21:46:22 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>
Subject: [PATCH] drm: fix return value check
Message-ID: <20061108124622.GF14871@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

class_create() and class_device_create() return error code as a
pointer on failure. These return values need to be checked by
IS_ERR().

Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/char/drm/drm_sysfs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: work-fault-inject/drivers/char/drm/drm_sysfs.c
===================================================================
--- work-fault-inject.orig/drivers/char/drm/drm_sysfs.c
+++ work-fault-inject/drivers/char/drm/drm_sysfs.c
@@ -45,8 +45,8 @@ struct class *drm_sysfs_create(struct mo
 	int err;
 
 	class = class_create(owner, name);
-	if (!class) {
-		err = -ENOMEM;
+	if (IS_ERR(class)) {
+		err = PTR_ERR(class);
 		goto err_out;
 	}
 
@@ -113,8 +113,8 @@ struct class_device *drm_sysfs_device_ad
 					MKDEV(DRM_MAJOR, head->minor),
 					&(head->dev->pdev)->dev,
 					"card%d", head->minor);
-	if (!class_dev) {
-		err = -ENOMEM;
+	if (IS_ERR(class_dev)) {
+		err = PTR_ERR(class_dev);
 		goto err_out;
 	}
 
