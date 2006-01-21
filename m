Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWAUWDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWAUWDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWAUWDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:03:16 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:32526 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932400AbWAUWDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:03:15 -0500
Subject: [git patch review 2/5] IB/uverbs: Flush scheduled work before
	unloading module
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 21 Jan 2006 22:03:10 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137880990999-7ca1217bcd8a8383@cisco.com>
In-Reply-To: <1137880990999-28a2de7670074e8b@cisco.com>
X-OriginalArrivalTime: 21 Jan 2006 22:03:14.0808 (UTC) FILETIME=[7A2A8780:01C61ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uverbs might schedule work to clean up when a file is closed.  Make
sure that this work runs before allowing module text to go away.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs_main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

cc76e33ec98ee2acab2d10828d31588d1b10f274
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 96ea79b..903f85a 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -902,6 +902,7 @@ static void __exit ib_uverbs_cleanup(voi
 	unregister_filesystem(&uverbs_event_fs);
 	class_destroy(uverbs_class);
 	unregister_chrdev_region(IB_UVERBS_BASE_DEV, IB_UVERBS_MAX_DEVICES);
+	flush_scheduled_work();
 	idr_destroy(&ib_uverbs_pd_idr);
 	idr_destroy(&ib_uverbs_mr_idr);
 	idr_destroy(&ib_uverbs_mw_idr);
-- 
1.1.3
