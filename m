Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWEMAAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWEMAAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWELX5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:24 -0400
Received: from mx.pathscale.com ([64.160.42.68]:58281 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932279AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 28 of 53] ipath - forbid setting of invalid MLID
X-Mercurial-Node: 47f1df66d0979b655d010233cdfbfaaa66bf16fe
Message-Id: <47f1df66d0979b655d01.1147477393@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:13 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 551966b88d7c -r 47f1df66d097 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri May 12 15:55:28 2006 -0700
@@ -221,7 +221,7 @@ static ssize_t store_mlid(struct device 
 	int ret;
 
 	ret = ipath_parse_ushort(buf, &mlid);
-	if (ret < 0)
+	if (ret < 0 || mlid < 0xc000)
 		goto invalid;
 
 	unit = dd->ipath_unit;
