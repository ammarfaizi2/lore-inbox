Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWEMADJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWEMADJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWEMAC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:02:56 -0400
Received: from mx.pathscale.com ([64.160.42.68]:54185 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932201AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 14 of 53] ipath - forbid empty MRs
X-Mercurial-Node: 5d9fbba3222eeb9416799f8b43e81be6fc6deb3c
Message-Id: <5d9fbba3222eeb941679.1147477379@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:59 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow zero-length regions to be created.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 02a05b853d20 -r 5d9fbba3222e drivers/infiniband/hw/ipath/ipath_mr.c
--- a/drivers/infiniband/hw/ipath/ipath_mr.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mr.c	Fri May 12 15:55:28 2006 -0700
@@ -168,6 +168,11 @@ struct ib_mr *ipath_reg_user_mr(struct i
 	struct ib_umem_chunk *chunk;
 	int n, m, i;
 	struct ib_mr *ret;
+
+	if (region->length == 0) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
 
 	n = 0;
 	list_for_each_entry(chunk, &region->chunk_list, list)
