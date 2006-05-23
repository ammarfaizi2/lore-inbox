Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWEWSeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWEWSeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWEWSdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:40 -0400
Received: from mx.pathscale.com ([64.160.42.68]:8375 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751216AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 10] ipath - register as IB device owner
X-Mercurial-Node: 551717ecc3dbd997fc6492454092b275935c58c1
Message-Id: <551717ecc3dbd997fc64.1148409156@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:36 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an oops.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 8d87788e21b1 -r 551717ecc3db drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Tue May 23 11:29:16 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Tue May 23 11:29:16 2006 -0700
@@ -951,6 +951,7 @@ static void *ipath_register_ib_device(in
 	idev->dd = dd;
 
 	strlcpy(dev->name, "ipath%d", IB_DEVICE_NAME_MAX);
+	dev->owner = THIS_MODULE;
 	dev->node_guid = ipath_layer_get_guid(dd);
 	dev->uverbs_abi_ver = IPATH_UVERBS_ABI_VERSION;
 	dev->uverbs_cmd_mask =
