Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVDAWGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVDAWGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVDAUxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:53:55 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262893AbVDAUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:03 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][3/27] IB/mthca: fix calculation of RDB shift
In-Reply-To: <2005411249.WCbW5NdE7NBIkIcr@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.ETBNcLeftemLukfd@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0356 (UTC) FILETIME=[5A3D6A40:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix calculation of rdb_shift by using original number of QPs, not
their slot in profile[] (which will be rearranged when we sort it).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_profile.c	2005-03-31 19:07:14.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-01 12:38:21.237350633 -0800
@@ -208,8 +208,7 @@
 			break;
 		case MTHCA_RES_RDB:
 			for (dev->qp_table.rdb_shift = 0;
-			     profile[MTHCA_RES_QP].num << dev->qp_table.rdb_shift <
-				     profile[i].num;
+			     request->num_qp << dev->qp_table.rdb_shift < profile[i].num;
 			     ++dev->qp_table.rdb_shift)
 				; /* nothing */
 			dev->qp_table.rdb_base    = (u32) profile[i].start;

