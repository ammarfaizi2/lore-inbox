Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVAXSo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVAXSo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVAXSo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:44:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:16771 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261550AbVAXSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:44:54 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [openib-general] [PATCH][13/12] InfiniBand/mthca: initialize mutex
 earlier
X-Message-Flag: Warning: May contain useful information
References: <20051232214.rXeANNOMpj6wmqS6@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 24 Jan 2005 10:44:52 -0800
In-Reply-To: <20051232214.rXeANNOMpj6wmqS6@topspin.com> (Roland Dreier's
 message of "Sun, 23 Jan 2005 22:14:24 -0800")
Message-ID: <521xca7jkr.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Jan 2005 18:44:53.0918 (UTC) FILETIME=[CB2553E0:01C50244]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more bug that slipped in...


The cap_mask_mutex needs to be initialized before
ib_register_device(), because device registration will call client
init functions that may try to modify the capability mask.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-01-23 21:51:46.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_provider.c	2005-01-24 10:39:12.623987624 -0800
@@ -634,6 +634,8 @@
 	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
 	dev->ib_dev.process_mad          = mthca_process_mad;
 
+	init_MUTEX(&dev->cap_mask_mutex);
+
 	ret = ib_register_device(&dev->ib_dev);
 	if (ret)
 		return ret;
@@ -647,8 +649,6 @@
 		}
 	}
 
-	init_MUTEX(&dev->cap_mask_mutex);
-
 	return 0;
 }
 
