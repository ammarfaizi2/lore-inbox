Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWCDA4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWCDA4h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWCDA4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:56:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750946AbWCDA42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:56:28 -0500
Message-ID: <4408E612.60401@ce.jp.nec.com>
Date: Fri, 03 Mar 2006 19:57:54 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
CC: Lars Marowsky-Bree <lmb@suse.de>, akpm@osdl.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 4/6] bd_claim_by_disk
References: <4408E33E.1080703@ce.jp.nec.com>
In-Reply-To: <4408E33E.1080703@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------030502050400080208050601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030502050400080208050601
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md sysfs dependency tree.

This adds variants of bd_claim_by_kobject which takes gendisk instead
of kobject and do kobject_{get,put}(&gendisk->slave_dir).

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------030502050400080208050601
Content-Type: text/x-patch;
 name="04-bd_claim_by_disk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-bd_claim_by_disk.patch"

Variants of bd_claim_by_kobject which takes gendisk instead
of kobject and do kobject_{get,put}(&gendisk->slave_dir).

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 include/linux/genhd.h |   13 +++++++++++++
 1 files changed, 13 insertions(+)

--- linux-2.6.16-rc5.orig/include/linux/genhd.h	2006-02-27 00:09:35.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/genhd.h	2006-03-02 10:29:55.000000000 -0500
@@ -421,6 +424,19 @@ static inline struct block_device *bdget
 	return bdget(MKDEV(disk->major, disk->first_minor) + index);
 }
 
+static inline int bd_claim_by_disk(struct block_device *bdev,
+					void *holder, struct gendisk *disk)
+{
+	return bd_claim_by_kobject(bdev, holder, kobject_get(disk->slave_dir));
+}
+
+static inline void bd_release_from_disk(struct block_device *bdev,
+					struct gendisk *disk)
+{
+	bd_release_from_kobject(bdev, disk->slave_dir);
+	kobject_put(disk->slave_dir);
+}
+
 #endif
 
 #endif

--------------030502050400080208050601--
