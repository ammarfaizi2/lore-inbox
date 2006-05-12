Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWELXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWELXpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWELXov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:51 -0400
Received: from mx.pathscale.com ([64.160.42.68]:64937 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932180AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 50 of 53] ipath - reduce maximum table sizes
X-Mercurial-Node: bd1de2e983db48cddab5181a29b61acceef4a106
Message-Id: <bd1de2e983db48cddab5.1147477415@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:35 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Decrease the number of WRs and SGEs we support from 131071/255 to
16383/60.  This decreases our maximum memory usage per QP from ~1800MB
down to about 40MB.  This is still a lot, but it's better than 2GB.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 40532fdc53f0 -r bd1de2e983db drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:29 2006 -0700
@@ -73,12 +73,12 @@ module_param_named(max_cqs, ib_ipath_max
 module_param_named(max_cqs, ib_ipath_max_cqs, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_cqs, "Maximum number of completion queues to support");
 
-unsigned int ib_ipath_max_qp_wrs = 0x1FFFF;
+unsigned int ib_ipath_max_qp_wrs = 0x3FFF;
 module_param_named(max_qp_wrs, ib_ipath_max_qp_wrs, uint,
 		   S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_qp_wrs, "Maximum number of QP WRs to support");
 
-unsigned int ib_ipath_max_sges = 0xFF;
+unsigned int ib_ipath_max_sges = 0x60;
 module_param_named(max_sges, ib_ipath_max_sges, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_sges, "Maximum number of SGEs to support");
 
