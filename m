Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWELX7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWELX7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWELX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:31 -0400
Received: from mx.pathscale.com ([64.160.42.68]:59561 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932274AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 31 of 53] ipath - forbid sending of bad packet sizes
X-Mercurial-Node: 4868daa7f215e154629545bc543f01d6bd435824
Message-Id: <4868daa7f215e1546295.1147477396@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:16 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r b098b021b6fd -r 4868daa7f215 drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Fri May 12 15:55:28 2006 -0700
@@ -273,6 +273,11 @@ int ipath_post_ud_send(struct ipath_qp *
 		}
 		len += wr->sg_list[i].length;
 		ss.num_sge++;
+	}
+	/* Check for invalid packet size. */
+	if (len > ipath_layer_get_ibmtu(dev->dd)) {
+		ret = -EINVAL;
+		goto bail;
 	}
 	extra_bytes = (4 - len) & 3;
 	nwords = (len + extra_bytes) >> 2;
