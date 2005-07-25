Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVGYGqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVGYGqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVGYFyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:43 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:5007 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261639AbVGYFxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:21 -0400
Message-Id: <20050725054530.674379000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 01/24] uinput: formatting, cleanup
Content-Disposition: inline; filename=uinput-cleanup.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: clean up uinput driver (formatting, extra braces)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/uinput.c |   81 +++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 46 deletions(-)

Index: work/drivers/input/misc/uinput.c
===================================================================
--- work.orig/drivers/input/misc/uinput.c
+++ work/drivers/input/misc/uinput.c
@@ -36,16 +36,6 @@
 #include <linux/miscdevice.h>
 #include <linux/uinput.h>
 
-static int uinput_dev_open(struct input_dev *dev)
-{
-	return 0;
-}
-
-static void uinput_dev_close(struct input_dev *dev)
-{
-
-}
-
 static int uinput_dev_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct uinput_device	*udev;
@@ -68,17 +58,20 @@ static int uinput_request_alloc_id(struc
 	/* Atomically allocate an ID for the given request. Returns 0 on success. */
 	struct uinput_device *udev = dev->private;
 	int id;
+	int err = -1;
 
 	down(&udev->requests_sem);
-	for (id=0; id<UINPUT_NUM_REQUESTS; id++)
+
+	for (id = 0; id < UINPUT_NUM_REQUESTS; id++)
 		if (!udev->requests[id]) {
 			udev->requests[id] = request;
 			request->id = id;
-			up(&udev->requests_sem);
-			return 0;
+			err = 0;
+			break;
 		}
+
 	up(&udev->requests_sem);
-	return -1;
+	return err;
 }
 
 static struct uinput_request* uinput_request_find(struct uinput_device *udev, int id)
@@ -101,7 +94,7 @@ static void uinput_request_init(struct i
 
 	/* Allocate an ID. If none are available right away, wait. */
 	request->retval = wait_event_interruptible(udev->requests_waitq,
-				       !uinput_request_alloc_id(dev, request));
+					!uinput_request_alloc_id(dev, request));
 }
 
 static void uinput_request_submit(struct input_dev *dev, struct uinput_request *request)
@@ -159,32 +152,30 @@ static int uinput_create_device(struct u
 		return -EINVAL;
 	}
 
-	udev->dev->open = uinput_dev_open;
-	udev->dev->close = uinput_dev_close;
 	udev->dev->event = uinput_dev_event;
 	udev->dev->upload_effect = uinput_dev_upload_effect;
 	udev->dev->erase_effect = uinput_dev_erase_effect;
 	udev->dev->private = udev;
 
-	init_waitqueue_head(&(udev->waitq));
+	init_waitqueue_head(&udev->waitq);
 
 	input_register_device(udev->dev);
 
-	set_bit(UIST_CREATED, &(udev->state));
+	set_bit(UIST_CREATED, &udev->state);
 
 	return 0;
 }
 
 static int uinput_destroy_device(struct uinput_device *udev)
 {
-	if (!test_bit(UIST_CREATED, &(udev->state))) {
+	if (!test_bit(UIST_CREATED, &udev->state)) {
 		printk(KERN_WARNING "%s: create the device first\n", UINPUT_NAME);
 		return -EINVAL;
 	}
 
 	input_unregister_device(udev->dev);
 
-	clear_bit(UIST_CREATED, &(udev->state));
+	clear_bit(UIST_CREATED, &udev->state);
 
 	return 0;
 }
@@ -253,15 +244,15 @@ static int uinput_alloc_device(struct fi
 	struct uinput_user_dev	*user_dev;
 	struct input_dev	*dev;
 	struct uinput_device	*udev;
-	int			size,
-				retval;
+	int			size;
+	int			retval;
 
 	retval = count;
 
 	udev = file->private_data;
 	dev = udev->dev;
 
-	user_dev = kmalloc(sizeof(*user_dev), GFP_KERNEL);
+	user_dev = kmalloc(sizeof(struct uinput_user_dev), GFP_KERNEL);
 	if (!user_dev) {
 		retval = -ENOMEM;
 		goto exit;
@@ -272,7 +263,7 @@ static int uinput_alloc_device(struct fi
 		goto exit;
 	}
 
-	if (NULL != dev->name)
+	if (dev->name)
 		kfree(dev->name);
 
 	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE) + 1;
@@ -314,14 +305,13 @@ static ssize_t uinput_write(struct file 
 {
 	struct uinput_device *udev = file->private_data;
 
-	if (test_bit(UIST_CREATED, &(udev->state))) {
+	if (test_bit(UIST_CREATED, &udev->state)) {
 		struct input_event	ev;
 
 		if (copy_from_user(&ev, buffer, sizeof(struct input_event)))
 			return -EFAULT;
 		input_event(udev->dev, ev.type, ev.code, ev.value);
-	}
-	else
+	} else
 		count = uinput_alloc_device(file, buffer, count);
 
 	return count;
@@ -332,26 +322,24 @@ static ssize_t uinput_read(struct file *
 	struct uinput_device *udev = file->private_data;
 	int retval = 0;
 
-	if (!test_bit(UIST_CREATED, &(udev->state)))
+	if (!test_bit(UIST_CREATED, &udev->state))
 		return -ENODEV;
 
-	if ((udev->head == udev->tail) && (file->f_flags & O_NONBLOCK))
+	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(udev->waitq,
-			(udev->head != udev->tail) ||
-			!test_bit(UIST_CREATED, &(udev->state)));
-
+			udev->head != udev->tail || !test_bit(UIST_CREATED, &udev->state));
 	if (retval)
 		return retval;
 
-	if (!test_bit(UIST_CREATED, &(udev->state)))
+	if (!test_bit(UIST_CREATED, &udev->state))
 		return -ENODEV;
 
 	while ((udev->head != udev->tail) &&
 	    (retval + sizeof(struct input_event) <= count)) {
-		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
-		    sizeof(struct input_event))) return -EFAULT;
+		if (copy_to_user(buffer + retval, &udev->buff[udev->tail], sizeof(struct input_event)))
+			return -EFAULT;
 		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
 		retval += sizeof(struct input_event);
 	}
@@ -373,12 +361,12 @@ static unsigned int uinput_poll(struct f
 
 static int uinput_burn_device(struct uinput_device *udev)
 {
-	if (test_bit(UIST_CREATED, &(udev->state)))
+	if (test_bit(UIST_CREATED, &udev->state))
 		uinput_destroy_device(udev);
 
-	if (NULL != udev->dev->name)
+	if (udev->dev->name)
 		kfree(udev->dev->name);
-	if (NULL != udev->dev->phys)
+	if (udev->dev->phys)
 		kfree(udev->dev->phys);
 
 	kfree(udev->dev);
@@ -389,7 +377,8 @@ static int uinput_burn_device(struct uin
 
 static int uinput_close(struct inode *inode, struct file *file)
 {
-	return uinput_burn_device(file->private_data);
+	uinput_burn_device(file->private_data);
+	return 0;
 }
 
 static int uinput_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -415,7 +404,7 @@ static int uinput_ioctl(struct inode *in
 		case UI_SET_SNDBIT:
 		case UI_SET_FFBIT:
 		case UI_SET_PHYS:
-			if (test_bit(UIST_CREATED, &(udev->state)))
+			if (test_bit(UIST_CREATED, &udev->state))
 				return -EINVAL;
 	}
 
@@ -511,7 +500,7 @@ static int uinput_ioctl(struct inode *in
 				udev->dev->phys = NULL;
 				break;
 			}
-			udev->dev->phys[length-1] = '\0';
+			udev->dev->phys[length - 1] = '\0';
 			break;
 
 		case UI_BEGIN_FF_UPLOAD:
@@ -520,7 +509,7 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!(req && req->code==UI_FF_UPLOAD && req->u.effect)) {
+			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
 				retval = -EINVAL;
 				break;
 			}
@@ -538,7 +527,7 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_erase.request_id);
-			if (!(req && req->code==UI_FF_ERASE)) {
+			if (!(req && req->code == UI_FF_ERASE)) {
 				retval = -EINVAL;
 				break;
 			}
@@ -556,7 +545,7 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!(req && req->code==UI_FF_UPLOAD && req->u.effect)) {
+			if (!(req && req->code == UI_FF_UPLOAD && req->u.effect)) {
 				retval = -EINVAL;
 				break;
 			}
@@ -572,7 +561,7 @@ static int uinput_ioctl(struct inode *in
 				break;
 			}
 			req = uinput_request_find(udev, ff_erase.request_id);
-			if (!(req && req->code==UI_FF_ERASE)) {
+			if (!(req && req->code == UI_FF_ERASE)) {
 				retval = -EINVAL;
 				break;
 			}

