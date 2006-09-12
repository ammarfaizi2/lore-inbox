Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWILT34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWILT34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWILT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:29:56 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:29356 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1030362AbWILT3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:29:55 -0400
Date: Tue, 12 Sep 2006 21:29:47 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Prevent legacy io access on pmac
Message-ID: <20060912192947.GA5084@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060911115354.GA23884@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Follow up to the previous patch:

Update the return values in i8402 and parport to -ENODEV.

---
 drivers/input/serio/i8042-io.h |    2 +-
 drivers/parport/parport_pc.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc6/drivers/input/serio/i8042-io.h
===================================================================
--- linux-2.6.18-rc6.orig/drivers/input/serio/i8042-io.h
+++ linux-2.6.18-rc6/drivers/input/serio/i8042-io.h
@@ -69,7 +69,7 @@ static inline int i8042_platform_init(vo
  */
 #if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(I8042_DATA_REG))
-		return -EBUSY;
+		return -ENODEV;
 #endif
 #if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
Index: linux-2.6.18-rc6/drivers/parport/parport_pc.c
===================================================================
--- linux-2.6.18-rc6.orig/drivers/parport/parport_pc.c
+++ linux-2.6.18-rc6/drivers/parport/parport_pc.c
@@ -3376,7 +3376,7 @@ static int __init parport_pc_init(void)
 {
 #if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(PARALLEL_BASE))
-		return -EBUSY;
+		return -ENODEV;
 #endif
 	if (parse_parport_params())
 		return -EINVAL;
