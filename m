Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVDZHe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDZHe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDZHeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:34:25 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:40609 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261391AbVDZHeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:34:15 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kobject_hotplug() should use kobject_name()
Date: Tue, 26 Apr 2005 02:29:58 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>
References: <200504260229.03866.dtor_core@ameritech.net>
In-Reply-To: <200504260229.03866.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260229.58600.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject: kobject_hotplug should use kobject_name() instead of
         accessing kobj->name directly since for objects with
         long names it can contain garbage.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 kobject_uevent.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: dtor/lib/kobject_uevent.c
===================================================================
--- dtor.orig/lib/kobject_uevent.c
+++ dtor/lib/kobject_uevent.c
@@ -246,10 +246,10 @@ void kobject_hotplug(struct kobject *kob
 	if (hotplug_ops->name)
 		name = hotplug_ops->name(kset, kobj);
 	if (name == NULL)
-		name = kset->kobj.name;
+		name = kobject_name(&kset->kobj);
 
 	argv [0] = hotplug_path;
-	argv [1] = name;
+	argv [1] = name;
 	argv [2] = NULL;
 
 	/* minimal command environment */
