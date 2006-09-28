Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWI1QET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWI1QET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWI1QCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:37 -0400
Received: from mx.pathscale.com ([64.160.42.68]:4534 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751926AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 23 of 28] IB/ipath - fix EEPROM read when driver is compiled
	with -Os
X-Mercurial-Node: 6a9a67c2b35aa7f6636f54663d626645a209a3ba
Message-Id: <6a9a67c2b35aa7f6636f.1159459219@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:19 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EEPROM is read via programmable I/O pins. When the driver
is compiled -Os, the CPU can speculatively read the I/O
value before it is valid.  This patch fixes the problem.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 5aea5f31529d -r 6a9a67c2b35a drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Sep 28 08:57:13 2006 -0700
@@ -187,6 +187,7 @@ static void i2c_wait_for_writes(struct i
 static void i2c_wait_for_writes(struct ipath_devdata *dd)
 {
 	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
+	rmb();
 }
 
 static void scl_out(struct ipath_devdata *dd, u8 bit)
