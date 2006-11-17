Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424822AbWKQAly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424822AbWKQAly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424823AbWKQAli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:41:38 -0500
Received: from mx1.suse.de ([195.135.220.2]:56960 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424822AbWKQAlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:41:36 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Amol Lad <amol@verismonetworks.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/3] W1: ioremap balanced with iounmap
Date: Thu, 16 Nov 2006 16:41:36 -0800
Message-Id: <11637240981960-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.3.5
In-Reply-To: <20061117000740.GB687@kroah.com>
References: <20061117000740.GB687@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Lad <amol@verismonetworks.com>

ioremap must be balanced with iounmap in error path.

Please consider for 2.6.19.

Signed-off-by: Amol Lad <amol@verismonetworks.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/masters/matrox_w1.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index 2788b8c..6f9d880 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -215,6 +215,8 @@ static int __devinit matrox_w1_probe(str
 	return 0;
 
 err_out_free_device:
+	if (dev->virt_addr)
+		iounmap(dev->virt_addr);
 	kfree(dev);
 
 	return err;
-- 
1.4.3.5

