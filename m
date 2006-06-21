Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWFUTyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWFUTyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWFUTy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:54:29 -0400
Received: from mail.suse.de ([195.135.220.2]:38577 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030255AbWFUTuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:50:04 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Russell King <rmk@arm.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/22] [PATCH] Driver Core: Fix platform_device_add to use device_add
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:55 -0700
Message-Id: <11509192022315-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191982588-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>

platform_device_add() should be using device_add() rather
than device_register() - any platform device passed to
platform_device_add() should have already been initialised,
either by platform_device_alloc() or platform_device_register().

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f807197..2b8755d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -275,7 +275,7 @@ int platform_device_add(struct platform_
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 pdev->dev.bus_id, pdev->dev.parent->bus_id);
 
-	ret = device_register(&pdev->dev);
+	ret = device_add(&pdev->dev);
 	if (ret == 0)
 		return ret;
 
-- 
1.4.0

