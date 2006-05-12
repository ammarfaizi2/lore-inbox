Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWELXpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWELXpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWELXoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:38 -0400
Received: from mx.pathscale.com ([64.160.42.68]:50601 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932190AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 53] ipath - forbid creation of AH with DLID of 0
X-Mercurial-Node: def81ab50644b0df93fd6f47c67502c02f9d6447
Message-Id: <def81ab50644b0df93fd.1147477371@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:51 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow an AH to be created with a DLID of 0.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r db56c0ab6a64 -r def81ab50644 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
@@ -810,6 +810,11 @@ static struct ib_ah *ipath_create_ah(str
 	if (ah_attr->dlid >= IPS_MULTICAST_LID_BASE &&
 	    ah_attr->dlid != IPS_PERMISSIVE_LID &&
 	    !(ah_attr->ah_flags & IB_AH_GRH)) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
+	if (ah_attr->dlid == 0) {
 		ret = ERR_PTR(-EINVAL);
 		goto bail;
 	}
