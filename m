Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932965AbWF2V6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbWF2V6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932946AbWF2V6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:58:14 -0400
Received: from mx.pathscale.com ([64.160.42.68]:34959 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932878AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 39] IB/ipath - enable freeze mode when shutting down
	device
X-Mercurial-Node: fd5e733f02aceffe3434f9f4a11bdbb89a0f26b5
Message-Id: <fd5e733f02aceffe3434.1151617267@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:07 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 125471ee6c68 -r fd5e733f02ac drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1656,7 +1656,7 @@ void ipath_shutdown_device(struct ipath_
 	/* disable IBC */
 	dd->ipath_control &= ~INFINIPATH_C_LINKENABLE;
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_control,
-			 dd->ipath_control);
+			 dd->ipath_control | INFINIPATH_C_FREEZEMODE);
 
 	/*
 	 * clear SerdesEnable and turn the leds off; do this here because
