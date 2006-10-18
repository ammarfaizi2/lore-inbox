Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422877AbWJRUMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422877AbWJRUMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWJRUMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:12:13 -0400
Received: from ns1.suse.de ([195.135.220.2]:28082 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422868AbWJRUJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:57 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/16] driver core: kmalloc() failure check in driver_probe_device
Date: Wed, 18 Oct 2006 13:09:07 -0700
Message-Id: <1161202198621-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021942412-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com> <11612021733101-git-send-email-greg@kroah.com> <11612021771048-git-send-email-greg@kroah.com> <11612021801495-git-send-email-greg@kroah.com> <11612021841579-git-send-email-greg@kroah.com> <11612021872574-git-send-email-greg@kroah.com> <11612021903607-git-send-email-greg@kroah.com> <11612021942412-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

driver_probe_device() is missing kmalloc() failure check.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/dd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ef7db69..db01b95 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -171,6 +171,8 @@ int driver_probe_device(struct device_dr
 		 drv->bus->name, dev->bus_id, drv->name);
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 	data->drv = drv;
 	data->dev = dev;
 
-- 
1.4.2.4

