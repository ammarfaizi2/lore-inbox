Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVCPTfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVCPTfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVCPTet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:34:49 -0500
Received: from [205.233.219.253] ([205.233.219.253]:32908 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262768AbVCPTcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:32:51 -0500
Date: Wed, 16 Mar 2005 14:31:00 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       willy@debian.org, nathans@sgi.com
Subject: Re: [PATCH, RFC 4/4] Use sem_getcount in ieee1394
Message-ID: <20050316193100.GC1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org> <20050311053144.GP1111@conscoop.ottawa.on.ca> <20050310215652.76c47856.akpm@osdl.org> <20050311122747.GL21986@parcelfarce.linux.theplanet.co.uk> <20050311170449.GS1111@conscoop.ottawa.on.ca> <20050316192709.GZ1111@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316192709.GZ1111@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 1394's node manager to use sem_getcount instead of nasty hack.

Tested on parisc (where it eliminates a warning), ia64, i386.

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: 1394-dev/drivers/ieee1394/nodemgr.c
===================================================================
--- 1394-dev.orig/drivers/ieee1394/nodemgr.c	2005-03-15 18:23:35.000000000 -0500
+++ 1394-dev/drivers/ieee1394/nodemgr.c	2005-03-15 18:23:35.000000000 -0500
@@ -284,7 +284,7 @@ static DEVICE_ATTR(bus_options,S_IRUGO,f
 static ssize_t fw_show_ne_tlabels_free(struct device *dev, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
-	return sprintf(buf, "%d\n", atomic_read(&ne->tpool->count.count) + 1);
+	return sprintf(buf, "%d\n", sem_getcount(&ne->tpool->count) + 1);
 }
 static DEVICE_ATTR(tlabels_free,S_IRUGO,fw_show_ne_tlabels_free,NULL);
 
