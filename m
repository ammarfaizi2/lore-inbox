Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVCKAP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVCKAP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbVCKALz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:11:55 -0500
Received: from [205.233.219.253] ([205.233.219.253]:62412 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262903AbVCKAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:09:21 -0500
Date: Thu, 10 Mar 2005 19:08:59 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: linux-kernel@vger.kernel.org
Cc: willy@debian.org
Subject: Re: [PATCH, RFC 2/3] Use sem_getcount in ieee1394
Message-ID: <20050311000859.GK1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert 1394's node manager to use sem_getcount instead of nasty hack.
Tested on parisc (where it eliminates a warning), ia64, i386.

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: 1394-dev/drivers/ieee1394/nodemgr.c
===================================================================
--- 1394-dev.orig/drivers/ieee1394/nodemgr.c	2005-03-08 16:50:40.000000000 -0500
+++ 1394-dev/drivers/ieee1394/nodemgr.c	2005-03-08 16:51:07.000000000 -0500
@@ -284,7 +284,7 @@ static DEVICE_ATTR(bus_options,S_IRUGO,f
 static ssize_t fw_show_ne_tlabels_free(struct device *dev, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
-	return sprintf(buf, "%d\n", atomic_read(&ne->tpool->count.count) + 1);
+	return sprintf(buf, "%d\n", sem_getcount(&ne->tpool->count) + 1);
 }
 static DEVICE_ATTR(tlabels_free,S_IRUGO,fw_show_ne_tlabels_free,NULL);
 
