Return-Path: <linux-kernel-owner+w=401wt.eu-S965102AbWLMTxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWLMTxs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWLMTxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:53:48 -0500
Received: from mx1.suse.de ([195.135.220.2]:45456 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965102AbWLMTxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:53:47 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/14] driver core: delete virtual directory on class_unregister()
Date: Wed, 13 Dec 2006 11:52:57 -0800
Message-Id: <1166039606191-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396032350-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

Class virtual directory is created as the need arises.
But it is not deleted when the class is unregistered.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index f098881..8bf2ca2 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -163,6 +163,8 @@ int class_register(struct class * cls)
 void class_unregister(struct class * cls)
 {
 	pr_debug("device class '%s': unregistering\n", cls->name);
+	if (cls->virtual_dir)
+		kobject_unregister(cls->virtual_dir);
 	remove_class_attrs(cls);
 	subsystem_unregister(&cls->subsys);
 }
-- 
1.4.4.2

