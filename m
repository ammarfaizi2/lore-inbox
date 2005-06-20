Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVFUCVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVFUCVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVFUCTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:19:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:30692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261722AbVFTW7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:47 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: add kerneldoc for the new class functions.
In-Reply-To: <11193083633382@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <11193083633953@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: add kerneldoc for the new class functions.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2fc68447df5c76cf254037047b4b02551bd5d760
tree ce39dc9db7465fc0c1808b6216c2a835739cecfa
parent 1db560afe629b682c45a7f4ba7edf98b4ee28518
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 10:02:56 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:11 -0700

 drivers/base/class.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -173,6 +173,17 @@ static void class_device_create_release(
 	kfree(class_dev);
 }
 
+/**
+ * class_create - create a struct class structure
+ * @owner: pointer to the module that is to "own" this struct class
+ * @name: pointer to a string for the name of this class.
+ *
+ * This is used to create a struct class pointer that can then be used
+ * in calls to class_device_create().
+ *
+ * Note, the pointer created here is to be destroyed when finished by
+ * making a call to class_destroy().
+ */
 struct class *class_create(struct module *owner, char *name)
 {
 	struct class *cls;
@@ -201,6 +212,13 @@ error:
 	return ERR_PTR(retval);
 }
 
+/**
+ * class_destroy - destroys a struct class structure
+ * @cs: pointer to the struct class that is to be destroyed
+ *
+ * Note, the pointer to be destroyed must have been created with a call
+ * to class_create().
+ */
 void class_destroy(struct class *cls)
 {
 	if ((cls == NULL) || (IS_ERR(cls)))
@@ -505,6 +523,23 @@ int class_device_register(struct class_d
 	return class_device_add(class_dev);
 }
 
+/**
+ * class_device_create - creates a class device and registers it with sysfs
+ * @cs: pointer to the struct class that this device should be registered to.
+ * @dev: the dev_t for the char device to be added.
+ * @device: a pointer to a struct device that is assiociated with this class device.
+ * @fmt: string for the class device's name
+ *
+ * This function can be used by char device classes.  A struct
+ * class_device will be created in sysfs, registered to the specified
+ * class.  A "dev" file will be created, showing the dev_t for the
+ * device.  The pointer to the struct class_device will be returned from
+ * the call.  Any further sysfs files that might be required can be
+ * created using this pointer.
+ *
+ * Note: the struct class passed to this function must have previously
+ * been created with a call to class_create().
+ */
 struct class_device *class_device_create(struct class *cls, dev_t devt,
 					 struct device *device, char *fmt, ...)
 {
@@ -578,6 +613,14 @@ void class_device_unregister(struct clas
 	class_device_put(class_dev);
 }
 
+/**
+ * class_device_destroy - removes a class device that was created with class_device_create()
+ * @cls: the pointer to the struct class that this device was registered * with.
+ * @dev: the dev_t of the device that was previously registered.
+ *
+ * This call unregisters and cleans up a class device that was created with a
+ * call to class_device_create()
+ */
 void class_device_destroy(struct class *cls, dev_t devt)
 {
 	struct class_device *class_dev = NULL;

