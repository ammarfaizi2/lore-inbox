Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVDAUz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVDAUz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVDAUzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:55:19 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262901AbVDAUvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:12 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][12/27] IB/mthca: fix format of CQ number for CQ events
In-Reply-To: <2005411249.0RpxZQTVnbUL56cR@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.mBxBGEwdeob5Gy84@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0091 (UTC) FILETIME=[5AAD9130:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CQ numbers are only 24 bits, so only print 6 hex digits and mask off
reserved part when reporting a CQ event.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-31 19:06:55.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_eq.c	2005-04-01 12:38:24.575625986 -0800
@@ -344,10 +344,10 @@
 			break;
 
 		case MTHCA_EVENT_TYPE_CQ_ERROR:
-			mthca_warn(dev, "CQ %s on CQN %08x\n",
+			mthca_warn(dev, "CQ %s on CQN %06x\n",
 				   eqe->event.cq_err.syndrome == 1 ?
 				   "overrun" : "access violation",
-				   be32_to_cpu(eqe->event.cq_err.cqn));
+				   be32_to_cpu(eqe->event.cq_err.cqn) & 0xffffff);
 			break;
 
 		case MTHCA_EVENT_TYPE_EQ_OVERFLOW:

