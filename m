Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVKCEa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVKCEa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVKCEag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:30:36 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:64590 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030321AbVKCEac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:30:32 -0500
Message-Id: <20051103042818.501304000.dtor_core@ameritech.net>
References: <20051103042121.394220000.dtor_core@ameritech.net>
Date: Wed, 02 Nov 2005 23:21:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 4/7] Fix input device deregistration
Content-Disposition: inline; filename=input-remove-dev-attr-group.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: fix input device deregistration

Remove main attribute group (name, phys, uniq) when unregistering
input devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -805,6 +805,7 @@ void input_unregister_device(struct inpu
 
 	sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+	sysfs_remove_group(&dev->cdev.kobj, &input_dev_group);
 	class_device_unregister(&dev->cdev);
 
 	input_wakeup_procfs_readers();

