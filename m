Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWIMNeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWIMNeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWIMNeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:34:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:22518 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWIMNeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:34:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ftBbN5FSsV2bmkYXijtV7K2w3G56MlMpWjylpxSbMiZ9kX6co5OiteKEv6AbNOPmrbH1WP75xt164i8ECVjiqHxjn2JcthinUXV5v66zVMc0RjHFVDS2UbLf/uTE3qFmGfbfD+BIFJ/9r53+rpZ34Rg19OKv5M3u5mGKSUprtis=
Date: Wed, 13 Sep 2006 15:34:05 +0200
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: torvalds@osdl.org
Cc: greg@kroah.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers/base: add const to class_create
Message-Id: <20060913153405.2d7493e2.maxextreme@gmail.com>
Organization: -
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch.

Adds const to class_create second parameter, because:

struct class {
	const char * name;

	/*...*/
}

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X linux-2.6.18-rc7/Documentation/dontdiff linux-2.6.18-rc7-vanilla/drivers/base/class.c linux-2.6.18-rc7/drivers/base/class.c
--- linux-2.6.18-rc7-vanilla/drivers/base/class.c	2006-09-13 14:01:47.000000000 +0200
+++ linux-2.6.18-rc7/drivers/base/class.c	2006-09-13 14:13:16.000000000 +0200
@@ -197,7 +197,7 @@ static int class_device_create_uevent(st
  * Note, the pointer created here is to be destroyed when finished by
  * making a call to class_destroy().
  */
-struct class *class_create(struct module *owner, char *name)
+struct class *class_create(struct module *owner, const char *name)
 {
 	struct class *cls;
 	int retval;
diff -uprN -X linux-2.6.18-rc7/Documentation/dontdiff linux-2.6.18-rc7-vanilla/include/linux/device.h linux-2.6.18-rc7/include/linux/device.h
--- linux-2.6.18-rc7-vanilla/include/linux/device.h	2006-09-13 14:02:12.000000000 +0200
+++ linux-2.6.18-rc7/include/linux/device.h	2006-09-13 14:12:45.000000000 +0200
@@ -271,7 +271,7 @@ struct class_interface {
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
-extern struct class *class_create(struct module *owner, char *name);
+extern struct class *class_create(struct module *owner, const char *name);
 extern void class_destroy(struct class *cls);
 extern struct class_device *class_device_create(struct class *cls,
 						struct class_device *parent,
