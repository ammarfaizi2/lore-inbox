Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422811AbWJRUJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbWJRUJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWJRUJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:5554 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422809AbWJRUJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:09 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Duncan Sands <duncan.sands@free.fr>, Duncan Sands <baldrick@free.fr>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/16] Driver core: plug device probe memory leak
Date: Wed, 18 Oct 2006 13:08:53 -0700
Message-Id: <11612021503109-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202147758-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Sands <duncan.sands@free.fr>

Make sure data is freed if the kthread fails to start.

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/dd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b5f43c3..ef7db69 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -178,7 +178,7 @@ int driver_probe_device(struct device_dr
 		probe_task = kthread_run(really_probe, data,
 					 "probe-%s", dev->bus_id);
 		if (IS_ERR(probe_task))
-			ret = PTR_ERR(probe_task);
+			ret = really_probe(data);
 	} else
 		ret = really_probe(data);
 
-- 
1.4.2.4

