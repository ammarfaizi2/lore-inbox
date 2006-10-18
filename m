Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422796AbWJRUMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWJRUMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422867AbWJRUJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30698 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422830AbWJRUJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:27 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <matthew@wil.cx>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/16] Fix dev_printk() is now GPL-only
Date: Wed, 18 Oct 2006 13:08:54 -0700
Message-Id: <1161202153578-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021503109-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <matthew@wil.cx>

Make dev_printk usable from non-GPL modules again

dev_printk now calls dev_driver_string.  We want even proprietary modules
to be calling dev_printk, so the export of dev_driver_string needs to be
non-GPL-only.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b224bb4..aee3743 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,7 +44,7 @@ const char *dev_driver_string(struct dev
 	return dev->driver ? dev->driver->name :
 			(dev->bus ? dev->bus->name : "");
 }
-EXPORT_SYMBOL_GPL(dev_driver_string);
+EXPORT_SYMBOL(dev_driver_string);
 
 #define to_dev(obj) container_of(obj, struct device, kobj)
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
-- 
1.4.2.4

