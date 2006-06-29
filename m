Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932892AbWF2V5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbWF2V5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbWF2V47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:56:59 -0400
Received: from mx.pathscale.com ([64.160.42.68]:36751 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932902AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 23 of 39] IB/ipath - disallow send of invalid packet sizes
	over UD
X-Mercurial-Node: 8e39364c2402304872e6289c2a9490302e9992aa
Message-Id: <8e39364c2402304872e6.1151617274@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:14 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 811021b6c112 -r 8e39364c2402 drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:26 2006 -0700
@@ -274,6 +274,11 @@ int ipath_post_ud_send(struct ipath_qp *
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
