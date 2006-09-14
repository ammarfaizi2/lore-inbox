Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWINVrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWINVrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWINVrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:47:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50391 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751224AbWINVrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:47:40 -0400
Date: Thu, 14 Sep 2006 22:47:29 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH 15/25] dm: add uevent change event on resume
Message-ID: <20060914214729.GW3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Kay Sievers <kay.sievers@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

Device-mapper devices are not accessible until a 'resume' ioctl has been
issued.  For userspace to find out when this happens we need to generate an
uevent for udev to take appropriate action.

As discussed at OLS we should send 'change' events for 'resume'.
We can think of no useful purpose served by also having 'suspend' events.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm.c	2006-09-14 20:26:19.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm.c	2006-09-14 20:55:52.000000000 +0100
@@ -1378,6 +1378,8 @@ int dm_resume(struct mapped_device *md)
 
 	dm_table_unplug_all(map);
 
+	kobject_uevent(&md->disk->kobj, KOBJ_CHANGE);
+
 	r = 0;
 
 out:
