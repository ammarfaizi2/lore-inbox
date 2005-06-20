Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVFUCvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVFUCvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVFUCtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:49:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:17892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261676AbVFTW7k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:40 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] kobject_hotplug() should use kobject_name()
In-Reply-To: <11193083602227@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:20 -0700
Message-Id: <11193083603818@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kobject_hotplug() should use kobject_name()

kobject: kobject_hotplug should use kobject_name() instead of
         accessing kobj->name directly since for objects with
         long names it can contain garbage.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit eb11d8ffceead1eb3d84366f1687daf2217e883e
tree aedf84638f2bb8cc2d6f90120199191b917efa35
parent 8b22c249e7de453961e4d253b19fc2a0bdd65d53
author Dmitry Torokhov <dtor_core@ameritech.net> Tue, 26 Apr 2005 02:29:58 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:00 -0700

 lib/kobject_uevent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -246,7 +246,7 @@ void kobject_hotplug(struct kobject *kob
 	if (hotplug_ops->name)
 		name = hotplug_ops->name(kset, kobj);
 	if (name == NULL)
-		name = kset->kobj.name;
+		name = kobject_name(&kset->kobj);
 
 	argv [0] = hotplug_path;
 	argv [1] = name;

