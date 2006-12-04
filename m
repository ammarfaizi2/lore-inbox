Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936956AbWLDO4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936956AbWLDO4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936976AbWLDO4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:56:49 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:22534 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936965AbWLDO42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:56:28 -0500
Date: Mon, 4 Dec 2006 15:56:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: Make ccw_dev_id_is_equal() more robust.
Message-ID: <20061204145624.GB32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: Make ccw_dev_id_is_equal() more robust.

Using memcmp to compare ccw_dev_id implies that the whole structure (incl.
padding) has always been completely initialized to sane values. Comparing
the structures field by field doesn't make such assumptions.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/cio.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
--- linux-2.6/include/asm-s390/cio.h	2006-12-04 14:50:48.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cio.h	2006-12-04 14:51:00.000000000 +0100
@@ -278,7 +278,10 @@ struct ccw_dev_id {
 static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
 				      struct ccw_dev_id *dev_id2)
 {
-	return !memcmp(dev_id1, dev_id2, sizeof(struct ccw_dev_id));
+	if ((dev_id1->ssid == dev_id2->ssid) &&
+	    (dev_id1->devno == dev_id2->devno))
+		return 1;
+	return 0;
 }
 
 extern int diag210(struct diag210 *addr);
