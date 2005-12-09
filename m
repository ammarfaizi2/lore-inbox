Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVLIVwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVLIVwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVLIVw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:52:27 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:56955 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964884AbVLIVwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:52:13 -0500
X-IronPort-AV: i="3.99,235,1131350400"; 
   d="scan'208"; a="376315020:sNHT35474004534"
Subject: [git patch review 5/5] IB/mthca: fix memory user DB table leak
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 09 Dec 2005 21:51:50 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134165110301-b5d3e449a24a06fe@cisco.com>
In-Reply-To: <1134165110301-ac635a95a66180bb@cisco.com>
X-OriginalArrivalTime: 09 Dec 2005 21:51:51.0409 (UTC) FILETIME=[C310DE10:01C5FD0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Free the memory allocated in mthca_init_user_db_tab() when releasing
the db_tab in mthca_cleanup_user_db_tab().

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_memfree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

52d0df153c987e4ad57d15f5df91848f65858e5d
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index d72fe95..5798ed0 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -485,6 +485,8 @@ void mthca_cleanup_user_db_tab(struct mt
 			put_page(db_tab->page[i].mem.page);
 		}
 	}
+
+	kfree(db_tab);
 }
 
 int mthca_alloc_db(struct mthca_dev *dev, enum mthca_db_type type,
-- 
0.99.9l
