Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVDAUza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVDAUza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVDAUyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:54:49 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262902AbVDAUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:10 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][9/27] IB/mthca: release mutex on doorbell alloc error path
In-Reply-To: <2005411249.mKyALgAB0GbtFnjH@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.XnosdnfHawyDkITW@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0856 (UTC) FILETIME=[5A89B580:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release mutex on error return path from mthca_alloc_db().

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:22.274125578 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:23.500859288 -0800
@@ -337,7 +337,8 @@
 		break;
 
 	default:
-		return -1;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	for (i = start; i != end; i += dir)

