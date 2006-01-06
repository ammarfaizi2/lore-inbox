Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752369AbWAFQiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbWAFQiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbWAFQ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:29:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18879 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752369AbWAFQ3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:47 -0500
Date: Fri, 6 Jan 2006 16:29:37 GMT
Message-Id: <200601061629.k06GTbJo011388@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 14/17] FRV: Stop the IEEE1394 nodemanager from accessing sem count directly
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch stops the IEEE1394 nodemanager from accessing the internals
of a semaphore directly. On the FRV arch, what it does does not work, and
there's a macro for doing what it wants.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 ieee1394-2615.diff
 drivers/ieee1394/nodemgr.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.15/drivers/ieee1394/nodemgr.c linux-2.6.15-frv/drivers/ieee1394/nodemgr.c
--- /warthog/kernels/linux-2.6.15/drivers/ieee1394/nodemgr.c	2006-01-04 12:39:26.000000000 +0000
+++ linux-2.6.15-frv/drivers/ieee1394/nodemgr.c	2006-01-06 14:43:43.000000000 +0000
@@ -284,7 +284,7 @@ static DEVICE_ATTR(bus_options,S_IRUGO,f
 static ssize_t fw_show_ne_tlabels_free(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
-	return sprintf(buf, "%d\n", atomic_read(&ne->tpool->count.count) + 1);
+	return sprintf(buf, "%d\n", sem_getcount(&ne->tpool->count) + 1);
 }
 static DEVICE_ATTR(tlabels_free,S_IRUGO,fw_show_ne_tlabels_free,NULL);
 
