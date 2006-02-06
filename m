Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWBFU37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWBFU37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWBFU3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:29:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:27581 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964788AbWBFU3g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:36 -0500
Cc: gregkh@suse.de
Subject: [PATCH] kobject_add() must have a valid name in order to succeed.
In-Reply-To: <11392577571177@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:17 -0800
Message-Id: <11392577571272@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kobject_add() must have a valid name in order to succeed.

So we might as well check to verify this, and let the user know that
something is wrong if they didn't do it correctly, instead of oopsing
later on in kobject_get_name() or somewhere else.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c171fef5c8566cf5f57877e7832fa696ecdf5228
tree c599efed9172ce2f31835d4df01936063fad3a77
parent e3f749c4af69c4344d89f11e2293e3790eb4eaca
author Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 14:08:59 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 lib/kobject.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 7a0e680..fe4ae36 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -162,6 +162,11 @@ int kobject_add(struct kobject * kobj)
 		return -ENOENT;
 	if (!kobj->k_name)
 		kobj->k_name = kobj->name;
+	if (!kobj->k_name) {
+		pr_debug("kobject attempted to be registered with no name!\n");
+		WARN_ON(1);
+		return -EINVAL;
+	}
 	parent = kobject_get(kobj->parent);
 
 	pr_debug("kobject %s: registering. parent: %s, set: %s\n",

