Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVF3GKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVF3GKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVF3GHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:07:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:30860 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262867AbVF3GE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:04:28 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Driver core: Use klist_del() instead of klist_remove().
In-Reply-To: <11201114622095@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 29 Jun 2005 23:04:22 -0700
Message-Id: <11201114624155@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: Use klist_del() instead of klist_remove().

Use klist_del() instead of klist_remove() when unregistering devices.
This will prevent a deadlock when executing a recursive unregister using
device_for_each_child().

Signed-off-by Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d62c0f9fd2d3943a3eca85b490d86e1605000ccb
tree c9fc174992f7746f680becdeaa1bdb6924108c0f
parent 23d3d602cb96addd3c1158424fb01a49ea5e81b1
author Patrick Mochel <mochel@digitalimplant.org> Fri, 24 Jun 2005 08:39:33 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 29 Jun 2005 22:48:05 -0700

 drivers/base/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -333,7 +333,7 @@ void device_del(struct device * dev)
 	struct device * parent = dev->parent;
 
 	if (parent)
-		klist_remove(&dev->knode_parent);
+		klist_del(&dev->knode_parent);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...

