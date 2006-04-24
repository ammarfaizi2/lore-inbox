Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWDXV2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWDXV2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWDXVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:46 -0400
Received: from mx.pathscale.com ([64.160.42.68]:28355 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751280AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 13] ipath - iterate over correct number of ports during
	reset
X-Mercurial-Node: 49f2286e0bdc0ee1cd237b00ce22672ea7aa928d
Message-Id: <49f2286e0bdc0ee1cd23.1145913779@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:22:59 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 1906950392f7 -r 49f2286e0bdc drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Apr 19 15:24:36 2006 -0700
@@ -1959,7 +1959,7 @@ int ipath_reset_device(int unit)
 	}
 
 	if (dd->ipath_pd)
-		for (i = 1; i < dd->ipath_portcnt; i++) {
+		for (i = 1; i < dd->ipath_cfgports; i++) {
 			if (dd->ipath_pd[i] && dd->ipath_pd[i]->port_cnt) {
 				ipath_dbg("unit %u port %d is in use "
 					  "(PID %u cmd %s), can't reset\n",
